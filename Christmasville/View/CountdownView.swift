//
//  CountdownView.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 10/28/23.
//

import SwiftUI

struct CountdownView: View {
    @State private var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let calendar = Calendar.current
    
    var targetDate: Date {
        let now = Date()
        let thisYearChristmas = calendar.date(from: DateComponents(year: calendar.component(.year, from: now), month: 12, day: 25))!
        return now > thisYearChristmas ? calendar.date(byAdding: .year, value: 1, to: thisYearChristmas)! : thisYearChristmas
    }

    var body: some View {
        VStack {
            HStack {
                ForEach(Array(String(format: "%02d", calendar.dateComponents([.day], from: currentDate, to: targetDate).day ?? 0)), id: \.self) { digit in
                    Text("\(Int(String(digit)) ?? 0)")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.santaRed)
                        .cornerRadius(8)
                }
            }
            .onReceive(timer) { _ in
                currentDate = Date()
            }
        }
    }
}


#Preview {
    CountdownView()
}
