//
//  CellView.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/7/24.
//

import SwiftUI

struct CellView: View {
    let cell: CellModel
    let row: Int
    let col: Int

    var body: some View {
        ZStack {
            Rectangle()
                .fill(cellBackgroundColor())
            
            if let value = cell.value {
                // Display the value
                Text("\(value)")
                    .foregroundColor(cell.isIncorrect ? .red : .black)
                    .font(.system(size: 20))
                    .fontWeight(cell.isEditable ? .regular : .bold)
            } else {
                if !cell.notes.isEmpty {
                    // Display notes in a 3x3 grid
                    NotesGridView(notes: cell.notes)
                }
            }
        }
        .frame(width: 35, height: 35)
        .overlay(borderOverlay)
        .border(cell.isSelected ? .blue : .clear, width: cell.isSelected ? 2 : 0)
    }

    private func cellBackgroundColor() -> Color {
        if cell.isSelected {
            return Color.blue.opacity(0.2)
        } else if cell.isHighlighted {
            return Color.blue.opacity(0.1) // For highlighting related cells
        } else {
            return Color.white
        }
    }

    var borderOverlay: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            let topWidth: CGFloat = (row % 3 == 0) ? 2 : 0.5
            let bottomWidth: CGFloat = (row == 8) ? 2 : 0.5
            let leftWidth: CGFloat = (col % 3 == 0) ? 2 : 0.5
            let rightWidth: CGFloat = (col == 8) ? 2 : 0.5

            ZStack {
                // Top border
                Rectangle()
                    .frame(height: topWidth)
                    .foregroundColor(.black)
                    .position(x: width / 2, y: topWidth / 2)
                // Bottom border
                Rectangle()
                    .frame(height: bottomWidth)
                    .foregroundColor(.black)
                    .position(x: width / 2, y: height - bottomWidth / 2)
                // Left border
                Rectangle()
                    .frame(width: leftWidth)
                    .foregroundColor(.black)
                    .position(x: leftWidth / 2, y: height / 2)
                // Right border
                Rectangle()
                    .frame(width: rightWidth)
                    .foregroundColor(.black)
                    .position(x: width - rightWidth / 2, y: height / 2)
            }
        }
        .clipped()
    }
}
