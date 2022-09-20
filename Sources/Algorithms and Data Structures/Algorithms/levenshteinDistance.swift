//
//  File.swift
//  
//
//  Created by Noah Wilder on 2022-09-20.
//

import Foundation

extension Collection where Element: Equatable {
    public func levenshteinDistance<T>(to other: T) -> Int where T: Collection, T.Element == Element {
        let sCount = self.count
        let oCount = other.count
        
        guard sCount != 0 else {
            return oCount
        }
        
        guard oCount != 0 else {
            return sCount
        }
        
        let line : [Int]  = Array(repeating: 0, count: oCount + 1)
        var mat : [[Int]] = Array(repeating: line, count: sCount + 1)
        
        for i in 0...sCount {
            mat[i][0] = i
        }
        
        for j in 0...oCount {
            mat[0][j] = j
        }
        
        for (j, idx) in zip(1...oCount, other.indices) {
            for (i, idx2) in zip(1...sCount, indices) {
                if self[idx2] == other[idx] {
                    mat[i][j] = mat[i - 1][j - 1]       // no operation
                }
                else {
                    let del = mat[i - 1][j] + 1         // deletion
                    let ins = mat[i][j - 1] + 1         // insertion
                    let sub = mat[i - 1][j - 1] + 1     // substitution
                    mat[i][j] = Swift.min(Swift.min(del, ins), sub)
                }
            }
        }
        
        return mat[sCount][oCount]
    }
}
