//
//  ButtonIcon.swift
//  RoackPaperScissors
//
//  Created by Rolando Garcia on 02/04/22.
//

import SwiftUI

struct ButtonIcon: View {
    
    let icon : String
    let callback : () -> Void?
    
    var body: some View {
        Button {
            callback()
        } label: {
            TextIcon(icon: icon)
        }
    }
}

struct ButtonIcon_Previews: PreviewProvider {
    static var previews: some View {
        ButtonIcon(icon: "🏞"){
            
        }
    }
}
