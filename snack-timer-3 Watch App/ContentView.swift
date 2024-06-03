//
//  ContentView.swift
//  snack-timer-3 Watch App
//
//  Created by Work on 02.06.24.
//

import SwiftUI

protocol SnackItem: Identifiable, Hashable {
    var id: String { get }
    var name: String { get }
    var amount: Int { get }
    var weight: Int { get } // total in grams
}

struct Snack: SnackItem {
    var id: String
    var name: String
    var amount: Int
    var weight: Int
}

let snacks: [Snack] = [
    Snack(id: "1", name: "Pringles", amount: 100, weight: 120),
    Snack(id: "2", name: "Lays", amount: 100, weight: 120),
]

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(snacks) { snack in
                    NavigationLink(snack.name, value: snack)
                }
            }
            .navigationTitle("Menu")
            .navigationDestination(for: Snack.self) { snack in
                EntrtainmentDurationView(snack: snack)
            }
        }
    }
}

#Preview {
    ContentView()
}
