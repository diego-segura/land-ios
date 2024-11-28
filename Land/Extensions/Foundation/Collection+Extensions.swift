//
//  Collection+Extensions.swift
//  Land
//
//  Created by Luka Vujnovac on 27.11.2024..
//

import Foundation

extension Array {
    func splitByCondition(_ isInFirstGroup: (Element, Int) -> Bool) -> [[Element]] {
        var group1: [Element] = []
        var group2: [Element] = []
        
        for (index, element) in self.enumerated() {
            if isInFirstGroup(element, index) {
                group1.append(element)
            } else {
                group2.append(element)
            }
        }
        
        return [group1, group2]
    }
}
