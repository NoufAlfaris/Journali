//
//  Journal.swift
//  Journali
//
//  Created by Nouf on 28/10/2024.
//
import Foundation



@Observable class Journal: Identifiable, Codable{
    let id = UUID()
    var title: String
    var date = Date()
    var content: String
    var isBookmarked: Bool
    
    init(title: String, date: Date, content: String, isBookmarked: Bool) {
//        self.id = id
        self.title = title
        self.date = date
        self.content = content
        self.isBookmarked = isBookmarked
    }
} //end journals struct
