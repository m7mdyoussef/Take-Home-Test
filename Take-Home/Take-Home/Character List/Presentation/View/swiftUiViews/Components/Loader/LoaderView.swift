//
//  LoaderView.swift
//  TakeHome
//
//  Created by JOE on 30/08/2024.
//

import SwiftUI

struct LoaderView: View {
    var isLoading: Bool

    var body: some View {
        if isLoading {
            VStack(spacing: 8){
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5)
                CharacterText(text: Constants.ProgressComponents.loading, fontSize: 16, color: .gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.3))
            .edgesIgnoringSafeArea(.all)
        }
    }
}
