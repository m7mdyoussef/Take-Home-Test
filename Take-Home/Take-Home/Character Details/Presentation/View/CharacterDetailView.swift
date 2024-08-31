//
//  CharacterDetailView.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    let coordinator: CoordinatorProtocol

    var body: some View {
        
        VStack(alignment: .leading){
            imageSection
            
            VStack(alignment: .leading, spacing: 8){
                HStack {
                    CharacterText(text: character.name ?? "", fontSize: 26, color: .heavyText, weight: .semibold)
                        .lineLimit(2, reservesSpace: false)
                    Spacer()
                    CharacterText(text: character.status ?? "", fontSize: 16, color: .heavyText, weight: .medium)
                                  .padding(.vertical, 6)
                                  .padding(.horizontal, 14)
                                  .background(Color.status)
                                  .clipShape(Capsule())
                }
                HStack(spacing: 0) {
                    CharacterText(text: "\(character.species ?? "") • ", fontSize: 18, color: .meduimText, weight: .semibold)
                    CharacterText(text: "\(character.gender ?? "")", fontSize: 18, color: .lighttext, weight: .semibold)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            HStack(spacing: 0) {
                CharacterText(text: Constants.CharacterDetails.location, fontSize: 18, color: .heavyText, weight: .semibold)
                CharacterText(text: character.location?.name ?? "" , fontSize: 18, color: .meduimText, weight: .semibold)
            }
            .padding(.horizontal, 16)

            
            Spacer()
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            backButton
        }
        .navigationBarHidden(true)
    }
}


extension CharacterDetailView{
    
    private var backButton: some View {
        Button{
            coordinator.dismiss()
        } label: {
            Image(uiImage: .backButton)
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .clipShape(Circle())
                .shadow(radius: 4)
                .padding()
        }
    }
    
    private var imageSection : some View{
        
        AsyncImageView(urlString: character.image, targetSize: CGSize(width: 70, height: 70))
            .frame(maxWidth: UIScreen.main.bounds.width)
            .frame(height: UIScreen.main.bounds.height * 0.45)
            .cornerRadius(40)
            .clipped()
    }
}

