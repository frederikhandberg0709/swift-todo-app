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
    @State private var isHoveringTitle: Bool = false
    @FocusState private var isTitleFocused: Bool
    
    @State private var newTodoDescription: String = ""
    @State private var isHoveringDescription: Bool = false
    @FocusState private var isDescriptionFocused: Bool
    
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
            VStack(spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Title")
                        .foregroundStyle(.secondary)
                        .opacity(newTodoTitle.isEmpty ? 0 : 1)
                    
                    HStack {
                        TextField("Title of task...", text: $newTodoTitle)
                            .textFieldStyle(.plain)
                            .autocorrectionDisabled()
                            .focused($isTitleFocused)
                            .onExitCommand {
                                isTitleFocused = false
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 40)
                    .padding(.horizontal, 12)
                    .contentShape(Rectangle())
                    .onTapGesture { isTitleFocused = true }
                    .pointerStyle(.horizontalText)
                    .background(isHoveringTitle || isTitleFocused ? Color.white.opacity(0.15) : Color.white.opacity(0.10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.20), lineWidth: 1.5)
                    )
                    .cornerRadius(8)
                    .onHover { hover in
                        isHoveringTitle = hover
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .foregroundStyle(.secondary)
                        .opacity(newTodoDescription.isEmpty ? 0 : 1)
                    
                    HStack {
                        TextEditorView(text: $newTodoDescription, placeholder: "Description of task...")
                            .focused($isDescriptionFocused)
                            .onExitCommand {
                                isDescriptionFocused = false
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .padding(.horizontal, 12)
                    .contentShape(Rectangle())
                    .onTapGesture { isDescriptionFocused = true }
                    .pointerStyle(.horizontalText)
                    .background(isHoveringDescription || isDescriptionFocused ? Color.white.opacity(0.15) : Color.white.opacity(0.10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.20), lineWidth: 1.5)
                    )
                    .cornerRadius(8)
                    .onHover { hover in
                        isHoveringDescription = hover
                    }
                }
            }
            
            Button(action: addTask) {
                Text("Add")
            }
            
            Button(action: {}) {
                Text("Cancel")
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AddTaskView()
}
