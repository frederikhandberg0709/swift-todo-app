//
//  AddTaskWindow.swift
//  todo-app
//
//  Created by Frederik Handberg on 11/09/2025.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var newTodoTitle: String = ""
    @State private var isHoveringTitle: Bool = false
    @FocusState private var isTitleFocused: Bool
    
    @State private var newTodoDescription: String = ""
    @State private var isHoveringDescription: Bool = false
    @FocusState private var isDescriptionFocused: Bool
    
    private func isTitleFilled() -> Bool {
        !newTodoTitle.isEmpty
    }
    
    var body: some View {
        VStack {
            Text("Add New Task")
                .font(.title)
                .fontWeight(.medium)
                .padding(.bottom, 30)
            
            VStack(spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Title")
                        .foregroundStyle(.secondary)
                        .opacity(newTodoTitle.isEmpty ? 0 : 1)
                    
                    HStack {
                        TextField("Title of task...", text: $newTodoTitle)
                            .font(.title3)
                            .textFieldStyle(.plain)
                            .autocorrectionDisabled()
                            .focused($isTitleFocused)
                            .onExitCommand {
                                isTitleFocused = false
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 45)
                    .padding(.horizontal, 12)
                    .contentShape(Rectangle())
                    .onTapGesture { isTitleFocused = true }
                    .pointerStyle(.horizontalText)
                    .background(isHoveringTitle || isTitleFocused ? Color.white.opacity(0.15) : Color.white.opacity(0.10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.20), lineWidth: 1.5)
                    )
                    .cornerRadius(12)
                    .onHover { hover in
                        isHoveringTitle = hover
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .foregroundStyle(.secondary)
                        .opacity(newTodoDescription.isEmpty ? 0 : 1)
                    
                    HStack {
                        TextEditorView(text: $newTodoDescription, placeholder: "Description of task...", fontSize: 15)
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
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.20), lineWidth: 1.5)
                    )
                    .cornerRadius(12)
                    .onHover { hover in
                        isHoveringDescription = hover
                    }
                }
            }
            
            VStack(spacing: 30) {
                ButtonView(title: "Create", style: PrimaryButton(), isEnabled: isTitleFilled()) {
                    taskViewModel.addTask(title: newTodoTitle, description: newTodoDescription)
                    
                    newTodoTitle = ""
                    newTodoDescription = ""
                    
                    dismissWindow()
                }
                
                ButtonView(title: "Go back", style: DangerButton()) {
                    dismissWindow(id: "add-task")
                }
            }
            .padding(.top, 40)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 30)
    }
}

#Preview {
    AddTaskView()
}
