//
//  CharacterCellView.swift
//  TakeHome
//
//  Created by JOE on 28/08/2024.
//

import SwiftUI

struct CharacterCellView: View {
    let character: Character

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
        AsyncImageView(urlString: character.image, targetSize: CGSize(width: 70, height: 70))
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                CharacterText(text: character.name ?? "", fontSize: 16, color: .heavyText, weight: .semibold)
                
                CharacterText(text: character.species ?? "", color: .meduimText, weight: .medium)

                Spacer()
            }

            Spacer()
        }
        .padding()
        .background(cellBackgroundColor)
        .cornerRadius(12)
        .overlay(
            // Apply stroke only for "Unknown" status
            RoundedRectangle(cornerRadius: 12)
                .stroke(cellStrokeColor, lineWidth: cellStrokeWidth)
        )
    }
    
    // Determine the cell background color based on character status
    private var cellBackgroundColor: Color {
        guard let status = character.status.map({ CharacterStatus(rawValue: $0.capitalized) }) else {
            return Color.clear
        }
        
        switch status {
        case .dead:
            return Color.dead
        case .alive:
            return Color.alive
        case .unknown:
            return Color.white
        default:
            return Color.clear
        }
    }
    
    // Determine the stroke color based on status
    private var cellStrokeColor: Color {
        guard let status = character.status.map({ CharacterStatus(rawValue: $0.capitalized) }) else {
            return Color.clear
        }
        
        return status == .unknown ? Color.gray.opacity(0.2) : Color.clear
    }
    
    // Determine the stroke width based on status
    private var cellStrokeWidth: CGFloat {
        guard let status = character.status.map({ CharacterStatus(rawValue: $0.capitalized) }) else {
            return 0
        }
        return status == .unknown ? 1 : 0
    }
}


