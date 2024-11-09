//
//  NotesGridView.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/8/24.
//

import SwiftUI

struct NotesGridView: View {
    let notes: [Int]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { row in
                HStack(spacing: 0) {
                    ForEach(1..<4) { col in
                        let number = row * 3 + col
                        Text(notes.contains(number) ? "\(number)" : "")
                            .font(.system(size: 8))
                            .frame(width: 11, height: 11, alignment: .center)
                    }
                }
            }
        }
    }
}
