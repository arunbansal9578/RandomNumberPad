//
//  CustomNumberPadView.swift
//  NumberPad
//
//  Created by Arun Kumar on 13/06/25.
//

import SwiftUI

struct CustomNumberPadView: View {
    
    @Binding var isPresented: Bool
    @Binding var fullValue: String
    var onSingleTap: ((String) -> Void)?

    @State private var gridNumbers: [Int] = []

    private let columns = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]

    init(isPresented: Binding<Bool>, fullValue: Binding<String>, onSingleTap: ((String) -> Void)? = nil) {
        self._isPresented = isPresented
        self._fullValue = fullValue
        self.onSingleTap = onSingleTap

        let digits = Array(1...9)
        self._gridNumbers = State(initialValue: digits.shuffled())
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Enter Number")
                .font(.headline)
                .padding(.top)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(gridNumbers, id: \.self) { number in
                    numberButton(for: number)
                }
            }

            HStack(spacing: 12) {
                numberButton(for: 0)

                Spacer()

                Button(action: {
                    isPresented = false
                }) {
                    Text("Done")
                        .font(.title3)
                        .frame(width: 100, height: 60)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .fontWeight(.bold)
                }
            }
            .padding(.top, 10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 8)
        )
        .padding()
        .onAppear {
            // Shuffle each time the view appears
            gridNumbers = Array(1...9).shuffled()
        }
    }


    private func numberButton(for number: Int) -> some View {
        Button(action: {
            let digit = "\(number)"
            fullValue += digit
            onSingleTap?(digit)
        }) {
            Text("\(number)")
                .font(.title)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}
