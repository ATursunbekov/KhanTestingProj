//
//  SearchSeans.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 7/1/25.
//

import Foundation

struct SearchSeans: Identifiable {
    let id = UUID()
    let date: Date
    let devices: [BluetoothDevice]
}
