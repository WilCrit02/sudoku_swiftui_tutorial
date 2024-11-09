//
//  SudokuGridView.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/7/24.
//

import SwiftUI

import SwiftUI

struct SudokuGridView: View {
    let cells: [CellModel]
    @Binding var selectedCell: CellModel?

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<9, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<9, id: \.self) { col in
                        let index = row * 9 + col
                        if let cell = cells[safe: index] {
                            CellView(cell: cell, row: row, col: col)
                                .onTapGesture {
                                    if cell.isEditable {
                                        selectedCell = cell
                                    }
                                    // Do nothing if the cell is not editable
                                }
                                .overlay(
                                    Rectangle()
                                        .stroke(lineWidth: getBorderWidth(row: row, col: col))
                                        .foregroundColor(.black)
                                )
                        } else {
                            // Optionally handle missing cells
                            EmptyCellView(row: row, col: col)
                                .overlay(
                                    Rectangle()
                                        .stroke(lineWidth: getBorderWidth(row: row, col: col))
                                        .foregroundColor(.black)
                                )
                        }
                    }
                }
            }
        }
    }

    private func getBorderWidth(row: Int, col: Int) -> CGFloat {
        var width: CGFloat = 0.5

        if col % 3 == 0 {
            width = 1.5 // Left border
        }
        if col == 8 {
            width = 1.5 // Right border
        }
        if row % 3 == 0 {
            width = max(width, 1.5) // Top border
        }
        if row == 8 {
            width = max(width, 1.5) // Bottom border
        }

        return width
    }
}
