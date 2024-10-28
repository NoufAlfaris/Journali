//
//  JournalViewModel.swift
//  Journali
//
//  Created by Nouf on 27/10/2024.
//

import Foundation
import Combine
import CoreData

final class JournalViewModel: ObservableObject {

//    let viewContext = PersistenceController.shared.container.viewContext
    
    @Published var showJournalEntryView = false
    @Published var journalEntries: [Journal] = []
    @Published var searchText: String = ""
    @Published var date = Date()
    @Published var isActive: Bool = true
    @Published var selectedFilter: String = "All"
    @Published var editingJournal: Journal? = nil
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var isBookmarked: Bool = false
//    init() {
//          fetchJournals()
//      }
    
     public var filteredJournals: [Journal] {
        let filtered = journalEntries.filter{
            searchText.isEmpty || $0.title.lowercased().contains(searchText.lowercased()) || $0.content.lowercased().contains(searchText.lowercased())
        } // end constant filtered
        switch selectedFilter {
        case "Bookmarked":
            return filtered.filter {$0.isBookmarked}
        case "Sorted by Date":
            return filtered.sorted { $0.date > $1.date}
        default:
            return filtered
        } // end switch
    } // end filtered journals
    
    
    // fetch journals from coredata
//    func fetchJournals() {
//        let request: NSFetchRequest<Journal> = Journal.fetchRequest()
//        
//        do {
//            journalEntries = try viewContext.fetch(request)
//        } catch {
//            print("Failed to fetch journals: \(error.localizedDescription)")
//        }
//    } //end fetchJournals
    
    
    
    //delete journal function
    func deleteJournal(Journal: Journal){
        journalEntries.removeAll(where: {$0.id == Journal.id})
    }
    
    func saveJournal(Journaltitle: String, Journalcontent: String, date: Date, isBookmarked: Bool){
        if editingJournal == nil{
            //add new journal
            let newJournal = Journal(title: title, date: date, content: content, isBookmarked: isBookmarked)
            journalEntries.append(newJournal)
        }
        else {
            //update existing journal
            // ? to unwrap
                editingJournal?.title = title
                editingJournal?.content = content
                editingJournal = nil //reset editing journal

        }
        title = ""
        content = ""
//        saveContext()
//        fetchJournals()
    } //end save journal
    
    //save changes to coredata
//      func saveContext() {
//         if viewContext.hasChanges {
//             do {
//                 try viewContext.save()
//             } catch {
//                 print("Failed to save context: \(error)")
//             }
//         }
//     }
    
    //date formatter
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short //to be only numbers
            return formatter
        }
    
 
}
