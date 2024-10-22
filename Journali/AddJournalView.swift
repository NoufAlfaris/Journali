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
    @State var title: String = ""
//    @State var date: Date = Calendar.current.date(from: self.components) ?? .now
    @State var content: String = ""
    @State var isBookmarked: Bool = false
    var body: some View {
        NavigationView{
            
            VStack{
                
                TextField("Title", text:$title)
                    .font(.system(size: 34, weight: .bold))
                    .frame(width: 360.62, height: 41, alignment: .leading)
                    .padding(.bottom, 55-26)
                
                
                //date
                
                
                TextField("Type your journal", text: $content)
                    .font(.system(size:20 , weight: .regular))
                    .frame(width: 348.61 , height: 434, alignment: .topLeading)
                    .padding(.top, 26)
                    .padding(.trailing, 10.0)
                    .padding(.bottom, 180)
                
                
                
            } //end VStack
            
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Text("Cancel")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.darkPurple)
                } //end tool bar item top leading (AKA cancel)
                
                ToolbarItem(placement: .topBarTrailing){
                    Text("Save")
                        .font(.system(size: 16 , weight: .bold ))
                        .foregroundColor(.darkPurple)
                    //on tap gesture i think
                } //end tool bar item top trailing (AKA Save)
            }// end tool bar
        }//end navigationView
    } // end body
} // end struct

#Preview {
    AddJournalView(showAddJournal: .constant(true))
}
