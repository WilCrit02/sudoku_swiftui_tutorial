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
    @State private var leaderboardID = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.background1.ignoresSafeArea()
                
                // leaderboard button
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showGameCenter = true
                        }) {
                            Image(systemName: "trophy")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.text1)
                                .padding()
                                .background(Color.background3)
                                .clipShape(Circle())
                        }
                        .padding()
                    }
                    Spacer()
                }
                
                
                VStack(spacing: 20) {
                    Spacer()
                    // App Icon Image above "Sudoku" text
                    ZStack {
                        Image("SudokuLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
                    .rotationEffect(.degrees(-15))
                    .padding(.top, 40)
                    .shadow(color: .shadow, radius: 8, x: 2, y: 3)

                    // Improved "Sudoku" text
                    Text("Sudoku.")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .padding()

                    // Difficulty buttons
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
                    
                    Spacer()
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $gameCenterHelper.showAuthenticationView) {
                if let authViewController = gameCenterHelper.authenticationViewController {
                    AuthenticationViewControllerWrapper(authViewController: authViewController)
                }
            }
            .sheet(isPresented: $showGameCenter) {
                GameCenterView(leaderboardID: leaderboardID) { // on dismiss
                    showGameCenter = false
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// Wrapper for the authentication view controller
struct AuthenticationViewControllerWrapper: UIViewControllerRepresentable {
    let authViewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return authViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
