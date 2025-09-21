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
    @Published var editTask: Task? = nil
    
    init() {
        tasks.append(Task(title: "Buy groceries", description: "Milk, eggs, bread"))
        tasks.append(Task(title: "Read a book", description: nil))
        tasks.append(Task(title: "Call the doctor", description: "Appointment on Monday"))
        
        tasks.append(Task(title: "Organize closet", description: "Get rid of clothes I no longer wear", isCompleted: true))
    }
    
    func addTask(title: String, description: String? = nil, deadline: Date? = nil, reminder: Date? = nil) {
        let newTask = Task(title: title, description: description, deadline: deadline, reminder: reminder)
        tasks.append(newTask)
    }
    
    func update(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
        editTask = nil
    }
    
    func setEditTask(_ task: Task) {
        editTask = task
    }
    
    func clearEditTask() {
        editTask = nil
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
