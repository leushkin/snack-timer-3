//
//  EntrtainmentDurationView.swift
//  snack-timer-3 Watch App
//
//  Created by Work on 03.06.24.
//

import SwiftUI

struct EntrtainmentDurationView: View {
    var snack: Snack;
    
    @State private var percentage: Double = 25
    
    @State private var hours = 1
    @State private var minutes = 30
    @State private var seconds = 0
    
    func calculateNotificationGap() -> Double {
        let totalTime = hours * 60 * 60 + minutes * 60 + seconds
        
        return (percentage * (Double(totalTime) / 100)) / Double(snack.amount)
    }
    
    func gapToString() -> String {
        var result = ""
        let gap = calculateNotificationGap()
        let minutes = Int((gap / 60) > 0 ? gap / 60 : 0)
        
        if minutes != 0 {
            result = "\(result) \(minutes) minutes"
        }
        
        let seconds = Int(gap - Double(minutes * 60))
        
        if seconds != 0 {
            result = "\(result) \(seconds) seconds"
        }
        
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        VStack {
            Form {
                Section("Entertainment duration") {
                    Picker("Hours:", selection: $hours) {
                        ForEach(0..<25) { hour in Text("\(hour)") }
                    }
                    
                    Picker("Minutes:", selection: $minutes) {
                        ForEach(0..<60) { minute in Text("\(minute)") }
                    }
                    
                    Picker("Seconds:", selection: $seconds) {
                        ForEach(0..<60) { second in Text("\(second)") }
                    }
                }
                
                Section {
                    VStack {
                        Slider(value: $percentage, in: 1...100, step: 1)
                        Text("\(Int(percentage)) %")
                    }
                    .padding(.top, 10)
                } header: {
                    Text("Split snack for percentage")
                } footer: {
                    Text("This percentage represents which percentage of the film you are going to enjoy your snack. For example now you will be notified with a gap of \(gapToString()).")
                }
            }
        }
        .navigationTitle(snack.name)
    }
}

#Preview {
    EntrtainmentDurationView(snack: Snack(id: "1", name: "Pringles", amount: 100, weight: 120))
}
