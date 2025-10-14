//
//  BouncingBallView.swift
//  SwiftUI Animations
//
//  Created by Rion on 9.10.25.
//

import SwiftUI

struct BouncingBallView: View {
    
    @State private var ballOffset : CGFloat = 0
    @State private var isBouncing = false
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                Spacer()
                
                Circle()
                    .fill(LinearGradient(colors: [.blue,.green], startPoint: .top, endPoint: .bottom))
                    .frame(width: 100,height: 100)
                    .offset(y:ballOffset)
                    .shadow(radius: 5)
                    .onTapGesture {
                        bounceBall()
                    }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.1))
            .animation(.easeInOut(duration: 0.3), value: ballOffset)
        }
       
    }
    func bounceBall(){
        guard !isBouncing else {return}
        isBouncing = true
        
            withAnimation(.easeOut(duration:0.3)) {
                ballOffset = -150
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.interpolatingSpring(stiffness:100,damping:5)){
                ballOffset = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            isBouncing = false
           }
        }
    }
}

struct BallState {
    var position: CGPoint
    var velocity: CGSize = .zero
    var isDragging = false
}

struct AdvancedBouncingBallView: View {
    @State private var ball1 = CGPoint(x: UIScreen.main.bounds.width / 3, y: 200)
    @State private var ball2 = CGPoint(x: UIScreen.main.bounds.width / 1.5, y: 200)
    @State private var velocity1 = CGSize(width: 0, height: 0)
    @State private var velocity2 = CGSize(width: 0, height: 0)
    @State private var isDragging1 = false
    @State private var isDragging2 = false
    @State private var gravity: CGFloat = 1.5
    @State private var timer: Timer?

    let ballSize: CGFloat = 80
    let groundHeight: CGFloat = UIScreen.main.bounds.height - 150

    var body: some View {
        ZStack {
     

          
            Circle()
                .fill(RadialGradient(colors: [.blue, .green], center: .center, startRadius: 5, endRadius: 50))
                .frame(width: ballSize, height: ballSize)
                .shadow(color: .green.opacity(0.5), radius: 10)
                .position(ball1)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging1 = true
                            ball1 = value.location
                        }
                        .onEnded { _ in
                            isDragging1 = false
                        }
                )

      
            Circle()
                .fill(RadialGradient(colors: [.orange, .red], center: .center, startRadius: 5, endRadius: 50))
                .frame(width: ballSize, height: ballSize)
                .shadow(color: .red.opacity(0.5), radius: 10)
                .position(ball2)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging2 = true
                            ball2 = value.location
                        }
                        .onEnded { _ in
                            isDragging2 = false
                        }
                )
        }
        .onAppear { startPhysics() }
        .onDisappear { timer?.invalidate() }
        
    }


    func startPhysics() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            if !isDragging1 { updateBall(&ball1, &velocity1) }
            if !isDragging2 { updateBall(&ball2, &velocity2) }
        }
    }
    func updateBall(_ ball: inout CGPoint, _ velocity: inout CGSize) {
        velocity.height += gravity
        ball.y += velocity.height
        if ball.y + ballSize / 2 >= groundHeight {
            ball.y = groundHeight - ballSize / 2
            velocity.height *= -0.7
        }
    }
}
#Preview {
    AdvancedBouncingBallView()
}


