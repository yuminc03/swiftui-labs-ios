//
//  SearchView.swift
//  Search
//
//  Created by Yumin Chu on 2023/11/02.
//

import SwiftUI

import ComposableArchitecture

struct SearchCore: Reducer {
  struct State: Equatable {
    let readMe = "This application demonstrates live-searching with the Composable Architecture. As you type the events are debounced for 300ms, and when you stop typing an API request is made to load locations. Then tapping on a location will load weather."
    var searchQuery = ""
    var results: [GeocodingSearch.Result] = []
    var inFlightResult: GeocodingSearch.Result?
    var weather: Weather?
    
    struct Weather: Equatable {
      let id: GeocodingSearch.Result.ID
      let days: [Day]
      
      struct Day: Equatable {
        let date: Date
        let temperatureMax: Double
        let temperatureMaxUnit: String
        let temperatureMin: Double
        let temperatureMinUnit: String
      }
    }
  }
  
  enum Action {
    case didChangedSearchQuery(String)
    case didTapSearchButton(GeocodingSearch.Result)
    case searchQueryChangeDebounded
    case searchResponse(TaskResult<GeocodingSearch>)
    case forecastResponse(GeocodingSearch.Result.ID, TaskResult<Forecast>)
  }
  
  @Dependency(\.weatherClient) var weatherClient
  private enum CancelID {
    case location
    case weather
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .didChangedSearchQuery(query):
      state.searchQuery = query
      guard query.isEmpty == false else {
        state.results = []
        state.weather = nil
        return .cancel(id: CancelID.weather)
      }
      return .none
      
    case let .didTapSearchButton(location):
      state.inFlightResult = location
      return .run { send in
        await send(.forecastResponse(location.id, TaskResult { try await
          weatherClient.forecast(location)
        }))
      }
      .cancellable(id: CancelID.weather, cancelInFlight: true)
      
    case .searchQueryChangeDebounded:
      guard state.searchQuery.isEmpty == false else {
        return .none
      }
      
      return .run { [state] send in
        await send(.searchResponse(TaskResult { try await
          weatherClient.search(state.searchQuery)
        }))
      }
      .cancellable(id: CancelID.location)
      
    case let .searchResponse(.success(response)):
      state.results = response.results
      return .none
      
    case .searchResponse(.failure):
      state.results = []
      return .none
      
    case let .forecastResponse(id, .success(forecast)):
      state.weather = State.Weather(
        id: id,
        days: forecast.daily.time.indices.map {
          State.Weather.Day(
            date: forecast.daily.time[$0],
            temperatureMax: forecast.daily.temperatureMax[$0],
            temperatureMaxUnit: forecast.dailyUnits.temperatureMax,
            temperatureMin: forecast.daily.temperatureMin[$0],
            temperatureMinUnit: forecast.dailyUnits.temperatureMin
          )
        }
      )
      state.inFlightResult = nil
      return .none
      
    case .forecastResponse(_, .failure):
      state.weather = nil
      state.inFlightResult = nil
      return .none
    }
  }
}

struct SearchView: View {
  private let store: StoreOf<SearchCore>
  @ObservedObject private var viewStore: ViewStoreOf<SearchCore>
  
  init() {
    self.store = .init(initialState: SearchCore.State()) {
      SearchCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        Text(viewStore.readMe)
          .padding()
        
        HStack {
          Image(systemName: "magnifyingglass")
          TextField(
            "New York, San Francisco, ...",
            text: viewStore.binding(
              get: \.searchQuery,
              send: { .didChangedSearchQuery($0) }
            )
          )
          .textFieldStyle(.roundedBorder)
          .textInputAutocapitalization(.none)
          .autocorrectionDisabled(true)
        }
        .padding(.horizontal, 16)
        
        List {
          ForEach(viewStore.results) { location in
            VStack(alignment: .leading) {
              Button {
                store.send(.didTapSearchButton(location))
              } label: {
                HStack {
                  Text(location.name)
                  
                  if viewStore.inFlightResult?.id == location.id {
                    ProgressView()
                  }
                }
              }
              
              if location.id == viewStore.weather?.id {
                weatherView(locationWeather: viewStore.weather)
              }
            }
          }
        }
        
        Button("Weather API provided by Open-Meteo") {
          UIApplication.shared.open(URL(string: "https://open-meteo.com/en")!)
        }
        .foregroundColor(.gray)
        .padding(16)
      }
    }
    .navigationTitle("Search")
    .task(id: viewStore.searchQuery) {
      do {
        try await Task.sleep(for: .seconds(3))
        await viewStore.send(.searchQueryChangeDebounded).finish()
      } catch {
        print(error)
      }
    }
  }
  
  @ViewBuilder
  func weatherView(locationWeather: SearchCore.State.Weather?) -> some View {
    if let locationWeather {
      let days = locationWeather.days
        .enumerated()
        .map { index, weather in
          formattedWeather(day: weather, isToday: index == 0)
        }
      
      VStack(alignment: .leading) {
        ForEach(days, id: \.self) { day in
          Text(day)
        }
      }
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SearchView()
    }
    .previewLayout(.sizeThatFits)
  }
}

private func formattedWeather(day: SearchCore.State.Weather.Day, isToday: Bool) -> String {
  let date = isToday ? "Today" : dateFormatter.string(from: day.date).capitalized
  let min = "\(day.temperatureMin)\(day.temperatureMinUnit)"
  let max = "\(day.temperatureMax)\(day.temperatureMaxUnit)"
  return "\(date), \(min) - \(max)"
}

private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "EEEE"
  return formatter
}()
