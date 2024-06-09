//
//  CardView.swift
//  POC Sciflare Technologies
//  Created by Apple on 08/06/24.


import SwiftUI
struct CardView: View {
    var name: String
    var email: String
    var gender: String
    var mobile:String
    
    var body: some View {
        VStack() {
           HStack{
                Text(name)
                    .font(.headline)
                    .padding(.bottom, 2)
                Spacer()
                Text("\(gender)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            HStack{
                Text("\(email)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(mobile)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
