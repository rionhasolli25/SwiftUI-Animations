//
//  PulsingRatingView.swift
//  SwiftUI Animations
//
//  Created by Rion on 13.10.25.
//

import SwiftUI

struct PulsingRatingView: View {
    @State private var animate = false
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            
            Circle()
                .stroke(lineWidth: 3)
                .fill(Color.purple.opacity(0.5))
                .frame(width: 100,height: 100)
                .scaleEffect(x: animate ? 2.5 : 1)
                .opacity(animate ? 0 : 1)
                .animation(.easeOut(duration: 1.5).repeatForever(autoreverses: false),value: animate)
            
            Circle()
                .fill(Color.purple)
                .frame(width:30,height: 30)
                .shadow(color: .purple, radius: 10)
        }
        .onAppear{
            animate = true
        }
    }
}

#Preview {
    PulsingRatingView()
}
