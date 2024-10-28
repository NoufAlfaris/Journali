//
//  ContentView.swift
//  Journali
//
//  Created by Nouf on 20/10/2024.
//

import SwiftUI
import SwiftData

struct MainPage: View {

    @StateObject var jvm = JournalViewModel()
    @Query var journalEntries: [Journal] = []
    
    var body: some View{
        NavigationView{
            
                //splashScreen
            if jvm.isActive{
                splashScreen(isActive: $jvm.isActive).onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            jvm.isActive = false
                                }
                            }
                        }
                    } //end if splash screen
                    
                    else{
                        ZStack{
                            //background color
                            Color(.background)
                                .ignoresSafeArea()

                            if journalEntries.isEmpty{
                            EmptyState()
                        } //end if is empty
                            
                        else{
                            VStack {
                                JournalListView(jvm: jvm, showJournalEntryView: $jvm.showJournalEntryView, date: $jvm.date)
                                    }
                        } //end else for when user saves journals/ has journals

                        
                    } //end zstack
                        .navigationTitle("Journal")
                        .navigationBarTitleDisplayMode(.automatic)
                        .toolbar{
                            // plus and filtering buttons
                            ToolbarItem(placement: .topBarTrailing)
                            {
                                HStack{
                                    //button 1 filtering (menu)
                                    Menu{
                                        Button("All Entries") { jvm.selectedFilter = "All"}
                                        Button("Bookmark") { jvm.selectedFilter = "Bookmarked"}
                                        Button("Journal date") { jvm.selectedFilter = "Sorted by Date"}
                                    }//end menu
                                    label: {
                                        ZStack{
                                            Circle()
                                                .fill(.darkGrey)
                                                .frame(width: 30, height: 30)
                                            
                                            Image(systemName: "line.3.horizontal.decrease")
                                                .fontWeight(.semibold)
                                                .frame(width: 23 , height: 21)
                                                .foregroundColor(.lavender)
                                            
                                        } //end label ZStack
                                    } //end label & button parameter
                                    // button 2 plus
                                    Button(action:{
                                        jvm.showJournalEntryView.toggle()
                                    })//end action
                                    {
                                        ZStack{
                                            Circle()
                                                .fill(.darkGrey)
                                                .frame(width: 30, height: 30)
                                            
                                            Image(systemName: "plus")
                                                .fontWeight(.regular)
                                                .frame(width: 23 , height: 26)
                                                .foregroundColor(.lavender)
                                            
                                        }//end label ZStack
                                    }//end label & button parameter
                                    .sheet(isPresented: $jvm.showJournalEntryView){
                                        JournalEntryView(showJournalEntryView: $jvm.showJournalEntryView, jvm: jvm, editingJournal: $jvm.editingJournal, date: $jvm.date)
                                    } // end sheet
                                } //end Hstack for buttons
                            } // end tool bar item1
                        }//end tool bar
                } // end splash screen else

        }//end navigation view
        .tint(.darkPurple) //to make the accent color purple
    } // end body
    
    
    
    
} // end struct

#Preview {
    MainPage()
}
