//
//  ContentView.swift
//  Restaurant Seeker
//
//  Created by Minnie on 11/17/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello Foodies!")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color.orange)
                .lineLimit(0)
                
                
                
            Text("Welcome to Restaurant Seeker")
                .font(.footnote)
                .fontWeight(.heavy)
                .foregroundColor(Color.yellow)
            
            Text("Find a restaurant by spinning the wheel")
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(Color.purple)
                .padding(.bottom, -250)
            
            Circle()
                .padding(.bottom, -250)
                .frame(width: 250.0, height: 250.0)
                .foregroundColor(.purple)
            
            Spacer ()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
