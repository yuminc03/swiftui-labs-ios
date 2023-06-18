//
//  SegmentedTodosVM.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/06/18.
//
import Foundation

@MainActor
final class SegmentedTodosVM {
    
    private let networkManager = NetworkManager()
    @Published private(set) var todoResponse: Result<TodosModel, NetworkError>?
    
    /// todo 데이터 요청
    func requestTodos() {
        Task {
            do {
                let api = TypiCodeAPI.todo
                let model = try await networkManager.request(request: api, model: TodosModel.self)
                todoResponse = .success(model)
                
            } catch let error as NetworkError {
                todoResponse = .failure(error)
            } catch {
                todoResponse = .failure(.unknown)
            }
        }
    }
}
