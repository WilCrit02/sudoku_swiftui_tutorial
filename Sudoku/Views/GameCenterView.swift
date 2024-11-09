//
//  GameCenterView.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/8/24.
//

import SwiftUI
import GameKit

struct GameCenterView: UIViewControllerRepresentable {
    let leaderboardID: String

    func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let gcViewController = GKGameCenterViewController(leaderboardID: leaderboardID, playerScope: .global, timeScope: .allTime)
        gcViewController.gameCenterDelegate = context.coordinator
        return gcViewController
    }

    func updateUIViewController(_ uiViewController: GKGameCenterViewController, context: Context) {
        // No need to update
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, GKGameCenterControllerDelegate {
        var parent: GameCenterView

        init(_ parent: GameCenterView) {
            self.parent = parent
        }

        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true)
        }
    }
}
