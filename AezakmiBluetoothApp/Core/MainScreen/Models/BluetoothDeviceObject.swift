//
//  BluetoothDeviceObject.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 7/1/25.
//

import Foundation
import RealmSwift

class BluetoothDeviceObject: Object {
    @Persisted(primaryKey: true) var uuid: String
    @Persisted var name: String = ""
    @Persisted var rssi: Int = 0
    @Persisted var date: Date = Date()
}
