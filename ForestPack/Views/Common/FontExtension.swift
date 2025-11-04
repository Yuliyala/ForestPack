import SwiftUI
import UIKit

extension Font {
    static func forestPack(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .custom("Konkhmer Sleokchher", size: size)
            .weight(weight)
    }
}

extension Text {
    func lineHeight(_ lineHeight: CGFloat, fontSize: CGFloat = 22) -> some View {
        self.modifier(LineHeightModifier(lineHeight: lineHeight, fontSize: fontSize))
    }
}

struct LineHeightModifier: ViewModifier {
    let lineHeight: CGFloat
    let fontSize: CGFloat
    
    init(lineHeight: CGFloat, fontSize: CGFloat = 22) {
        self.lineHeight = lineHeight
        self.fontSize = fontSize
    }
    
    func body(content: Content) -> some View {
        content
            .lineSpacing(lineHeight - fontSize) // lineSpacing = lineHeight - fontSize
    }
}


