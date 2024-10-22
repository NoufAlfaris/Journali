//
//  ContentView.swift
//  Journali
//
//  Created by Nouf on 20/10/2024.
//

import SwiftUI

struct EmptyState: View {
    @State var showAddJournal = false
    
    var body: some View {
        
        NavigationView{
                ZStack{
                    //background color
                    Color(.background)
                        .ignoresSafeArea()
                    
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
                    
                    
                    
                } // end first ZStack
                .navigationTitle("Journal")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar{
                    // plus and filtering buttons
                    ToolbarItem(placement: .topBarTrailing)
                    {
                        HStack{
                            //button 1 filtering (menu)
                            Menu{
                                Button("Bookmark", action: filterByBookmark)
                                Button("Journal date", action: filterByDate)
                                
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
                                showAddJournal.toggle()
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
                            .sheet(isPresented: $showAddJournal){
                                AddJournalView(showAddJournal: $showAddJournal)
                            } // end sheet
                        } //end Hstack for buttons
                    } // end tool bar item1
                }//end tool bar
           
            
            
          
        }//end navigation view
    } // end body
    //filter by bookmark function
    func filterByBookmark() /*-> [Journal]*/{
       print("bookmark")
    } //end bookmark function
    
    func filterByDate() /*-> [Journal]*/{
       print("date")
    } //end date funtion
} // end struct

#Preview {
    EmptyState()
}
