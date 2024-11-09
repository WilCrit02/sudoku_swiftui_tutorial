//
//  GameView.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/7/24.
//

import SwiftUI

struct GameView: View {
    let difficulty: Difficulty
    @StateObject var viewModel: SudokuViewModel
    @State private var showConfetti = false
    @State private var showShareSheet = false

    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        _viewModel = StateObject(wrappedValue: SudokuViewModel(difficulty: difficulty))
    }

    var body: some View {
        ZStack {
            VStack {
                Text("\(difficulty.rawValue) Sudoku")
                    .font(.title)
                    .padding()

                Text("Time: \(viewModel.timerString)")
                    .font(.subheadline)
                    .padding(.bottom)

                // Buttons positioned under the timer
                HStack {
                    Spacer()

                    // Pencil Mode Button
                    Button(action: {
                        viewModel.togglePencilMode()
                    }) {
                        VStack {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30)
                                    .foregroundColor(.text1)
                                    .padding()
                                    .background(viewModel.isPencilMode ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(viewModel.isPencilMode ? Color.accentColor : Color.clear, lineWidth: 2)
                                    )
                                if viewModel.isPencilMode {
                                    Circle()
                                        .fill(Color.accentColor)
                                        .frame(width: 16, height: 16)
                                        .overlay(
                                            Text("ON")
                                                .font(.system(size: 8))
                                                .foregroundColor(.white)
                                        )
                                        .offset(x: 8, y: -8)
                                }
                            }
                            Text("Pencil")
                                .font(.caption)
                                .foregroundColor(.text1)
                        }
                    }

                    Spacer()

                    // Check Button
                    Button(action: {
                        viewModel.checkPuzzle()
                    }) {
                        VStack {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .foregroundColor(.text1)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            Text("Check")
                                .font(.caption)
                                .foregroundColor(.text1)
                        }
                    }

                    Spacer()

                    // Restart Button
                    Button(action: {
                        viewModel.restartPuzzle()
                        showConfetti = false
                    }) {
                        VStack {
                            Image(systemName: "arrow.counterclockwise.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .foregroundColor(.text1)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            Text("Restart")
                                .font(.caption)
                                .foregroundColor(.text1)
                        }
                    }

                    Spacer()
                }
                .padding(.bottom)

                SudokuGridView(cells: viewModel.cells, selectedCell: $viewModel.selectedCell)
                    .padding()

                NumberPadView { number in
                    viewModel.enterNumber(number)
                }
                .padding(.bottom, 40)
                .padding(.horizontal, 40)
            }
            
            if viewModel.isGameOver {
                Rectangle()
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                GameOverView(
                    isGameCompleted: $viewModel.isGameCompleted,
                    completionTime: $viewModel.timerString,
                    onContinue: {
                        viewModel.isGameOver = false
                    },
                    onRestart: {
                        viewModel.restartPuzzle()
                        showConfetti = false
                    },
                    onShare: {
                        showShareSheet = true
                    }
                )
                .sheet(isPresented: $showShareSheet) {
                    ActivityViewController(activityItems: ["I just played a Sudoku game on \(difficulty.rawValue) difficulty! Try to beat my time!"])
                }
            }
        }
        .onAppear {
            viewModel.startGame(difficulty: difficulty)
        }
        .onReceive(viewModel.$isGameCompleted) { isCompleted in
            if isCompleted {
                showConfetti = true
            }
        }
        .displayConfetti(isActive: $showConfetti)
    }
}
