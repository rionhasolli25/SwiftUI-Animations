//
//  LoginView.swift
//  SwiftUI Animations
//
//  Created by Rion on 10.10.25.
//
import SwiftData

import SwiftUI

struct LoginView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var auth = AuthViewModel()
    @State private var navigateToHome = false

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

                VStack(spacing: 50) {
                 
                    VStack{
                        Text("Welcome Back")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        Text("Login to continue")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.headline)
                    }

                 
                    VStack(spacing: 20) {
                        TextField("Username", text: $auth.username)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)

                        SecureField("Password", text: $auth.password)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.white)

                        // MARK: - Login Button
                        Button(action: {
                            auth.login()
                            if auth.isLoggedIn {
                                navigateToHome = true
                            }
                        }) {
                            Text("Login")
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
                        .scaleEffect(auth.isLoggedIn ? 1.0 : 1.0)
                        .animation(.spring(), value: auth.isLoggedIn)

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

                    // MARK: - Navigation Links
                    HStack {
                        NavigationLink("Create Account", destination: RegisterView(auth: auth))
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                        Spacer()
                        NavigationLink("Forgot Password?", destination: RecoverPasswordView(auth: auth))
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, 30)

                    Spacer()
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
            }
            .navigationDestination(isPresented: $navigateToHome) {
                ContentView()
                    .toolbar(.hidden, for: .navigationBar)
                    .navigationBarBackButtonHidden(true)
            }
            .onAppear { auth.attach(context: context) }
        }
    }
}

#Preview {
    LoginView()
        .modelContainer(for: User.self)
}
