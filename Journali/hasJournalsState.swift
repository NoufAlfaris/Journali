//
//  Untitled.swift
//  Journali
//
//  Created by Nouf on 28/10/2024.
//

import SwiftUI



struct JournalListView: View {
    // Pass in your view model as a binding or environment object
    @ObservedObject var jvm: JournalViewModel // Replace with your actual view model class
    @Binding var showJournalEntryView: Bool
    @Binding var date: Date

    var body: some View {
        List{
            ForEach(jvm.filteredJournals, id: \.id){ journalItem in
                                       VStack(alignment: .leading){
                                           HStack{
                                               Text(journalItem.title)
                                                   .font(.system(size: 24, weight: .semibold))
                                               //                                        .frame(width: 132, height: 29)
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
                                           } //end Hstack for title and bookmark
   
   
                                           Text("\(journalItem.date, formatter: jvm.dateFormatter)")
                                               .font(.system(size: 14  , weight: .regular))
                                               .foregroundColor(.dateGrey)
                                               .padding(.bottom, 7)
   //                                            .padding(.top, 7)
                                               .frame(width: 77, height: 10)
   
                                           Text(journalItem.content)
                                               .font(.system(size: 18  , weight: .regular))
                                           //                                        .frame(width: 295, height: 105)
                                               .multilineTextAlignment(.leading)
   //                                            .frame(width: 295, height: 105 )
                                               .padding(.top, 10)
                                           //
                                           //
   
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
                                               JournalEntryView(showJournalEntryView: $jvm.showJournalEntryView, jvm: jvm, journals: $jvm.journalEntries, editingJournal: $jvm.editingJournal, date: $jvm.date)
                                           } // end sheet
                                        
                                       } //end swipe
   
                                       .swipeActions(edge: .trailing){
                                           Button(action: {
                                               jvm.deleteJournal(Journal: journalItem)
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
    }
}
