import SwiftUI

struct WaveShape: Shape {
    var strength: Double
    var frequency: Double
    var phase: Angle

  
    var animatableData: Double {
        get { phase.degrees }
        set { phase = .degrees(newValue) }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midHeight = rect.height / 2
        let width = rect.width
        let step = width / 200

        path.move(to: CGPoint(x: 0, y: midHeight))

        for x in stride(from: 0, through: width, by: step) {
            let relativeX = x / width
            let sine = sin(relativeX * frequency * .pi * 2 + CGFloat(phase.radians))
            let y = midHeight + CGFloat(sine) * CGFloat(strength)
            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.addLine(to: CGPoint(x: width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}

struct WaveMotionView: View {
    
    @State private var waveOffset: Angle = .degrees(0)
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Spacer()
                ZStack{
                    WaveShape(strength: 25, frequency: 10, phase: waveOffset)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.cyan.opacity(0.6), Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                        .frame(height: 180)
                        .opacity(0.9)
                        .offset(y: 10)
                    
                    WaveShape(strength: 30, frequency: 8, phase: .degrees(waveOffset.degrees + 90))
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                        .frame(height: 200)
                        .opacity(0.8)
                        .offset(y: 20)
                }
                .blur(radius: 2)
                .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: waveOffset)
            }
        }
        .onAppear{
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)){
                
                waveOffset = .degrees(360)
            }
        }
    }
       
}

#Preview {
    WaveMotionView()
}
