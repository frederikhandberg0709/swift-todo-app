//
//  Button.swift
//  todo-app
//
//  Created by Frederik Handberg on 13/09/2025.
//

import SwiftUI

protocol ButtonStyleConfiguration {
    var gradient: LinearGradient { get }
    var cornerRadius: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var fontSize: CGFloat { get }
    var fontWeight: Font.Weight { get }
    var foregroundColor: Color { get }
    var shadowColor: Color { get }
    var hoverScale: CGFloat { get }
    var pressScale: CGFloat { get }
}

struct PrimaryButton: ButtonStyleConfiguration {
    var gradient = LinearGradient(
        colors: [
            Color(red: 0.2, green: 0.5, blue: 1.0),
            Color(red: 0.1, green: 0.3, blue: 0.9)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    var cornerRadius: CGFloat = 12
    var horizontalPadding: CGFloat = 24
    var verticalPadding: CGFloat = 12
    var fontSize: CGFloat = 16
    var fontWeight: Font.Weight = .medium
    var foregroundColor: Color = .white
    var shadowColor: Color = .blue
    var hoverScale: CGFloat = 1.05
    var pressScale: CGFloat = 0.95
}

struct DangerButton: ButtonStyleConfiguration {
    var gradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 1.0, green: 0.373, blue: 0.341),
                Color(red: 216/255.0, green: 0.0, blue: 0.0)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    var cornerRadius: CGFloat = 12
    var horizontalPadding: CGFloat = 24
    var verticalPadding: CGFloat = 12
    var fontSize: CGFloat = 16
    var fontWeight: Font.Weight = .medium
    var foregroundColor: Color = .white
    var shadowColor: Color = .red
    var hoverScale: CGFloat = 1.05
    var pressScale: CGFloat = 0.95
}

struct ButtonView: View {
    let title: String
    let action: () -> Void
    let style: ButtonStyleConfiguration
    let isEnabled: Bool
    
    @State private var isHovered = false
    @State private var isPressed = false
    
    init(
        title: String,
        style: ButtonStyleConfiguration = PrimaryButton(),
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.isEnabled = isEnabled
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
                Text(title)
                    .font(.system(size: style.fontSize, weight: style.fontWeight))
                    .foregroundColor(style.foregroundColor)
                    .padding(.horizontal, style.horizontalPadding)
                    .padding(.vertical, style.verticalPadding)
                    .background(
                        RoundedRectangle(cornerRadius: style.cornerRadius)
                            .fill(style.gradient)
                            .shadow(
                                color: style.shadowColor.opacity(isHovered ? 0.4 : 0.2),
                                radius: isHovered ? 8 : 4,
                                x: 0,
                                y: isHovered ? 4 : 2
                            )
                    )
                    .scaleEffect(isPressed ? style.pressScale : (isHovered ? style.hoverScale : 1.0))
                    .animation(.easeInOut(duration: 0.2), value: isHovered)
                    .animation(.easeInOut(duration: 0.15), value: isPressed)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(!isEnabled)
            .onHover { hovering in
                if isEnabled {
                    isHovered = hovering
                }
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if isEnabled {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        if isEnabled {
                            isPressed = false
                        }
                    }
            )
    }
}

#Preview {
    VStack(spacing: 40) {
        ButtonView(title: "Primary Button", style: PrimaryButton(), isEnabled: false) {
            
        }
        
        ButtonView(title: "Danger Button", style: DangerButton()) {
            
        }
    }
    .padding(50)
}
