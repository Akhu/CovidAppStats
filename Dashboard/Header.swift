//
//  Header.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 27/09/2020.
//

import SwiftUI

struct Header: View {
    let button1Action: () -> ()
    let button2Action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Feeling sick?")
                    .font(.system(size: 18, weight: Font.Weight.bold, design: Font.Design.default))
                Spacer()
                    .frame(height: 12)
                Text("If you feel any of the symptoms or feeling sick, please call the free number by clicking on the call button below")
                    .font(.system(size: 14))
            }
            HStack {
                Button(action: button1Action, label: {
                    HStack {
                        Image(systemName: "phone")
                        Text("Call for help")
                    }
                    
                }).buttonStyle(FlatButtonStyle())
                Button(action: button2Action, label: {
                    Text("Fetch Data")
                }).buttonStyle(OutlineButtonStyle())
            }.padding(.top, 12)
        }
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header { () -> (Void) in
            print("hello World")
        } button2Action: { () -> (Void) in
            print("goodbye world")
        }

    }
}
