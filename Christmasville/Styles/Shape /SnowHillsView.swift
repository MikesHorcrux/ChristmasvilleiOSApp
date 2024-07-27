import SwiftUI

struct SnowHillsView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                // Starting point
                path.move(to: CGPoint(x: 0, y: height))
                
                // Creating small waves or hilly shapes
                let baseHeight: CGFloat = height - 100 // Base height for the lowest slope
                let waveHeight: CGFloat = 20 // Height of each wave
                let waveWidth: CGFloat = width / 4 // Width of each wave
                
                var currentX: CGFloat = 0
                
                while currentX < width {
                    let controlX1 = currentX + waveWidth * 0.25
                    let controlX2 = currentX + waveWidth * 0.75
                    let endX = currentX + waveWidth
                    
                    path.addCurve(to: CGPoint(x: endX, y: baseHeight),
                                  control1: CGPoint(x: controlX1, y: baseHeight - waveHeight),
                                  control2: CGPoint(x: controlX2, y: baseHeight + waveHeight))
                    
                    currentX = endX
                }
                
                // Closing the path
                path.addLine(to: CGPoint(x: width, y: height))
                path.addLine(to: CGPoint(x: 0, y: height))
            }
            .fill(.white)
        }
        .frame(height: 150) // Ensure the frame height is 200 pixels
        .padding(.horizontal, -30)
        .padding(.bottom, -35)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SnowHillsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            SnowHillsView()
        }
        .background(.black)
    }
}
