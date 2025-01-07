//
//  BluetoothDevice.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 7/1/25.
//

import Foundation

struct BluetoothDevice: Identifiable {
    let id = UUID()
    let name: String
    let uuid: String
    let rssi: Int
    var date: Date
}
