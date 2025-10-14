//
//  GravityOrbitsView.swift
//  SwiftUI Animations
//
//  Created by Rion on 13.10.25.
//

import SwiftUI

//struct Orb: Identifiable {
//    let id = UUID()
//    var position: CGPoint
//    var velocity: CGSize
//    var color: Color
//}
//
//struct GravityOrbitsView: View {
//    @State private var orbs: [Orb] = (0..<10).map { _ in
//        Orb(position: CGPoint(x: CGFloat.random(in: 100...300),
//                              y: CGFloat.random(in: 200...600)),
//            velocity: CGSize.zero,
//            color: Color(hue: Double.random(in: 0...1), saturation: 0.9, brightness: 0.9))
//        
//    }
//    
//    
//    @State private var attractor: CGPoint? = nil // touch location
//    let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
//    
//    var body: some View {
//        GeometryReader{ geo in
//            ZStack{
//                LinearGradient(colors: [.black, .indigo.opacity(0.6)], startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea()
//                // Render orbs using Canvas (efficient for many particles)
//                Canvas{ context, size in
//                    for orb in orbs {
//                        var circle = Path()
//                        circle.addEllipse(in: CGRect(x: orb.position.x - 15, y: orb.position.y - 15, width: 30, height: 30))
//                        context.fill(circle, with: .color(orb.color))
//                        context.addFilter(.shadow(color: orb.color.opacity(0.6), radius: 8))
//                    }
//                }
//                // Show finger attractor (optional visual cue)
//                if let attractor = attractor{
//                    Circle()
//                        .fill(.white.opacity(0.2))
//                        .frame(width: 60, height: 60)
//                        .position(attractor)
//                        .animation(.easeOut(duration: 0.2), value: attractor)
//                }
//            }
//            .gesture(
//                
//                DragGesture(minimumDistance: 0)
//                    .onChanged{ gesture in
//                        attractor = gesture.location
//                        
//                    }
//                    .onEnded { _ in
//                        attractor = nil
//                    })
//            .onReceive(timer) { _ in
//                updateOrbs(in: geo.size)
//            }
//            
//            
//        }
//        
//    }
//    
//    
//    
//    private func updateOrbs(in size: CGSize){
//        var newOrbs = orbs
//        
//        for i in newOrbs.indices{
//            var orb = newOrbs[i]
//            
//            if let attractor = attractor{
//                let dx = attractor.x - orb.position.x
//                let dy = attractor.y - orb.position.y
//                
//                let distance = max(20,sqrt(dx*dx + dy*dy))
//                let strength = 1500 / (distance * distance) // inverse-square attraction
//                
//                orb.velocity.width += (dx / distance) * strength
//                orb.velocity.height += (dy / distance) * strength
//                
//                orb.position.x += orb.velocity.width
//                orb.position.y += orb.velocity.height
//                
//                // Bounce off edges
//                
//                if orb.position.x < 0 || orb.position.x > size.width {
//                    orb.velocity.width *= -0.8
//                    orb.position.x = min(max(orb.position.x, 0), size.width)
//                }
//                if orb.position.y < 0 || orb.position.y > size.height{
//                    orb.velocity.height *= -0.8
//                    orb.position.y = min(max(orb.position.y, 0), size.height)
//                    newOrbs[i] = orb
//                }
//                orbs = newOrbs
//            }
//        }
//    }
//}
//    #Preview {
//        GravityOrbitsView()
//    }
//

import SwiftUI

struct GravityOrbsView: View {
    // Track all orb positions and velocities
    @State private var orbs: [Orb] = (0..<10).map { _ in
        Orb(position: CGPoint(x: CGFloat.random(in: 100...300),
                              y: CGFloat.random(in: 200...600)),
            velocity: CGSize.zero,
            color: Color(hue: Double.random(in: 0...1), saturation: 0.9, brightness: 0.9))
    }
    
    @State private var attractor: CGPoint? = nil // touch location
    let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background gradient
                LinearGradient(colors: [.black, .indigo.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                // Render orbs using Canvas (efficient for many particles)
                Canvas { context, size in
                    for orb in orbs {
                        var circle = Path()
                        circle.addEllipse(in: CGRect(x: orb.position.x - 15, y: orb.position.y - 15, width: 30, height: 30))
                        context.fill(circle, with: .color(orb.color))
                        context.addFilter(.shadow(color: orb.color.opacity(0.6), radius: 8))
                    }
                }
                
                // Show finger attractor (optional visual cue)
                if let attractor = attractor {
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 60, height: 60)
                        .position(attractor)
                        .animation(.easeOut(duration: 0.2), value: attractor)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        attractor = gesture.location
                    }
                    .onEnded { _ in
                        attractor = nil
                    }
            )
            .onReceive(timer) { _ in
                updateOrbs(in: geo.size)
            }
        }
    }
    
    // MARK: - Update Orb Motion
    private func updateOrbs(in size: CGSize) {
        var newOrbs = orbs
        
        for i in newOrbs.indices {
            var orb = newOrbs[i]
            
            if let attractor = attractor {
                // Calculate attraction force toward finger
                let dx = attractor.x - orb.position.x
                let dy = attractor.y - orb.position.y
                let distance = max(20, sqrt(dx*dx + dy*dy))
                let strength = 1500 / (distance * distance) // inverse-square attraction
                
                // Update velocity
                orb.velocity.width += (dx / distance) * strength
                orb.velocity.height += (dy / distance) * strength
            }
            
            // Apply friction (slow down)
            orb.velocity.width *= 0.95
            orb.velocity.height *= 0.95
            
            // Update position
            orb.position.x += orb.velocity.width
            orb.position.y += orb.velocity.height
            
            // Bounce off edges
            if orb.position.x < 0 || orb.position.x > size.width {
                orb.velocity.width *= -0.8
                orb.position.x = min(max(orb.position.x, 0), size.width)
            }
            if orb.position.y < 0 || orb.position.y > size.height {
                orb.velocity.height *= -0.8
                orb.position.y = min(max(orb.position.y, 0), size.height)
            }
            
            newOrbs[i] = orb
        }
        orbs = newOrbs
    }
}

// MARK: - Orb Model
struct Orb: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGSize
    var color: Color
}

#Preview {
    GravityOrbsView()
}
