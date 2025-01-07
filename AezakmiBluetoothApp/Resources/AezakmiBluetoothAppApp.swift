//
//  AezakmiBluetoothAppApp.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 6/1/25.
//

import SwiftUI

@main
struct AezakmiBluetoothAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
