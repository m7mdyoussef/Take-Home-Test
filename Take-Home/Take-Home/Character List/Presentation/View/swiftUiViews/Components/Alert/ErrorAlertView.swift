//
//  ErrorAlertView.swift
//  TakeHome
//
//  Created by JOE on 30/08/2024.
//

import SwiftUI

class AlertManager: ObservableObject {
    @Published var isVisible: Bool = false
    @Published var message: String = ""
}

struct ErrorAlertView: View {
    @ObservedObject var alertManager: AlertManager
    var onDismiss: () -> Void

    var body: some View {
        Group {
            if alertManager.isVisible {
                VStack {
                    VStack(spacing: 16) {
                        
                        CharacterText(text: Constants.Alert.error, fontSize: 30, color: .white, weight: .bold)
                            .multilineTextAlignment(.center)
                        
                        CharacterText(text: alertManager.message, fontSize: 18, color: .white, weight: .medium)
                            .multilineTextAlignment(.center)
                            .padding()

                        Button(action: {
                            onDismiss()
                        }) {
                            
                            CharacterText(text: Constants.Alert.retry, fontSize: 24, color: .red, weight: .bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
