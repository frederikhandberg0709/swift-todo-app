//
//  CustomDateTimePicker.swift
//  todo-app
//
//  Created by Frederik Handberg on 21/09/2025.
//

import SwiftUI

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
