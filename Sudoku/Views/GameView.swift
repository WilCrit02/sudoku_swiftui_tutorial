//
//  GameView.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/7/24.
//

import SwiftUI

import SwiftUI

struct GameView: View {
    let difficulty: Difficulty
    @StateObject var viewModel = SudokuViewModel()

    var body: some View {
        VStack {
            Text("\(difficulty.rawValue) Sudoku")
                .font(.title)
                .padding()

            Text("Time: \(viewModel.timerString)")
                .font(.subheadline)

            SudokuGridView(cells: viewModel.cells, selectedCell: $viewModel.selectedCell)
                .padding()

            NumberPadView { number in
                viewModel.enterNumber(number)
            }
            .padding()

            HStack {
                Button("Pencil Mode") {
                    viewModel.togglePencilMode()
                }
                .padding()

                Button("Check") {
                    viewModel.checkPuzzle()
                }
                .padding()

                Button("Restart") {
                    viewModel.restartPuzzle()
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.startGame(difficulty: difficulty)
        }
    }
}
