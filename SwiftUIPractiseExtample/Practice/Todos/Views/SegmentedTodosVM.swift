//
//  SegmentedTodosVM.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/06/18.
//
import Foundation

@MainActor
final class SegmentedTodosVM: ObservableObject {
    
    private let networkManager = NetworkManager()
    @Published private(set) var todoResponse = [TodoModel]()
    
    init() {
        requestTodos()
    }
    
    /// todo 데이터 요청
    private func requestTodos() {
        Task {
            do {
                let api = TypiCodeAPI.todo
                let model = try await networkManager.request(request: api, model: [TodoModel].self)
                todoResponse = model
                print("requestTodos() Success")
                
            } catch {
                print("Error in requestTodos()")
            }
        }
    }
}
