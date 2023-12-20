//
//  ContentView.swift
//  MainApp
//
//  Created by Shoeb Khan on 20/12/23.
//

import SwiftUI
import FindMyIPFramework

struct ContentView: View {
    var body: some View {
        VStack {
            IPAddressView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
