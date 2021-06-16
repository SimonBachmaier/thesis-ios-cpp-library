//
//  ContentView.swift
//  NativeInterfacesApplication
//
//  Created by SimonBachmaier on 15.06.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(HelloWorldWrapper().sayHello())
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
