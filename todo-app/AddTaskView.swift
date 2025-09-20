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
    
    @State private var dueDate: Date?
    @State private var reminderDate: Date?
    
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
                
                VStack(alignment: .leading, spacing: 20) {
                    CustomDateTimePicker("Due Date", selection: $dueDate)
                    
                    CustomDateTimePicker("Reminder", selection: $reminderDate)
                }
            }
            
            VStack(spacing: 30) {
                ButtonView(title: "Create", style: PrimaryButton(), isEnabled: isTitleFilled()) {
                    taskViewModel.addTask(title: newTodoTitle, description: newTodoDescription, deadline: dueDate, reminder: reminderDate)
                    
                    newTodoTitle = ""
                    newTodoDescription = ""
                    dueDate = nil
                    reminderDate = nil
                    
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

struct CustomDateTimePicker: View {
    @Binding var selectedDate: Date?
    let title: String
    
    @State private var showingPopover = false
    @State private var tempDate = Date()
    
    init(_ title: String, selection: Binding<Date?>) {
        self.title = title
        self._selectedDate = selection
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            
            if let date = selectedDate {
                HStack {
                    Button(action: {
                        tempDate = date
                        showingPopover = true
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "calendar")
                                .foregroundColor(.accentColor)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(date, style: .date)
                                    .font(.body)
                                    .fontWeight(.medium)
                                
                                Text(date, style: .time)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(NSColor.controlBackgroundColor))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.accentColor.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        selectedDate = nil
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .font(.title3)
                    }
                    .buttonStyle(.plain)
                    .help("Remove date")
                }
            } else {
                Button(action: {
                    tempDate = Date()
                    showingPopover = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.accentColor)
                        Text("Add Date & Time")
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Color(NSColor.controlBackgroundColor))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .popover(isPresented: $showingPopover, arrowEdge: .bottom) {
            DateTimePopoverView(
                date: $tempDate,
                onSave: {
                    selectedDate = tempDate
                    showingPopover = false
                },
                onCancel: {
                    showingPopover = false
                }
            )
        }
    }
}

struct DateTimePopoverView: View {
    @Binding var date: Date
    let onSave: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            // Calendar
            Text("Date")
                .font(.headline)
                .foregroundColor(.secondary)
            
            DatePicker(
                "Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .labelsHidden()
            .frame(width: 280)
            
            Divider()
            
            // Time picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Time")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                DatePicker(
                    "Time",
                    selection: $date,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.compact)
                .labelsHidden()
            }
            
            HStack {
                Button("Cancel") {
                    onCancel()
                }
                .keyboardShortcut(.escape)
                
                Spacer()
                
                Button("Save") {
                    onSave()
                }
                .keyboardShortcut(.return)
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(16)
        .frame(width: 320)
    }
}

#Preview {
    AddTaskView()
}
