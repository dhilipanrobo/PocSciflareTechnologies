//
//  POC_Sciflare_TechnologiesApp.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import SwiftUI

@main
struct POC_Sciflare_TechnologiesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
