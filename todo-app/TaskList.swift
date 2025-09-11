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
                List(taskViewModel.tasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .font(.headline)
                        
                        if (task.description != nil) {
                            Text(task.description ?? "")
                                .foregroundStyle(.secondary)
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
