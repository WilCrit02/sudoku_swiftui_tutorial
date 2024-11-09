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
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            // delete button
            Button(action: {
                action(nil) // Passing nil to indicate deletion
            }) {
                Image(systemName: "delete.left") // Using a system image for the delete icon
                    .font(.title)
                    .frame(width: 50, height: 50)
                    .background(Color.red.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
