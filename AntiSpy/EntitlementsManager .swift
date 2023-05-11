//
//  EntitlementsManager .swift
//  AntiSpy
//
//  Created by Rome on 4/29/23.
//

import SwiftUI

class EntitlementManager: ObservableObject {
    static let userDefaults = UserDefaults(suiteName: "fi.your.app")!

    @AppStorage("hasPro#", store: userDefaults)
    var hasPro: Bool = false
    @AppStorage("islicense#", store: userDefaults)
    var hasLicense: Bool = false
}
