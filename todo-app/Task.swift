//
//  Task.swift
//  todo-app
//
//  Created by Frederik Handberg on 11/09/2025.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var description: String? = nil
    var deadline: Date? = nil
    var reminder: Date? = nil
    var isCompleted: Bool = false
}
