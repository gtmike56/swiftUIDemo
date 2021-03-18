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
    @State private var iconNumber = [0,0,0,0,0,0,0,0,0]
    @State private var backGrounds = [Color.white, Color.white, Color.white, Color.white, Color.white, Color.white, Color.white, Color.white, Color.white]
    
    @State private var credits = 1000
    
    @State private var enoughCreditsX10 = true
    @State private var enoughCredits = true
    
    private var betAmount = 5
    private var extraBetAmount = 50
    
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
                Text("Credits: "+String(credits)).fontWeight(.heavy).foregroundColor(.black).padding(.all, 10).background(Color(.white).opacity(0.5)).cornerRadius(20).padding(.bottom, 15)
                
                Button(action: {
                    //set backgrounds back to normal
                    backGrounds = backGrounds.map { _ in
                        Color.white
                    }
                    
                    //Changing images to default
                    iconNumber = iconNumber.map({ _ in
                        0
                    })
                    
                    //Resetting credits
                    credits = 1000
                    enoughCreditsX10 = true
                    enoughCredits = true
                    
                }, label: {
                    Text("New Game").bold().foregroundColor(.black).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10).padding([.leading,.trailing], 20).background(Color(.green).opacity(0.5)).cornerRadius(20)
                })
                Spacer()
                //slots
                VStack {
                    HStack {
                        Spacer()
                        SlotImage(slotImage: $slotsIcons[iconNumber[0]], backgtoundColor: $backGrounds[0])
                        SlotImage(slotImage: $slotsIcons[iconNumber[1]], backgtoundColor: $backGrounds[1])
                        SlotImage(slotImage: $slotsIcons[iconNumber[2]], backgtoundColor: $backGrounds[2])
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        SlotImage(slotImage: $slotsIcons[iconNumber[3]], backgtoundColor: $backGrounds[3])
                        SlotImage(slotImage: $slotsIcons[iconNumber[4]], backgtoundColor: $backGrounds[4])
                        SlotImage(slotImage: $slotsIcons[iconNumber[5]], backgtoundColor: $backGrounds[5])
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        SlotImage(slotImage: $slotsIcons[iconNumber[6]], backgtoundColor: $backGrounds[6])
                        SlotImage(slotImage: $slotsIcons[iconNumber[7]], backgtoundColor: $backGrounds[7])
                        SlotImage(slotImage: $slotsIcons[iconNumber[8]], backgtoundColor: $backGrounds[8])
                        Spacer()
                    }
                }
                
                Spacer()
                //buttons
                HStack {
                    Spacer()
                    //button x10
                    VStack {
                        Button(action: {
                            spin(x10: true)
                        }, label: {
                            Text("Max Spin").bold().foregroundColor(.white).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10).padding([.leading, .trailing], 30).background(Color(.systemPink)).cornerRadius(20)
                        }).disabled(!enoughCreditsX10)
                        Text("25 credits").bold()
                    }
                    Spacer()
                    
                    //button x1
                    VStack {
                        Button(action: {
                            spin(x10: false)
                        }, label: {
                            Text("Spin").bold().foregroundColor(.white).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10).padding([.leading, .trailing], 30).background(Color(.systemPink)).cornerRadius(20)
                        }).disabled(!enoughCredits)
                        Text("5 credits").bold()
                    }
                    Spacer()
                }
                
                Spacer()
            }
            
        }
    }
    
    func spin(x10:Bool) {
        //set backgrounds back to normal
        backGrounds = backGrounds.map { _ in
            Color.white
        }
        
        if x10 {
            
            //Spin all slots
            iconNumber = iconNumber.map({ _ in
                Int.random(in: 0...slotsIcons.count-1)
            })
            
            //Check the results
            checkResult(x10: true)
        } else {
            
            //Spin middle row
            iconNumber[3] = Int.random(in: 0...slotsIcons.count-1)
            iconNumber[4] = Int.random(in: 0...slotsIcons.count-1)
            iconNumber[5] = Int.random(in: 0...slotsIcons.count-1)
            
            //Check the results
            checkResult(x10: false)
        }
    }
    
    //Check win
    func checkResult(x10: Bool) {
        var matches = 0
        
        if x10 {
            //top row
            if checkMatch(index1: 0, index2: 1, index3: 2) {
                matches += 1
            }
            
            //middle row
            if checkMatch(index1: 3, index2: 4, index3: 5) {
                matches += 1
            }
            
            //buttom row
            if checkMatch(index1: 6, index2: 7, index3: 8) {
                matches += 1
            }
            
            //diagonal 1
            if checkMatch(index1: 0, index2: 4, index3: 8) {
                matches += 1
            }
            
            //diagonal 2
            if checkMatch(index1: 2, index2: 4, index3: 6) {
                matches += 1
            }
            
        } else {
            //middle row
            if checkMatch(index1: 3, index2: 4, index3: 5) {
                matches += 1
            }
        }
        
        if matches > 0 {
            //at least one win
            credits += betAmount*matches*2
        } else if !x10 {
            //0 wins single spin
            credits -= betAmount
        } else {
            //0 wins x10 spin
            credits -= betAmount*5
        }
        
        checkCredits()
    }
    
    func checkMatch(index1: Int, index2: Int, index3: Int) -> Bool {
        if self.iconNumber[index1] == self.iconNumber[index2] && self.iconNumber[index2] == self.iconNumber[index3]{
            
            //won
            backGrounds[index1] = Color.green
            backGrounds[index2] = Color.green
            backGrounds[index3] = Color.green
            
            return true
        } else {
            return false
        }
    }
    
    //Check Credits Amount
    func checkCredits(){
        
        if credits < extraBetAmount {
            enoughCreditsX10 = false
        }
        
        if credits < betAmount {
            enoughCredits = false
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
    }
}
