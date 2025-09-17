//
//  TaskList.swift
//  todo-app
//
//  Created by Frederik Handberg on 11/09/2025.
//

import SwiftUI

struct TaskList: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if taskViewModel.tasks.isEmpty {
                Text("You have no tasks yet.")
                    .foregroundStyle(.secondary)
            } else {
                // TODO: Active : Completed
                // TODO: Hide completed tasks from Active list after 5 seconds of marking completed
                
                List {
                    ForEach(taskViewModel.tasks) { task in
                        VStack(alignment: .leading, spacing: 3) {
                            Text(task.title)
                                .font(.title2)
                            
                            if let description = task.description, !description.isEmpty {
                                Text(description)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                taskViewModel.deleteTask(task)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                // TODO: Edit
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                taskViewModel.toggleComplete(task)
                            } label: {
                                Label("Complete", systemImage: "checkmark.circle")
                            }
                            .tint(.green)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    TaskList()
}
