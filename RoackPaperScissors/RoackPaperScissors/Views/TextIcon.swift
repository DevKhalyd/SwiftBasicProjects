//
//  TextIcon.swift
//  RoackPaperScissors
//
//  Created by Rolando Garcia on 02/04/22.
//

import SwiftUI

struct TextIcon: View {
    
    let icon : String
    
    var body: some View {
        Text(icon)
            .font(.largeTitle)
            .padding()
    }
}

struct TextIcon_Previews: PreviewProvider {
    static var previews: some View {
        TextIcon(icon: "✂️")
    }
}
