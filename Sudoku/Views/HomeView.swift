//
//  HomeView.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/7/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Sudoku")
                    .font(.largeTitle)
                    .padding()

                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    NavigationLink(destination: GameView(difficulty: difficulty)) {
                        Text(difficulty.rawValue)
                            .font(.title2)
                            .frame(width: 200, height: 50)
                            .background(Color.blue.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
