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
        WindowGroup {
            ContentView()
                .environmentObject(taskViewModel)
        }
        
        WindowGroup(id: "add-task") {
            AddTaskView()
                .environmentObject(taskViewModel)
                .frame(width: 450, height: 500)
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 450, height: 500)
    }
}
