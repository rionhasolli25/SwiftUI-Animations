//
//  RectangleAnimation.swift
//  SwiftUI Animations
//
//  Created by Rion on 14.10.25.
//

import SwiftUI

struct RectangleAnimation: View {
    @State private var ballOffset : CGFloat = 0
    @State private var animate : Bool = false
    
    @State private var circleOffset: CGFloat = 0
    @State private var circleAnimating = false
    
    
    @State private var anothercircleOffset: CGFloat = 0
    @State private var anothercircleAnimating = false
    
    @State private var anotherrectballOffset : CGFloat = 0
    @State private var anotherrectanimate : Bool = false
    
    @State private var animationTask: DispatchWorkItem? = nil
    
    
    @State private var attractor: CGPoint? = nil 
    let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.blue)
                        .frame(width: 150, height: 100)
                        .position(x: 100, y: geo.size.height - 200 + ballOffset )
                        .shadow(color: .green.opacity(0.5), radius: 12, x: 5, y: 5) // shadow added
                        .offset(y:ballOffset)
                        .onTapGesture {
                            bounceBall()
                        }
                    
                    Circle()
                        .fill(.green)
                        .frame(width: 150, height: 100)
                        .position(x: 300, y: geo.size.height - 200 + circleOffset)
                        .shadow(color: .green.opacity(0.5), radius: 10, x: 5, y: 5) // shadow added
                        .offset(y: circleOffset)
                        .onTapGesture {
                            if circleAnimating {
                                stopCircleAnimation()
                            }
                            else{
                                bounceballdown()
                            }
                        }
                
                        Circle()
                            .fill(.cyan)
                            .frame(width: 150, height: 100)
                            .position(x: 300, y: geo.size.height - 500 + anothercircleOffset)
                            .offset(y: anothercircleOffset)
                            .shadow(color: .cyan.opacity(0.5), radius: 12, x: 5, y: 5) // shadow added
                            .onTapGesture {
                                bounceanotherballdown()
                            }
                
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.orange)
                            .frame(width: 150, height: 100)
                            .position(x: 100, y: geo.size.height - 500 + anotherrectballOffset )
                            .shadow(color: .orange.opacity(0.5), radius: 12, x: 5, y: 5) // shadow added
                            .offset(y:anotherrectballOffset)
                            .onTapGesture {
                                bouncerect()
                    }
                           
                        }
            .background(
                LinearGradient(colors: [.black,.cyan,.brown,.yellow,.accentColor],
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()
            )}
                }
           
        

        func bounceBall(){
            guard !animate else {return}
            animate = true
            
            withAnimation(.easeOut(duration:0.3)) {
                ballOffset = -150
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.interpolatingSpring(stiffness:100,damping:5)){
                    ballOffset = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    animate = false
                }
            }
        }
     func bouncerect(){
        guard !anotherrectanimate else {return}
        anotherrectanimate = true
        
        withAnimation(.easeOut(duration:0.3)) {
            anotherrectballOffset = -150
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.interpolatingSpring(stiffness:100,damping:5)){
                anotherrectballOffset = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                anotherrectanimate = false
            }
        }
    }
        func bounceballdown(){
            guard !circleAnimating else { return }
            circleAnimating = true
            
        
            withAnimation(.easeInOut(duration: 0.3)) {
                circleOffset = -200
            }
            
            // Create a cancellable bounce task
            let task = DispatchWorkItem {
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 6)) {
                    circleOffset = 0
                }
                
                // Stop animation after it returns
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    circleAnimating = false
                }
            }
            
            animationTask = task
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: task)
        }
    func bounceanotherballdown(){
        guard !anothercircleAnimating else { return }
        anothercircleAnimating = true
        

        withAnimation(.easeInOut(duration: 0.3)) {
            anothercircleOffset = -250
        }
    
        let task = DispatchWorkItem {
            withAnimation(.interpolatingSpring(stiffness: 50, damping: 6)) {
                anothercircleOffset = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                anothercircleAnimating = false
            }
        }
        
        animationTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: task)
    }
        func stopCircleAnimation() {
            withAnimation(.linear(duration: 0.1)) {
                circleOffset = 0
            }
            circleAnimating = false
        }
    }

#Preview {
    RectangleAnimation()
}
