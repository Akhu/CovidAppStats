//
//  CovidProtectionTips.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 17/11/2020.
//

import Foundation

let covidTipList = [
    CovidTip(id: "1", illustration: "wash_hands", title: "Wash your hands frequently", icon: "hands.sparkles", content: "Wash your hands often with soap and water for at least 20 seconds especially after you have been in a public place."),
    CovidTip(id: "2", illustration:"mask", title: "Wear a mask", icon: "lungs", content: "Wear a mask when the 2 meters distance between people and you cannot be respected and in public places."),
    CovidTip(id: "3", illustration:"crowd", title: "Avoid crowd", icon: "person.fill.and.arrow.left.and.arrow.right", content: "Stay at least at 2 meters distance from others people. Avoid crowded places and closes contacts."),
]

public struct CovidTip: Hashable, Identifiable {
    public var id: String
    public var illustration: String
    public var title: String
    public var icon: String
    public var content: String
    
    public init(id: String, illustration: String, title: String, icon: String, content: String) {
        self.id = id
        self.illustration = illustration
        self.title = title
        self.icon = icon
        self.content = content
    }
}

//"wash_hands"
//"Wash your hands frequently"
//"hand.raised"
//"Wash your hands often with soap and water for at least 20 seconds especially after you have been in a public place."
