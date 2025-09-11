//
//  AddTask.swift
//  todo-app
//
//  Created by Frederik Handberg on 11/09/2025.
//

import SwiftUI

struct AddTaskBtn: View {
    @State private var isHoveringAddButton: Bool = false
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        Button(action: { openWindow(id: "add-task") }) {
            Image(systemName: "plus")
                .frame(width: 40, height: 40)
                .contentShape(Rectangle())
                .opacity(isHoveringAddButton ? 1.0 : 0.5)
                .background(isHoveringAddButton ? Color.white.opacity(0.15) : Color.white.opacity(0.10))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white.opacity(0.20), lineWidth: 1.5)
                )
        }
        .buttonStyle(.plain)
        .cornerRadius(8)
        .onHover{ hover in
            isHoveringAddButton = hover
        }
    }
}

#Preview {
    AddTaskBtn()
}
