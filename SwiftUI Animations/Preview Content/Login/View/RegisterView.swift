//
//  RegisterView.swift
//  SwiftUI Animations
//
//  Created by Rion on 10.10.25.
//

import SwiftUI
import SwiftData
import SwiftUI

struct RegisterView: View {
    @ObservedObject var auth: AuthViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.cyan.opacity(0.8), Color.blue.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 40) {
                    // MARK: - Title
                    VStack {
                        Text("Create Account")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        Text("Sign up to get started")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.headline)
                    }

                    // MARK: - Registration Form Card
                    VStack(spacing: 20) {
                        TextField("Username", text: $auth.username)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)

                        TextField("Email", text: $auth.email)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)

                        SecureField("Password", text: $auth.password)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.white)

                        // MARK: - Register Button
                        Button(action: {
                            auth.register()
                            dismiss()
                        }) {
                            Text("Register")
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
                                .padding()
                        }

                        // MARK: - Error Message
                        if !auth.message.isEmpty {
                            Text(auth.message)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .font(.footnote)
                                .padding(.top, 5)
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
    RegisterView(auth: AuthViewModel())
        .modelContainer(for: User.self)
}
