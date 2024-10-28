//
//  Journal.swift
//  Journali
//
//  Created by Nouf on 28/10/2024.
//
import Foundation
import SwiftData

@Model
 class Journal: Identifiable{
    let id = UUID()
    var title: String
    var date = Date()
    var content: String
    var isBookmarked: Bool
    
    init(title: String, date: Date, content: String, isBookmarked: Bool) {
        self.title = title
        self.date = date
        self.content = content
        self.isBookmarked = isBookmarked
    }
} //end journals struct
