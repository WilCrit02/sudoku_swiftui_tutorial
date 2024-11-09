//
//  SudokuGenerator.swift
//  Sudoku
//
//  Created by Jared Cassoutt on 11/7/24.
//

import Foundation

class SudokuGenerator {
    static func generatePuzzle(difficulty: Difficulty) -> SudokuPuzzle {
        // Generate a complete Sudoku grid
        let solutionGrid = generateCompleteGrid()
        
        // Remove numbers from the grid based on difficulty
        let numberOfCellsToRemove = difficulty.numberOfCellsToRemove()
        let puzzleGrid = removeNumbers(from: solutionGrid, count: numberOfCellsToRemove)
        
        // Convert the grid into CellModel objects
        let cells = puzzleGrid.flatMap { row in
            row.map { value in
                CellModel(value: value == 0 ? nil : value, isEditable: value == 0)
            }
        }
        
        return SudokuPuzzle(puzzle: cells, solution: solutionGrid)
    }
    
    private static func generateCompleteGrid() -> [[Int]] {
        var grid = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        _ = fillGrid(&grid)
        return grid
    }
    
    private static func fillGrid(_ grid: inout [[Int]]) -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == 0 {
                    var numbers = Array(1...9)
                    numbers.shuffle()
                    for number in numbers {
                        if isValid(number, atRow: row, column: col, in: grid) {
                            grid[row][col] = number
                            if fillGrid(&grid) {
                                return true
                            }
                            grid[row][col] = 0
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    private static func isValid(_ number: Int, atRow row: Int, column col: Int, in grid: [[Int]]) -> Bool {
        // Check if the number is not repeated in the row
        for x in 0..<9 {
            if grid[row][x] == number {
                return false
            }
        }
        
        // Check if the number is not repeated in the column
        for y in 0..<9 {
            if grid[y][col] == number {
                return false
            }
        }
        
        // Check if the number is not repeated in the 3x3 subgrid
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        for x in startRow..<startRow + 3 {
            for y in startCol..<startCol + 3 {
                if grid[x][y] == number {
                    return false
                }
            }
        }
        
        return true
    }
    
    private static func removeNumbers(from grid: [[Int]], count: Int) -> [[Int]] {
        var grid = grid.map { $0.map { $0 } } // Deep copy of the grid
        var cellsToRemove = count
        
        while cellsToRemove > 0 {
            let row = Int.random(in: 0..<9)
            let col = Int.random(in: 0..<9)
            
            if grid[row][col] != 0 {
                let backup = grid[row][col]
                grid[row][col] = 0
                
                // Ensure that the puzzle still has a unique solution
                if hasUniqueSolution(grid) {
                    cellsToRemove -= 1
                } else {
                    grid[row][col] = backup
                }
            }
        }
        
        return grid
    }
    
    private static func hasUniqueSolution(_ grid: [[Int]]) -> Bool {
        var solutionCount = 0
        var gridCopy = grid
        _ = solve(&gridCopy, solutionCount: &solutionCount, maxSolutions: 2)
        return solutionCount == 1
    }
    
    private static func solve(_ grid: inout [[Int]], solutionCount: inout Int, maxSolutions: Int) -> Bool {
        if solutionCount >= maxSolutions {
            return true
        }
        
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == 0 {
                    for number in 1...9 {
                        if isValid(number, atRow: row, column: col, in: grid) {
                            grid[row][col] = number
                            if solve(&grid, solutionCount: &solutionCount, maxSolutions: maxSolutions) {
                                grid[row][col] = 0
                                return true
                            }
                            grid[row][col] = 0
                        }
                    }
                    return false
                }
            }
        }
        
        solutionCount += 1
        return false
    }
}

extension Difficulty {
    func numberOfCellsToRemove() -> Int {
        switch self {
        case .easy:
            return 35 // Remove 35 cells for Easy level
        case .medium:
            return 45 // Remove 45 cells for Medium level
        case .hard:
            return 55 // Remove 55 cells for Hard level
        }
    }
}
