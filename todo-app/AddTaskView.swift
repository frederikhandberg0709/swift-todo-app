//
//  AddTaskWindow.swift
//  todo-app
//
//  Created by Frederik Handberg on 11/09/2025.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State private var newTodoTitle: String = ""
    @State private var newTodoDescription: String = ""
    
    private func addTask() {
        let trimmedTitle = newTodoTitle.trimmingCharacters(in: .whitespaces)
        if !trimmedTitle.isEmpty {
            taskViewModel.tasks.append(Task(title: trimmedTitle, description: newTodoDescription))
            newTodoTitle = ""
            newTodoDescription = ""
        }
    }
    
    var body: some View {
        VStack {
            TextField("Title of task...", text: $newTodoTitle)
            
            TextField("Description...", text: $newTodoDescription)
            
            Button(action: addTask) {
                Text("Add")
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AddTaskView()
}
