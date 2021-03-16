//
//  SlotImage.swift
//  swiftUIDemo
//
//  Created by Mikhail Udotov on 16.03.2021.
//

import SwiftUI

struct SlotImage: View {
    
    @Binding var slotImage: String
    @Binding var backgtoundColor: Color
    
    var body: some View {
            
        Image(slotImage).resizable().aspectRatio(contentMode: .fit).background(backgtoundColor.opacity(0.6).cornerRadius(20))
    }
}

struct SlotImage_Previews: PreviewProvider {
    static var previews: some View {
        SlotImage(slotImage: Binding.constant("apple"), backgtoundColor: Binding.constant(Color.white))
    }
}
