//
//  Untitled.swift
//  Journali
//
//  Created by Nouf on 28/10/2024.
//

import SwiftUI
import SwiftData


struct JournalListView: View {

    @ObservedObject var jvm: JournalViewModel
    @Binding var showJournalEntryView: Bool
    @Binding var date: Date
    @Query var journalEntries: [Journal]
    @Environment(\.modelContext) var modelContext
    
    public var filteredJournals: [Journal] {
        let filtered = journalEntries.filter{
            jvm.searchText.isEmpty || $0.title.lowercased().contains(jvm.searchText.lowercased()) || $0.content.lowercased().contains(jvm.searchText.lowercased())
        } // end constant filtered
        switch jvm.selectedFilter {
        case "Bookmarked":
            return filtered.filter {$0.isBookmarked}
        case "Sorted by Date":
            return filtered.filter { Calendar.current.isDate($0.date, equalTo: jvm.selectedDate, toGranularity: .day)} //return filtered by entered date
                .sorted { $0.date > $1.date} //sort it from newer to older
        default:
            return filtered
        } // end switch
    } // end filtered journals
    
    var body: some View {
        ZStack{
            List{
                ForEach(filteredJournals, id: \.id){ journalItem in
                    VStack(alignment: .leading){
                        HStack{
                            Text(journalItem.title)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.lavender)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Button(action: {
                                journalItem.isBookmarked.toggle()
                            }) //end bookmark action
                            {
                                Image(systemName: journalItem.isBookmarked ? "bookmark.fill" : "bookmark")
                                    .font(.system(size:24))
                                    .foregroundColor(.lavender)
                            } //label
                            .buttonStyle(BorderlessButtonStyle())
                        } //end Hstack for title and bookmark
                        
                        
                        Text("\(journalItem.date, formatter: jvm.dateFormatter)")
                            .font(.system(size: 14  , weight: .regular))
                            .foregroundColor(.dateGrey)
                            .padding(.bottom, 7)
                            .frame(width: 77, height: 10)
                        
                        Text(journalItem.content)
                            .font(.system(size: 18  , weight: .regular))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 10)
                        
                    }// end VStack
                    .swipeActions(edge: .leading) {
                        Button(action: {
                            jvm.editingJournal = journalItem //the journal i wanna edit
                            showJournalEntryView.toggle() //toggle show
                        }) //end action
                        {
                            Image(systemName: "pencil")
                        }
                        .tint(.editPurple)
                        .sheet(isPresented: $showJournalEntryView){
                            JournalEntryView(showJournalEntryView: $jvm.showJournalEntryView, jvm: jvm, editingJournal: $jvm.editingJournal, date: $jvm.date)
                        } // end sheet
                        
                    } //end swipe
                    
                    .swipeActions(edge: .trailing){
                        Button(action: {
                            deleteJournal(Journal: journalItem)
                        }) //end action
                        {
                            Image(systemName: "trash")
                        }
                        .tint(.deleteRed)
                    } //end swipe trailing
                }// end foreach loop
            }// end list
            .searchable(text: $jvm.searchText)
            .accentColor(.darkPurple)
            .listRowSpacing(15)
            
            if filteredJournals.isEmpty {
                VStack{
                    Image("journaliIcon")
                        .resizable()
                        .frame(width: 77.7, height: 101)
                        .padding(.bottom, (29.23-16))
                    
                    Text("No journals found")
                        .font(.system(size: 18, weight: .light))
                        .tracking(0.6)
                        .foregroundColor(.white)
                        .frame(width: 282,height: 53)
                        .multilineTextAlignment(.center)
                }
            }
        }//end Zstack

    }
    func deleteJournal(Journal: Journal){
        if let index = journalEntries.firstIndex(where: {$0.id == Journal.id}){
            withAnimation{
                let journalToDelete = journalEntries[index]
                modelContext.delete(journalToDelete)
                
            }
        }
    } //end delete
}
