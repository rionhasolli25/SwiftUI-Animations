import SwiftUI

struct RotatingRingsView: View {
    @State private var rotate = false
    var body: some View {
        ZStack{
            LinearGradient(colors: [.cyan.opacity(0.3), .blue.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 40){
                
                ZStack{
                    ForEach(0..<2){ i in
                        RingThirdView(index: i, rotate: $rotate)
                        
                    }
                }
                ZStack{
                    ForEach(0..<3){ i in
                        RingSecondView(index: i, rotate: $rotate)
                        
                    }
                }
                
                ZStack{
                    ForEach(0..<5){i  in
                        RingView(index: i, rotate: $rotate)
                    }
                }
                
                .onAppear{
                    withAnimation(.linear(duration: 12).repeatForever(autoreverses: true)) {
                        rotate.toggle()
                    }
                    
                    
                }
            }
        }
    }
}


struct RingView : View {
    var index: Int
    @Binding var rotate : Bool
    var body: some View {
            Circle()
                .trim(from: 0.1,to: 1)
                .stroke(
                AngularGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.yellow.opacity(0.6), Color.red.opacity(0.5)]),
                center: .center
                ),
                style: StrokeStyle(lineWidth: CGFloat(10 - index), lineCap: .round)
                )
                .frame(width:CGFloat(150 + index * 20),height: CGFloat(150 + index * 20))
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .opacity(0.9 - Double(index) * 0.1)
                .animation(
                .linear(duration: Double(8 + index * 2))
                .repeatForever(autoreverses: false), value: rotate
                )
        }
  
    }

struct RingSecondView : View {
    var index: Int
    @Binding var rotate : Bool
    var body: some View {
            Circle()
            .trim(from: 0.1,to: 1)
                 .stroke(
                 AngularGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.8), Color.cyan.opacity(0.9), Color.blue.opacity(0.5)]),
                 center: .center
                 ),
                 style: StrokeStyle(lineWidth: CGFloat(10 - index), lineCap: .round)
                 )
                .frame(width:CGFloat(150 + index * 40),height: CGFloat(150 + index * 20))
                .rotationEffect(.degrees(rotate ? 0 : 360))
                .opacity(0.9 - Double(index) * 0.1)
                .animation(
                .linear(duration: Double(8 + index * 2))
                .repeatForever(autoreverses: false), value: rotate
                )
        }
  
    }


struct RingThirdView : View {
    var index: Int
    @Binding var rotate : Bool
    var body: some View {
            Circle()
            .trim(from: 0.1,to: 1)
                 .stroke(
                 AngularGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.red.opacity(0.9), Color.orange.opacity(0.5)]),
                 center: .center
                 ),
                 style: StrokeStyle(lineWidth: CGFloat(10 - index), lineCap: .round)
                 )
                .frame(width:CGFloat(150 + index * 40),height: CGFloat(150 + index * 20))
                .rotationEffect(.degrees(rotate ? 180 : -180))
                .animation(
                    .easeInOut(duration: 2).repeatForever(autoreverses: true),
                    value: rotate
                )
                .opacity(0.9 - Double(index) * 0.1)
                .animation(
                .linear(duration: Double(8 + index * 1))
                .repeatForever(autoreverses: false), value: rotate
                )
        }
  
    }

#Preview {
    RotatingRingsView()
}
