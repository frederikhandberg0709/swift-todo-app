//
//  ContentView.swift
//  todo-app
//
//  Created by Frederik Handberg on 10/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Task Tracker")
                .font(.title)
            
            HStack {
                Search()
                
                AddTaskBtn()
            }
            
//            HStack(alignment: .center) {
//                HStack {
//                    TextField("Start writing and press enter to create task...", text: $newTodoText)
//                        .textFieldStyle(.plain)
//                        .autocorrectionDisabled()
//                        .focused($isFocusedTextField)
//                        .onSubmit { addTask() }
//                        .onExitCommand {
//                            isFocusedTextField = false
//                        }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.vertical, 12)
//                .padding(.leading, 12)
//                .contentShape(Rectangle())
//                .onTapGesture { isFocusedTextField = true }
//                .pointerStyle(.horizontalText)
//                    
//                Button(action: addTask) {
//                    Image(systemName: "plus")
//                        .padding(.horizontal, 9)
//                        .padding(.vertical, 9)
//                        .contentShape(Rectangle())
//                }
//                .buttonStyle(.plain)
//                .background(isHoveringAddButton ? Color.white.opacity(0.25) : Color.white.opacity(0.15))
//                .cornerRadius(8)
//                .onHover{ hover in
//                    isHoveringAddButton = hover
//                }
//                .padding(.trailing, 4)
//            }
//            .background(isHoveringSearch || isFocusedTextField ? Color.white.opacity(0.15) : Color.white.opacity(0.10))
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.white.opacity(0.20), lineWidth: 1.5)
//            )
//            .cornerRadius(8)
//            .onHover{ hover in
//                isHoveringSearch = hover
//            }
            
             
            TaskList()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
