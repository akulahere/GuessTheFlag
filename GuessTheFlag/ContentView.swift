//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dmytro Akulinin on 01.08.2022.
//

import SwiftUI

struct ContentView: View {
  @State private var showingAlert = false

  var body: some View {
      Button("Show Alert") {
        showingAlert = true
      }
      .alert("Important message", isPresented: $showingAlert) {
        Button("OK", role: .destructive) { }
      } message: {
        Text("Please read this.")
      }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
        .previewDevice("iPhone 11 Pro Max")
    }
}
