//
//  HomeView.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/7/24.
//

import SwiftUI
import GameKit

struct HomeView: View {
    @StateObject var gameCenterHelper = GameCenterHelper.shared

    @State private var showGameCenter = false
    @State private var leaderboardID: String?

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
                            .background(Color.accentColor.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                // Buttons to view leaderboards
                Button(action: {
                    leaderboardID = "com.haplo.sudoku.leaderboard.easy"
                    showGameCenter = true
                }) {
                    Text("View Leaderboards")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.7))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                }
            }
            .sheet(isPresented: $showGameCenter) {
                if let leaderboardID = leaderboardID {
                    GameCenterView(leaderboardID: leaderboardID)
                }
            }
            .sheet(isPresented: $gameCenterHelper.showAuthenticationView) {
                if let authViewController = gameCenterHelper.authenticationViewController {
                    AuthenticationViewControllerWrapper(authViewController: authViewController)
                }
            }
        }
    }
}

// Wrapper for the authentication view controller
struct AuthenticationViewControllerWrapper: UIViewControllerRepresentable {
    let authViewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return authViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed
    }
}


enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
