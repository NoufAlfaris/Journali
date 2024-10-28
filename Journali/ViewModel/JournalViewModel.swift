//
//  JournalViewModel.swift
//  Journali
//
//  Created by Nouf on 27/10/2024.
//

import Foundation
import Combine
import SwiftUI


final class JournalViewModel: ObservableObject {

    @Published var showJournalEntryView = false
    @Published var searchText: String = ""
    @Published var date = Date()
    @Published var isActive: Bool = true
    @Published var selectedFilter: String = "All"
    @Published var editingJournal: Journal? = nil
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var isBookmarked: Bool = false
    
    //date formatter
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short //to be only numbers
            return formatter
        }
    
 
} //end class
