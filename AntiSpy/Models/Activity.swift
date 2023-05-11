//
//  Activity.swift
//  AntiSpy
//
//  Created by Rome on 4/17/23.
//

import Foundation

struct Activity: Decodable, Hashable, Identifiable {
    var id = UUID()
    var startDate: String
    var startTime: String
    var name: String
    var iconName: String
    var serviceName: String
    var period: String
    var _id: Int?
}

