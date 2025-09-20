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
    
    init() {
        tasks.append(Task(title: "Buy groceries", description: "Milk, eggs, bread"))
        tasks.append(Task(title: "Read a book"))
        tasks.append(Task(title: "Call the doctor", description: "Appointment on Monday"))
        
        tasks.append(Task(title: "Organize closet", description: "Get rid of clothes I no longer wear", isCompleted: true))
    }
    
    func addTask(title: String, description: String? = nil, deadline: Date? = nil, reminder: Date? = nil) {
        let newTask = Task(title: title, description: description, deadline: deadline, reminder: reminder)
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
