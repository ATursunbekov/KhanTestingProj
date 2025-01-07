//
//  BluetoothDeviceObject.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 7/1/25.
//

import Foundation
import RealmSwift

class BluetoothDeviceRealm: Object {
    @Persisted var name: String = ""
    @Persisted(primaryKey: true) var uuid: String = ""
    @Persisted var rssi: Int = 0
    @Persisted var date: Date = Date()
}

class SearchSeansRealm: Object {
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var date: Date = Date()
    @Persisted var devices: List<BluetoothDeviceRealm> = List<BluetoothDeviceRealm>()
}

