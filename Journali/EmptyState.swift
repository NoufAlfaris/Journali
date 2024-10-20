//
//  ContentView.swift
//  Journali
//
//  Created by Nouf on 20/10/2024.
//

import SwiftUI

struct EmptyState: View {


    var body: some View {
//        NavigationView{
            ZStack{
                Color(red: 5/255, green: 5/255, blue: 5/255)
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
//        }//end navigation view
//        .navigationBarTitle(Text("Journal").font(.system(size: 34, weight: .semibold))).foregroundColor(.white)
    } // end body
} // end struct

#Preview {
    EmptyState()
}
