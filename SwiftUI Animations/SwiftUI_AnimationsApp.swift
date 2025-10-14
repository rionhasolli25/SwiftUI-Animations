//
//  SwiftUI_AnimationsApp.swift
//  SwiftUI Animations
//
//  Created by Rion on 9.10.25.
//

import SwiftUI

@main
struct SwiftUI_AnimationsApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
                          .modelContainer(for: User.self)
        }
    }
}
