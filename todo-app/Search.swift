//
//  Search.swift
//  todo-app
//
//  Created by Frederik Handberg on 11/09/2025.
//

import SwiftUI

struct Search: View {
    @State private var searchText: String = ""
    @State private var isHoveringSearch: Bool = false
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .opacity(isHoveringSearch || isSearchFocused ? 1.0 : 0.5)
            TextField("Search...", text: $searchText)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
                .focused($isSearchFocused)
                .onExitCommand {
                    isSearchFocused = false
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 40)
        .padding(.horizontal, 12)
        .contentShape(Rectangle())
        .onTapGesture { isSearchFocused = true }
        .pointerStyle(.horizontalText)
        .background(isHoveringSearch || isSearchFocused ? Color.white.opacity(0.15) : Color.white.opacity(0.10))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white.opacity(0.20), lineWidth: 1.5)
        )
        .cornerRadius(8)
        .onHover{ hover in
            isHoveringSearch = hover
        }
    }
}

#Preview {
    Search()
}
