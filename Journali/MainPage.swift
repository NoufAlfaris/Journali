//
//  ContentView.swift
//  Journali
//
//  Created by Nouf on 20/10/2024.
//

import SwiftUI

struct MainPage: View {
    @State var showJournalEntryView = false
    @State var journals: [journals] = []
    @State var searchText: String = ""
    @State var date = Date()
    
    @State var isActive: Bool = true
    
    //filtering
    @State var selectedFilter: String = "All"
    @State var editingJournal: journals? = nil
    
    var filteredJournals: [journals] {
        let filtered = journals.filter{
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
    
    //date formatter
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short //to be only numbers
            return formatter
        }
    
    //delete journal function
    func deleteJournal(journal: journals){
        journals.removeAll(where: {$0.id == journal.id})
    } 
    //edit journal function
//    func editJournal(journal: journals){
//        showAddJournal.toggle()
//    }
    
    var body: some View {
        
        NavigationView{
//            Group{
//                ZStack{
//                    //background color
//                    Color(.background)
//                        .ignoresSafeArea()
                    
                    //splashScreen
                    if isActive{
                        ZStack{
                            LinearGradient(stops: [
                                .init(color: .splashPurple , location: 0.25),
                                .init(color: .black , location: 0.75)
                            ] , startPoint: .top, endPoint: .bottom)// end linear gradient
                            .ignoresSafeArea()
                            VStack (alignment: .center, spacing: 11){
                                Image("journaliIcon")
                                    .resizable()
                                    .frame(width: 77.7, height: 101)
                                    .padding(.bottom , 24.23 - 11)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            withAnimation {
                                                self.isActive = false
                                            }
                                        }
                                    }
                                Text("Journali")
                                    .font(.system(size: 42, weight: .black))
                                    .frame(width: 174 , height: 50)
                                    .foregroundColor(.white)
                                
                                Text("Your thoughts, your story")
                                    .font(.system(size: 18, weight: .light))
                                    .tracking(1)
                                
                            } //vstack
                        } //end zstack
                    } //end if splash screen
                    
                    else{
                        ZStack{
                            //background color
                            Color(.background)
                                .ignoresSafeArea()
                            
                        if journals.isEmpty{
                            
                            VStack(alignment: .center, spacing: 16){
                                Image("journaliIcon")
                                    .resizable()
                                    .frame(width: 77.7, height: 101)
                                    .padding(.bottom, (29.23-16))
                                
                                Text("Begin Your Journal")
                                    .font(.system(size: 24, weight: .bold)) //SFPro is the default so no need to specify it
                                    .foregroundColor(.lavender)
                                
                                Text("Craft your personal diary, tap the plus icon to begin")
                                    .font(.system(size: 18, weight: .light))
                                    .tracking(0.6)
                                    .foregroundColor(.white)
                                    .frame(width: 282,height: 53)
                                    .multilineTextAlignment(.center)
                                
                                
                            } // end Vstack
                        } //end if is empty
                        else{
                            List{
                                ForEach(filteredJournals){ journals in
                                    VStack(alignment: .leading){
                                        HStack{
                                            Text(journals.title)
                                                .font(.system(size: 24, weight: .semibold))
                                            //                                        .frame(width: 132, height: 29)
                                                .foregroundColor(.lavender)
                                                .multilineTextAlignment(.leading)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                journals.isBookmarked.toggle()
                                            }) //end bookmark action
                                            {
                                                if journals.isBookmarked{
                                                    Image(systemName: "bookmark.fill")
                                                        .font(.system(size:24))
                                                        .foregroundColor(.lavender)
                                                }
                                                else{
                                                    Image(systemName: "bookmark")
                                                        .font(.system(size:24))
                                                        .foregroundColor(.lavender)
                                                        .multilineTextAlignment(.trailing)
                                                }
                                            } //label
                                        } //end Hstack for title and bookmark
                                        
                                        Text("\(journals.date, formatter: dateFormatter)")
                                        
                                        Text(journals.content)
                                            .font(.system(size: 18  , weight: .regular))
                                        //                                        .frame(width: 295, height: 105)
                                            .multilineTextAlignment(.leading)
                                        //
                                        //
                                        
                                    }// end VStack
                                    .swipeActions(edge: .leading) {
                                        Button(action: {
                                            editingJournal = journals //the journal i wanna edit
                                            showJournalEntryView.toggle() //toggle show
                                        }) //end action
                                        {
                                            Image(systemName: "pencil")
                                        }
                                        .tint(.editPurple)
                                        .sheet(isPresented: $showJournalEntryView){
                                            JournalEntryView(showJournalEntryView: $showJournalEntryView, journals: $journals, editingJournal: $editingJournal, date: $date)
                                        } // end sheet
                                    } //end swipe
                                    
                                    .swipeActions(edge: .trailing){
                                        Button(action: {
                                            deleteJournal(journal: journals)
                                        }) //end action
                                        {
                                            Image(systemName: "trash")
                                        }
                                        .tint(.deleteRed)
                                    } //end swipe trailing
                                }// end foreach loop
                            }// end list
                            .searchable(text: $searchText).accentColor(.darkPurple)
                            .listRowSpacing(15)
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
                                        Button("Bookmark") { selectedFilter = "Bookmarked"}
                                        Button("Journal date") { selectedFilter = "Sorted by Date"}
                                        
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
                                        showJournalEntryView.toggle()
                                    })//end action
                                    {
                                        ZStack{
                                            Circle()
                                                .fill(.darkGrey)
                                                .frame(width: 30, height: 30)
                                            Image(systemName: "plus")
                                            //                                        .resizable()
                                                .fontWeight(.regular)
                                                .frame(width: 23 , height: 26)
                                                .foregroundColor(.lavender)
                                            
                                        }//end label ZStack
                                    }//end label & button parameter
                                    .sheet(isPresented: $showJournalEntryView){
                                        JournalEntryView(showJournalEntryView: $showJournalEntryView, journals: $journals, editingJournal: $editingJournal, date: $date)
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
