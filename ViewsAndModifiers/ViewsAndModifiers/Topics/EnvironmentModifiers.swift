//
//  EnvironmentModifiers.swift
//  ViewsAndModifiers
//
//  Created by Rolando Garcia on 30/03/22.
//

import SwiftUI

struct EnvironmentModifiers: View {
    var body: some View {
        VStack {
            Text("Gryffindor")
            Text("Rolando")
            Text("Garcia")
            Text("Robert")
        }
        // Environment modifiers
        // Because apply to the whole view
        .font(.title)
    }
}

struct EnvironmentModifiers_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentModifiers()
    }
}
