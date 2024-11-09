//
//  GameCenterHelper.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/7/24.
//

import GameKit

class GameCenterHelper: NSObject, GKGameCenterControllerDelegate {
    static let shared = GameCenterHelper()

    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            if let vc {
                // Present the Game Center login view controller
            } else if GKLocalPlayer.local.isAuthenticated {
                // Player is authenticated
            } else {
                // Handle authentication failure
            }
        }
    }

    func reportScore(_ score: Int, forLeaderboardID leaderboardID: String) {
        let scoreReporter = GKScore(leaderboardIdentifier: leaderboardID)
        scoreReporter.value = Int64(score)
        GKScore.report([scoreReporter]) { error in
            // Handle error if needed
        }
    }

    func showLeaderboard() {
        let viewController = GKGameCenterViewController()
        viewController.gameCenterDelegate = self
        // Present the Game Center view controller
    }

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        // Dismiss the Game Center view controller
    }
}
