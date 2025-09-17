//
//  Task.swift
//  todo-app
//
//  Created by Frederik Handberg on 11/09/2025.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var searchText: String = ""
    
    func addTask(title: String, description: String? = nil) {
        let newTask = Task(title: title, description: description)
        tasks.append(newTask)
    }
    
    func editTask(_ task: Task, title: String, description: String?) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].title = title
            tasks[index].description = description
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
    
    func toggleComplete(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}
