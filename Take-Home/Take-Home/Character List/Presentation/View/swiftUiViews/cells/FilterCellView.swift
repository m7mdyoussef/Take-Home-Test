//
//  FilterCellView.swift
//  TakeHome
//
//  Created by JOE on 28/08/2024.
//

import SwiftUI

struct FilterCellView: View {
    var filterName: String
    var isSelected: Bool

    var body: some View {
        
        CharacterText(text: filterName, color: .heavyTextColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.gray, lineWidth: 1)
                    .fill(isSelected ? Color.blue.opacity(0.2) : Color.clear)
            )
    }
}
