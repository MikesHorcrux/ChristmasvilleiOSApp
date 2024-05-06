//
//  WavySquareShape.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 9/24/23.
//

import SwiftUI

struct WavySquareShape: Shape {
    var waveCount: Int
    var amplitude: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let waveWidth = rect.width / CGFloat(waveCount)
        let cornerRadius = amplitude

        // Start at the top-left after the rounded corner
        path.move(to: CGPoint(x: 0, y: cornerRadius))
        
        // Top edge
        for i in 0..<waveCount {
            let isPeak = i % 2 == 0
            let controlPointX = CGFloat(i) * waveWidth + waveWidth / 2
            let endPointX = CGFloat(i + 1) * waveWidth

            path.addQuadCurve(to: CGPoint(x: endPointX, y: isPeak ? amplitude : 0),
                              control: CGPoint(x: controlPointX, y: isPeak ? 0 : amplitude))
        }

        // Top-right rounded corner
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        // Right edge
        for i in 0..<waveCount {
            let isPeak = i % 2 == 0
            let controlPointY = CGFloat(i) * waveWidth + waveWidth / 2
            let endPointY = CGFloat(i + 1) * waveWidth

            path.addQuadCurve(to: CGPoint(x: isPeak ? rect.width - amplitude : rect.width, y: endPointY),
                              control: CGPoint(x: isPeak ? rect.width : rect.width - amplitude, y: controlPointY))
        }

        // Bottom-right rounded corner
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        // Bottom edge
        for i in 0..<waveCount {
            let isPeak = i % 2 == 0
            let controlPointX = rect.width - CGFloat(i) * waveWidth - waveWidth / 2
            let endPointX = rect.width - CGFloat(i + 1) * waveWidth

            path.addQuadCurve(to: CGPoint(x: endPointX, y: isPeak ? rect.height - amplitude : rect.height),
                              control: CGPoint(x: controlPointX, y: isPeak ? rect.height : rect.height - amplitude))
        }

        // Bottom-left rounded corner
        path.addArc(center: CGPoint(x: cornerRadius, y: rect.height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        // Left edge
        for i in 0..<waveCount {
            let isPeak = i % 2 == 0
            let controlPointY = rect.height - CGFloat(i) * waveWidth - waveWidth / 2
            let endPointY = rect.height - CGFloat(i + 1) * waveWidth

            path.addQuadCurve(to: CGPoint(x: isPeak ? amplitude : 0, y: endPointY),
                              control: CGPoint(x: isPeak ? 0 : amplitude, y: controlPointY))
        }

        // Complete the shape by returning to the start point
        path.closeSubpath()

        return path
    }
}


#if DEBUG
struct WavySquareShape_Previews: PreviewProvider {
    static var previews: some View {
        WavySquareShape(waveCount: 15, amplitude: 3)
            .frame(width: 100, height: 100)
    }
}
#endif
