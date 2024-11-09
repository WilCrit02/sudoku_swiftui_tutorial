//
//  NumberPadView.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/7/24.
//

import SwiftUI

struct NumberPadView: View {
    let action: (Int?) -> Void

    let numbers = Array(1...9)
    let columns = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(numbers, id: \.self) { number in
                Button(action: {
                    action(number)
                }) {
                    Text("\(number)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.title)
                        .background(Color.accentColor.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            // delete button
            Button(action: {
                action(nil) // Passing nil to indicate deletion
            }) {
                Image(systemName: "delete.left")
                    .padding(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title)
                    .background(Color.red.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
