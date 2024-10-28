//
//  AddJournalView.swift
//  Journali
//
//  Created by Nouf on 21/10/2024.
//

//
//  ContentView.swift
//  Journali
//
//  Created by Nouf on 20/10/2024.
//

import SwiftUI
import SwiftData

struct JournalEntryView: View {

    @Environment(\.modelContext) var modelContext
    @Binding var showJournalEntryView: Bool
    @ObservedObject var jvm: JournalViewModel
    @Binding var editingJournal: Journal?  //for editing
    @Binding var date: Date
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            ScrollView{
                    VStack{
                        
                        TextField("Title", text: $jvm.title , axis: .vertical)
                                               .font(.system(size: 34, weight: .bold))
                                               .frame(width: 360.62, height: 41, alignment: .leading)
                                               .padding(.top, 30)
               
               
                        Text("\(date, formatter: jvm.dateFormatter)")
                                               .font(.system(size: 16, weight: .regular))
                                               .frame(width: 87.4, height: 19, alignment: .leading)
                                               .foregroundColor(.grey)
                                               .padding(.trailing, 273.0)
               
               
                        TextField("Type your journal..", text: $jvm.content, axis: .vertical)
                                               .font(.system(size:20 , weight: .regular))
                                               .frame(width: 348.61 , height: 434, alignment: .topLeading)
                                               .padding(.top, 20)
                                               .padding(.trailing, 10.0)
                                               .padding(.bottom, 170)
                        
                    } //end VStack
                    .onAppear {
                        if let journal = jvm.editingJournal { //if i am editing and not adding new
                            jvm.title = journal.title
                            jvm.content = journal.content
                                       }
                                   } //end on appear
            } // end scroll view
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    // cancel button
                    Button(action:{
                        dismiss()
                    })//end action
                    {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.darkPurple)
                    } //end label
                } //end tool bar item top leading (AKA cancel)
            
                ToolbarItem(placement: .topBarTrailing){
                    //save button
                    Button(action:{
                        saveJournal(Journaltitle: jvm.title, Journalcontent: jvm.content, date: date, isBookmarked: jvm.isBookmarked)
                        dismiss()
                    }) // end action
                    {
                        Text("Save")
                            .font(.system(size: 16 , weight: .bold ))
                            .foregroundColor(.darkPurple)
                    } //end label
                } //end tool bar item top trailing (AKA Save)
            }// end tool bar
        }//end navigationView
    } // end body
    
    
    func saveJournal(Journaltitle: String, Journalcontent: String, date: Date, isBookmarked: Bool){
        if editingJournal == nil{
            //add new journal
            let newJournal = Journal(title: jvm.title, date: date, content: jvm.content, isBookmarked: isBookmarked)
            modelContext.insert(newJournal)
        }
        else {
            //update existing journal
            // ? to unwrap
            editingJournal?.title = jvm.title
            editingJournal?.content = jvm.content
            editingJournal = nil //reset editing journal
        }
        //reset values for new entries
        jvm.title = ""
        jvm.content = ""
    } //end save journal
} // end struct



