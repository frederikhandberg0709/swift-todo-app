//
//  EditTaskView.swift
//  todo-app
//
//  Created by Frederik Handberg on 21/09/2025.
//

import SwiftUI

struct EditTaskView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var editTodoTitle: String = ""
    @State private var isHoveringTitle: Bool = false
    @FocusState private var isTitleFocused: Bool
    
    @State private var editTodoDescription: String = ""
    @State private var isHoveringDescription: Bool = false
    @FocusState private var isDescriptionFocused: Bool
    
    
    @State private var dueDate: Date? = nil
    @State private var reminderDate: Date? = nil
    
    private var currentTask: Task? {
        taskViewModel.editTask
    }

    private func isTitleFilled() -> Bool {
        !editTodoTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func hasChanges() -> Bool {
        guard let task = currentTask else { return false }
        let titleChanged = editTodoTitle != task.title
        let descriptionChanged = editTodoDescription != (task.description ?? "")
        let dueChanged = dueDate != task.deadline
        let reminderChanged = reminderDate != task.reminder
        return titleChanged || descriptionChanged || dueChanged || reminderChanged
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Edit Task")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.bottom, 30)
                
                VStack(spacing: 15) {
                    VStack(alignment: .leading) {
                        Text("Title")
                            .foregroundStyle(.secondary)
                            .opacity(editTodoTitle.isEmpty ? 0 : 1)
                        
                        HStack {
                            TextField("Title of task...", text: $editTodoTitle)
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
                            .opacity(editTodoDescription.isEmpty ? 0 : 1)
                        
                        HStack {
                            TextEditorView(text: $editTodoDescription, placeholder: "Description of task...", fontSize: 15)
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
                    
                    VStack(alignment: .leading, spacing: 20) {
                        CustomDateTimePicker("Due Date", selection: $dueDate)
                        CustomDateTimePicker("Reminder", selection: $reminderDate)
                    }
                }
                
                VStack(spacing: 30) {
                    ButtonView(title: "Save", style: PrimaryButton(), isEnabled: isTitleFilled() && hasChanges()) {
                        guard var task = currentTask else { return }
                        
                        task.title = editTodoTitle
                        task.description = editTodoDescription
                        task.deadline = dueDate
                        task.reminder = reminderDate
                        taskViewModel.update(task: task)
                        
                        dismissWindow()
                    }
                    
                    ButtonView(title: "Go back", style: DangerButton()) {
                        dismissWindow(id: "edit-task")
                    }
                }
                .padding(.top, 40)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 30)
            .onAppear {
                if let task = currentTask {
                    editTodoTitle = task.title
                    editTodoDescription = task.description ?? ""
                    dueDate = task.deadline
                    reminderDate = task.reminder
                }
            }
        }
    }
}

#Preview {
    EditTaskView()
}
