//
//  RecoverPasswordView.swift
//  SwiftUI Animations
//
//  Created by Rion on 10.10.25.
//

import SwiftUI

struct RecoverPasswordView: View {
    @ObservedObject var auth: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var email = ""

    var body: some View {
        NavigationStack {
            ZStack {
             
                LinearGradient(
                    gradient: Gradient(colors: [Color.cyan.opacity(0.8), Color.blue.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 40) {
                    // MARK: - Title
                    VStack {
                        Text("Recover Password")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        Text("Enter your email to reset password")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.headline)
                    }

                    // MARK: - Form Card
                    VStack(spacing: 20) {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)

                        // Recover Button
                        Button(action: {
                            auth.recoverPassword(for: email)
                        }) {
                            Text("Recover")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(
                                        colors: [Color.green, Color.blue,Color.purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 5)
                        }

                        // Error / Message
                        if !auth.message.isEmpty {
                            Text(auth.message)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .font(.footnote)
                                .padding(.top, 5)
                        }

                        // Close Button
                        Button(action: { dismiss() }) {
                            Text("Close")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red.opacity(1))
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(25)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)

                    Spacer()
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    RecoverPasswordView(auth: AuthViewModel())
        .modelContainer(for: User.self)
}
