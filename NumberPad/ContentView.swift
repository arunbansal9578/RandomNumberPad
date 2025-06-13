//
//  ContentView.swift
//  NumberPad
//
//  Created by Arun Kumar on 13/06/25.
//

import SwiftUICore
import SwiftUI

struct ContentView: View {
    
    @State private var isPadVisible = false
    @State private var inputValue = ""
 
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Entered: \(inputValue)")
                    .font(.title2)

                Button("Random Number Pad") {
                    isPadVisible = true
                }
                .padding()
                .background(Color.indigo)
                .foregroundColor(.white)
                .cornerRadius(12)
            }

            if isPadVisible {
                Color.black.opacity(0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPadVisible = false
                    }

                VStack {
                    Spacer()
                    CustomNumberPadView(
                        isPresented: $isPadVisible,
                        fullValue: $inputValue,
                        onSingleTap: { digit in
                            print("Tapped digit: \(digit)")
                        }
                    )
                    .transition(.move(edge: .bottom))
                }
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: isPadVisible)
    }
}
