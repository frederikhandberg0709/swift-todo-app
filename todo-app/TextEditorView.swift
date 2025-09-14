//
//  TextEditorView.swift
//  todo-app
//
//  Created by Frederik Handberg on 13/09/2025.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var text: String
    var placeholder: String = ""
    var top: CGFloat = 10
    var bottom: CGFloat = 10
    var left: CGFloat = 0
    var right: CGFloat = 0
    var fontSize: CGFloat = NSFont.systemFontSize
    
    var body: some View {
        NSTextViewRepresentable(
            text: $text,
            placeholder: placeholder,
            insets: NSSize(width: left + right, height: top + bottom),
            nsFont: NSFont.systemFont(ofSize: fontSize)
        )
    }
}

struct NSTextViewRepresentable: NSViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var insets: NSSize
    var nsFont: NSFont
    
    func makeNSView(context: Context) -> NSScrollView {
        let scroll = NSScrollView()
        scroll.drawsBackground = false
        scroll.hasVerticalScroller = true
        scroll.autohidesScrollers = true
        
        let contentSize = scroll.contentSize
        let tv = PlaceholderTextView(frame: NSRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))
        
        tv.minSize = NSSize(width: 0, height: 0)
        tv.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        tv.isVerticallyResizable = true
        tv.isHorizontallyResizable = false
        tv.autoresizingMask = [.width, .height]
        tv.textColor = .labelColor
        tv.backgroundColor = .clear
        tv.drawsBackground = false
        tv.textContainerInset = NSSize(width: insets.width, height: insets.height/2)
        tv.textContainer?.lineFragmentPadding = 0
        tv.textContainer?.widthTracksTextView = true
        tv.textContainer?.containerSize = NSSize(width: scroll.frame.width, height: .greatestFiniteMagnitude)
        tv.font = nsFont
        tv.delegate = context.coordinator
        tv.isAutomaticSpellingCorrectionEnabled = false
        tv.isAutomaticQuoteSubstitutionEnabled = false
        tv.isAutomaticDashSubstitutionEnabled = false
        tv.isSelectable = true
        tv.isRichText = true
        tv.isEditable = true
        tv.allowsUndo = true
        
        tv.string = text
        tv.placeholderString = placeholder
        
        scroll.documentView = tv
        
        return scroll
    }

    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let tv = nsView.documentView as? PlaceholderTextView else { return }
        
        if nsView.frame.width > 0 && tv.frame.width != nsView.contentSize.width {
            tv.frame = NSRect(x: 0, y: 0, width: nsView.contentSize.width, height: tv.frame.height)
            tv.textContainer?.containerSize = NSSize(width: nsView.contentSize.width, height: CGFloat.greatestFiniteMagnitude)
        }
        
        if tv.string != text {
            tv.string = text
        }
        
        if tv.placeholderString != placeholder {
            tv.placeholderString = placeholder
        }
        
        tv.textColor = .labelColor
        tv.textContainerInset = NSSize(width: insets.width, height: insets.height/2)
        tv.font = nsFont
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }
    final class Coordinator: NSObject, NSTextViewDelegate {
        var parent: NSTextViewRepresentable
        init(_ parent: NSTextViewRepresentable) { self.parent = parent }
        
        func textDidChange(_ notification: Notification) {
            guard let tv = notification.object as? NSTextView else { return }
            
            parent.text = tv.string
        }
    }
}

class PlaceholderTextView: NSTextView {
    var placeholderString: String = "" {
        didSet {
            needsDisplay = true
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if string.isEmpty && !placeholderString.isEmpty {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font ?? NSFont.systemFont(ofSize: NSFont.systemFontSize),
                .foregroundColor: NSColor.placeholderTextColor
            ]
            
            let placeholderRect = NSRect(
                x: textContainerInset.width + textContainer!.lineFragmentPadding,
                y: textContainerInset.height,
                width: bounds.width - textContainerInset.width * 2 - textContainer!.lineFragmentPadding * 2,
                height: bounds.height - textContainerInset.height * 2
            )
            
            placeholderString.draw(in: placeholderRect, withAttributes: attributes)
        }
    }
    
    override func didChangeText() {
        super.didChangeText()
        needsDisplay = true
    }
}
