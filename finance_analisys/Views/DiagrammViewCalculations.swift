//
//  DiagrammViewCalculations.swift
//  finance_analisys
//
//  Created by Frederico del' Bidzho on 23.07.2024.
//

import Foundation
import SwiftUI
class DiagrammViewCalculations: ObservableObject{
    static var shared = DiagrammViewCalculations(); private init() { }
    
    


    func sortThatMF(data: FetchedResults<Purchase>) -> [String: Int]{
        let sortedMF = data.reduce(into: [String: Int]()) { partialResult, purchase in
            
            partialResult[purchase.store!, default: 0] += Int(purchase.price)
        }
        return sortedMF
    }
    func maxFromSortedMF(data: [String: Int]) -> (key: String, value: Int){
        return data.max(by: {$0.value < $1.value})!
    }
    
    func rangesFromSortedMF(data: [String: Int])  -> [()]{
        var total = 0
        let categoryRanges: [()] = data.map {
            let newTotal = total + Int($0.value)
            let result = (category: $0.key, range: Int(total) ..< Int(newTotal))
            
        }
        return categoryRanges
    }
    
    func findSelectedItem(_ data: [(category: String?, range: Range<Int>)],_ purchases: [String: Int]? , _ selectedAngle: Int?) -> (category: String?, range: Range<Int>)?{
        
        guard let selectedAngle else { return nil }
        if let selected = data.firstIndex(where: {
          $0.range.contains(selectedAngle)
        }) {
            return data[selected]
            
        
            
        }
        return nil
    }
    
}
