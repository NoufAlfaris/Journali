//
//  journals.swift
//  Journali
//
//  Created by Nouf on 21/10/2024.
//

//@Observable
//
//class Book: Identifiable {
//    var title = "Sample Book Title"
//    var isAvailable = true
//}
import SwiftUI

@Observable class journals{
    var title: String
    var date: Date
    var content: String
    var isBookmarked: Bool
    
    init(title: String, date: Date, content: String, isBookmarked: Bool) {
        self.title = title
        self.date = date
        self.content = content
        self.isBookmarked = isBookmarked
    }
} //end journals class
