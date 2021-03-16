//
//  ContentView.swift
//  swiftUIDemo
//
//  Created by Mikhail Udotov on 16.03.2021.
//

import SwiftUI

struct ContentView: View {
    
    //images
    @State private var slotsIcons = ["apple", "star", "cherry"]
    @State private var iconNumber = [0,0,0]
    @State private var backGrounds = [Color.white, Color.white, Color.white]
    
    @State private var credits = 1000
    
    private var betAmount = 5
    private var extraBetAmount = 5
    
    var body: some View {
        ZStack {
            //background
            Rectangle().foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Rectangle().foregroundColor(Color(red: 228/225, green: 195/225, blue: 76/225)).rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            //ui elements
            VStack {
                Spacer()
                //title
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("SwiftUI Slots Demo").foregroundColor(.white).bold()
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }.scaleEffect(1.5)
                
                Spacer()
                
                //credits counter
                Text("Credits: "+String(credits)).foregroundColor(.black).bold().padding(.all, 10).background(Color(.white).opacity(0.5)).cornerRadius(20)
                
                Spacer()
                //slots
                HStack {
                    Spacer()
                    SlotImage(slotImage: $slotsIcons[iconNumber[0]], backgtoundColor: $backGrounds[0])
                    SlotImage(slotImage: $slotsIcons[iconNumber[1]], backgtoundColor: $backGrounds[1])
                    SlotImage(slotImage: $slotsIcons[iconNumber[2]], backgtoundColor: $backGrounds[2])
                    Spacer()
                }
                Spacer()
                //spin button
                Button(action: {
                    
                    //set backgrounds back to normal
                    backGrounds = backGrounds.map { _ in
                        Color.white
                    }
                    
                    //Changing images
                    iconNumber = iconNumber.map({ _ in
                        Int.random(in: 0...slotsIcons.count-1)
                    })
                    
                    //Check the results
                    if self.iconNumber[0] == self.iconNumber[1] && self.iconNumber[1] == self.iconNumber[2]{
                        //won
                        credits += betAmount*5
                        backGrounds = backGrounds.map { _ in
                            Color.green
                        }
                    } else {
                        //lost
                        credits -= betAmount
                    }
                }, label: {
                    Text("Spin").bold().foregroundColor(.white).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10).padding([.leading, .trailing], 30).background(Color(.systemPink)).cornerRadius(20)
                })
                Spacer()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
    }
}
