//
//  todo_appApp.swift
//  todo-app
//
//  Created by Frederik Handberg on 10/09/2025.
//

import SwiftUI

@main
struct todo_appApp: App {
    @StateObject private var taskViewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup("My Little Todo App") {
            ContentView()
                .environmentObject(taskViewModel)
                .frame(minWidth: 450, minHeight: 550)
        }
        .defaultSize(width: 450, height: 550)
        
        Window("Add New Task", id: "add-task") {
            AddTaskView()
                .environmentObject(taskViewModel)
                .frame(minWidth: 450, minHeight: 650)
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 450, height: 650)
    }
}
