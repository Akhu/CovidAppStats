//
//  SearchBarText.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 27/07/2020.
//

import SwiftUI

struct SearchBarText: View {
    
    var placeholder: String
        
    @Binding var text: String
    
    @Environment(\.colorScheme) var colorScheme
    
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color(.systemGray5)
        } else {
            return Color(.systemGray6)
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.secondary)
            TextField(placeholder, text: $text)
            if text != "" {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium)
                    .foregroundColor(Color(.systemGray3))
                    .padding(3)
                    .onTapGesture {
                        withAnimation {
                            self.text = ""
                          }
                    }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.vertical, 10)
    }
}

struct SearchBarText_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarText(placeholder: "Placeholder", text: .constant(""))
    }
}
