//
//  AuthViewModel.swift
//  SwiftUI Animations
//
//  Created by Rion on 10.10.25.
//

import SwiftUI
import SwiftData
import SwiftData

@MainActor
class AuthViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var email = ""
    @Published var message = ""
    @Published var isLoggedIn = false
    @Published var currentUser: User?

    private var context: ModelContext?

   
    func attach(context: ModelContext) {
        self.context = context
    }

  
    func register() {
        guard let context else { return }
        do {
            let users = try context.fetch(FetchDescriptor<User>())
            if users.contains(where: { $0.username == username }) {
                message = "Username already exists!"
                return
            }
            let newUser = User(username: username, password: password, email: email)
            context.insert(newUser)
            try context.save()
            message = "Registration successful!"
        } catch {
            message = "Failed to register user: \(error.localizedDescription)"
        }
    }


    func login() {
        guard let context else { return }
        do {
            let users = try context.fetch(FetchDescriptor<User>())
            if let user = users.first(where: { $0.username == username && $0.password == password }) {
                currentUser = user
                isLoggedIn = true
                message = "Login successful!"
            } else {
                message = "Invalid credentials."
            }
        } catch {
            message = "Error: \(error.localizedDescription)"
        }
    }

  
    func logout() {
        currentUser = nil
        isLoggedIn = false
        username = ""
        password = ""
        email = ""
        message = ""
    }


    func recoverPassword(for email: String) {
        guard let context else { return }
        do {
            let users = try context.fetch(FetchDescriptor<User>())
            if let user = users.first(where: { $0.email == email }) {
                message = "Password for \(user.username) is: \(user.password)"
            } else {
                message = "Email not found!"
            }
        } catch {
            message = "Error: \(error.localizedDescription)"
        }
    }
}
