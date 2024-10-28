//
//  splashScreen.swift
//  Journali
//
//  Created by Nouf on 28/10/2024.
//

import SwiftUI

struct splashScreen: View {
    @Binding var isActive: Bool
//    @StateObject var jvm = JournalViewModel()
    var body: some View{
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
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                            withAnimation {
//                               isActive = false
//                            }
//                        }
//                    }
                Text("Journali")
                    .font(.system(size: 42, weight: .black))
                    .frame(width: 174 , height: 50)
                    .foregroundColor(.white)
                
                Text("Your thoughts, your story")
                    .font(.system(size: 18, weight: .light))
                    .tracking(1)
                
            } //vstack
        } //end zstack
    }
}
