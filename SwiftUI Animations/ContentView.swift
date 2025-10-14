//
//  ContentView.swift
//  SwiftUI Animations
//
//  Created by Rion on 9.10.25.
//

import SwiftUI


struct AnimationExample: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let destination: AnyView
}

// MARK: - Example Animations
let animationExamples: [AnimationExample] = [
    AnimationExample(name: "Advanced Bouncing Balls", icon: "circle.grid.cross", destination: AnyView(AdvancedBouncingBallView())),
    AnimationExample(name: "Pulsing Rings", icon: "rays", destination: AnyView(PulsingRatingView())),
    AnimationExample(name: "Rotating Squares", icon: "square.grid.3x3.fill", destination: AnyView(AdvancedBouncingBallView())),
    AnimationExample(name: "Sliding Gradient", icon: "waveform.path.ecg", destination: AnyView(BouncingBallView())),
    AnimationExample(name: "Gravity Gradient", icon: "waveform.path.ecg", destination: AnyView(GravityOrbsView()))
]


struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(AnimationDemo.allCases, id: \.self) { demo in
                        NavigationLink(destination: demo.destinationView) {
                            AnimationListRow(demo: demo)
                                .padding(.top,30)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .background(
                LinearGradient(colors: [.white, .indigo.opacity(0.9),.cyan,.black],
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()
            )
            .navigationTitle("Rion's Aniamtion")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.white)
        }
    }
}

enum AnimationDemo: String, CaseIterable {
    case bouncingBalls = "Bouncing Balls"
    case gravityOrbs = "Gravity Orbs"
    case pulseEffect = "Pulse Effect"
    case bouncingball = "Bouncing ball"
    case reactandcricelanim = "Circle & Rect Ball"
    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .bouncingBalls:
            AdvancedBouncingBallView()
        case .gravityOrbs:
            GravityOrbsView()
        case .pulseEffect:
            PulsingRatingView()
        case .bouncingball:
            BouncingBallView()
        case .reactandcricelanim:
            RectangleAnimation()
        }
    }
    
    var gradient: [Color] {
        switch self {
        case .bouncingBalls: return [.blue, .purple]
        case .gravityOrbs: return [.green, .teal]
        case .pulseEffect: return [.pink, .orange]
        case .bouncingball: return [.blue,.cyan]
        case .reactandcricelanim: return [.cyan,.green]
        }
    }
}

// MARK: - Custom Card Row
struct AnimationListRow: View {
    let demo: AnimationDemo
    @State private var pressed = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(colors: demo.gradient,
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .shadow(color: demo.gradient.last!.opacity(0.4),
                        radius: 8, x: 0, y: 6)

            HStack {
                Text(demo.rawValue)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Image(systemName: "chevron.right.circle.fill")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.trailing)
            }
        }
        .frame(height: 80)
        .scaleEffect(pressed ? 0.97 : 1)
        .animation(.spring(response: 0.3, dampingFraction: 0.6),
                   value: pressed)
        .onLongPressGesture(minimumDuration: 0.1, pressing: { pressing in
            pressed = pressing
        }, perform: {})
    }
}


#Preview {
    ContentView()
}
