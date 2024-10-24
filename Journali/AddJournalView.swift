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

struct AddJournalView: View {
    var components = DateComponents()
    @Binding var showAddJournal: Bool
    @Binding var journals: [journals]
    @State var title: String = ""
    @Binding var date: Date
    @State var content: String = ""
    @State var isBookmarked: Bool = false
    
    //date formatter
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short //to be only numbers
            return formatter
        }
    
    func saveJournal(){
        let newJournal = Journali.journals(title: title, date: date, content: content, isBookmarked: isBookmarked)
        journals.append(newJournal)
    } //end save journal
    
    
    
//    func getCurrentDateString() -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        return formatter.string(from: Date())
//} // end currentDate
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    
                    TextField("Title", text:$title, axis: .vertical)
                        .font(.system(size: 34, weight: .bold))
                        .frame(width: 360.62, height: 41, alignment: .leading)
                        .accentColor(.darkPurple)
                        .padding(.top, 30)
              
                    
                    
                    Text("\(date, formatter: dateFormatter)")
                        .font(.system(size: 16, weight: .regular))
                        .frame(width: 87.4, height: 19, alignment: .leading)
                        .foregroundColor(.grey)
                        .padding(.trailing, 273.0)
             
                    
                    
                    TextField("Type your journal..", text: $content, axis: .vertical)
                        .font(.system(size:20 , weight: .regular))
                        .frame(width: 348.61 , height: 434, alignment: .topLeading)
                        .padding(.top, 20)
                        .padding(.trailing, 10.0)
                        .padding(.bottom, 170)
                        .accentColor(.darkPurple)

                    
                } //end VStack
                
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
                        saveJournal()
                        dismiss()
                    }) // end action
                    {
                        Text("Save")
                            .font(.system(size: 16 , weight: .bold ))
                            .foregroundColor(.darkPurple)
                    } //end label
                    //on tap gesture i think
                } //end tool bar item top trailing (AKA Save)
            }// end tool bar
        }//end navigationView
    } // end body
} // end struct

//#Preview {
//    AddJournalView(showAddJournal: .constant(true), date: $date)
//}

