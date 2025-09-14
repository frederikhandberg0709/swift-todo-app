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
            
            HStack(spacing: 15) {
                Search()
                
                AddTaskBtn()
            }
             
            TaskList()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
