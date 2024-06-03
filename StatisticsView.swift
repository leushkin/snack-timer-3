//
//  StatisticsView.swift
//  snack-timer-3 Watch App
//
//  Created by Work on 03.06.24.
//

import SwiftUI
import Combine

struct StatisticsView: View {
    var snack: Snack
    var interval: Double;
    
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    @State private var eatenSnacksAmount: Int = 0
    @State private var pause: Bool = true
    
    init(snack: Snack, interval: Double) {
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
        self.snack = snack
        self.interval = interval
    }
    
    func finish() {
        self.timer.upstream.connect().cancel()
    }
    
    var body: some View {
        VStack {
            Group {
                if eatenSnacksAmount == snack.amount {
                    Text("No snacks left! Hope you enjoyed")
                } else {
                    Text("You have eaten \(eatenSnacksAmount) out of \(snack.amount) snacks!")
                }
            }
            .padding(.bottom, 20)

            HStack {
                Button(action: finish) {
                    NavigationLink("End") {
                        ContentView()
                    }
                }
            }
        }
        .navigationTitle(snack.name)
        .onReceive(timer, perform: { _ in
            WKInterfaceDevice.current().play(.success)
            
            if (eatenSnacksAmount == snack.amount) {
                timer.upstream.connect().cancel()
                return;
            }
            
            eatenSnacksAmount += 1
        })
    }
}

#Preview {
    StatisticsView(
        snack: Snack(id: "1", name: "Pringles", amount: 100, weight: 120),
        interval: 12
    )
}
