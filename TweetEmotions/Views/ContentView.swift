//
//  ContentView.swift
//  TweetEmotions
//
//  Created by Developer on 9/22/20.
//

import SwiftUI

struct ContentView: View {
    @State var item: String = ""
    @State var isTyping: Bool = false
    
    @ObservedObject var vm = TwitMotions()
    
    var body: some View {
        ZStack {
            VStack{
                Text("Twitmotions")
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, 50)
            .zIndex(1)
            Color(#colorLiteral(red: 0.3960784314, green: 0.4666666667, blue: 0.5254901961, alpha: 1))
            
            
            Color(#colorLiteral(red: 0.1137254902, green: 0.631372549, blue: 0.9490196078, alpha: 1))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .edgesIgnoringSafeArea(.all)
                .offset(x: 0, y: 100)
            
            VStack {
                Text(vm.mood).font(.system(size: 150))
                ZStack{
                    TextField("Search Twitter!", text: $item)
                        .padding()
                        .zIndex(2)
                        .frame(width: 300, height: 50, alignment: .center)
                    RoundedRectangle(cornerRadius: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: isTyping ? 2 : 0).animation(.easeIn))
                        .foregroundColor(Color(.systemGray6))
                        .frame(width: 300, height: 50, alignment: .center)
                    
                }
                
                ZStack {
                    Button(action: {
                        if item != ""{
                            vm.getMood(for: item)
                        }
                    }, label: {
                        HStack {
                            Text("Go")
                                .foregroundColor(.white)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                        }
                    }).zIndex(2)
                    
                    Color(#colorLiteral(red: 0.8666666667, green: 0.1725490196, blue: 0, alpha: 1))
                        .frame(width: 90, height: 50, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }.offset(y: 60)
                
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
