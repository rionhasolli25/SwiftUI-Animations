//
//  Model.swift
//  SwiftUI Animations
//
//  Created by Rion on 10.10.25.
//

import SwiftData

@Model
class User{
    var username: String
        var password: String
        var email: String
    
    init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
    }
}
