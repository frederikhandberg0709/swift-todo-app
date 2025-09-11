//
//  Task.swift
//  todo-app
//
//  Created by Frederik Handberg on 11/09/2025.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var searchText: String = ""
    
    
}
