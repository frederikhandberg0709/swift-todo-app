//
//  TaskList.swift
//  todo-app
//
//  Created by Frederik Handberg on 11/09/2025.
//

import SwiftUI

struct TaskList: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State private var selectedTab: Int = 0
    @State private var pendingStatusChange: [UUID: Bool] = [:]
    @Namespace private var animation
    
    private func toggleTaskStatus(_ task: Task) {
        pendingStatusChange[task.id] = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            taskViewModel.toggleComplete(task)
            pendingStatusChange[task.id] = false
        }
    }
    
    var filteredTasks: [Task] {
        if selectedTab == 0 {
            return taskViewModel.tasks.filter { !$0.isCompleted }
        } else {
            return taskViewModel.tasks.filter { $0.isCompleted }
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 0) {
                // Active button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = 0
                    }
                }) {
                    VStack(spacing: 8) {
                        Text("Active")
                            .font(.headline)
                            .foregroundColor(selectedTab == 0 ? .primary : .secondary)
                        
                        // Underline
                        if selectedTab == 0 {
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "underline", in: animation)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .frame(width: 100)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                // Completed button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = 1
                    }
                }) {
                    VStack(spacing: 8) {
                        Text("Completed")
                            .font(.headline)
                            .foregroundColor(selectedTab == 1 ? .primary : .secondary)
                        
                        // Underline
                        if selectedTab == 1 {
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "underline", in: animation)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .frame(width: 100)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // List of tasks
            if filteredTasks.isEmpty {
                Spacer()
                
                Text(selectedTab == 0 ? "No active tasks." : "No completed tasks.")
                    .foregroundStyle(.secondary)
                    .padding()
                
                Spacer()
            } else {
                List {
                    ForEach(filteredTasks) { task in
                        VStack(alignment: .leading, spacing: 3) {
                            Text(task.title)
                                .font(.title2)
                            
                            if let description = task.description, !description.isEmpty {
                                Text(description)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                        .opacity(pendingStatusChange[task.id] == true ? 0.3 : 1.0)
                        .contextMenu {
                            Button {
                                toggleTaskStatus(task)
                            } label: {
                                Label(task.isCompleted ? "Mark Active" : "Mark Complete", systemImage: task.isCompleted ? "arrow.uturn.backward.circle" : "checkmark.circle")
                            }
                            
                            Button {
                                // TODO: Edit
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            
                            Button(role: .destructive) {
                                // TODO: Show confirmation window before deleting
                                taskViewModel.deleteTask(task)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                taskViewModel.deleteTask(task)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                            
                            Button {
                                // TODO: Edit
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                toggleTaskStatus(task)
                            } label: {
                                Label(task.isCompleted ? "Mark Active" : "Complete",
                                      systemImage: task.isCompleted ? "arrow.uturn.backward.circle" : "checkmark.circle")
                            }
                            .tint(task.isCompleted ? .orange : .green)
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

