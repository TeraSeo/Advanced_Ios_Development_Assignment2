//
//  ItineraryItem.swift
//  Assignment2
//
//  Created by 서태준 on 8/20/25.
//

import Foundation

class ItineraryItem: Identifiable, ItineraryProtocol {
    let id = UUID()
    var title: String
    var time: Date
    var cost: Double
    var category: String
    
    init(title: String, time: Date, cost: Double, category: String) {
        self.title = title
        self.time = time
        self.cost = cost
        self.category = category
    }
}
