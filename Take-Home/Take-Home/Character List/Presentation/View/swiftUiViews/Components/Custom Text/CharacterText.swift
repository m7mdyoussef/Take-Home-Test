
import SwiftUI

struct CharacterText: View {
    var text: String
    var fontSize: CGFloat = 14
    var color: Color = .primary
    var weight: Font.Weight = .regular
    var body: some View {
        Text(text)
            .font(.system(size: fontSize))
            .foregroundColor(color)
            .fontWeight(weight)
    }
}

