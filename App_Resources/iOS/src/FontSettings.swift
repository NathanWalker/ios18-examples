import SwiftUI

/// A class to manage font settings for a given text, including font sizes, weights, and widths for each character.
class FontSettings: ObservableObject {
    @Published var fontSizes: [CGFloat] // Stores the font size for each character
    @Published var fontWeights: [Font.Weight] // Stores the font weight for each character
    @Published var fontWidths: [Font.Width] // Stores the font width for each character

    init(text: String, targetFontSize: CGFloat, targetFontWeight: Font.Weight, targetFontWidth: Font.Width) {
        // Initializes the font size, weight, and width for each character
        self.fontSizes = Array(repeating: targetFontSize, count: 100)
        self.fontWeights = Array(repeating: targetFontWeight, count: 100)
        self.fontWidths = Array(repeating: targetFontWidth, count: 100)
    }
}