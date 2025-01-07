//
//  RealmManager.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 7/1/25.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static var shared = RealmManager()
    private let realm = try! Realm()
    
    func saveDevices(_ devices: [BluetoothDevice]) {
        do {
            try realm.write {
                for device in devices {
                    let realmDevice = BluetoothDeviceObject()
                    realmDevice.uuid = device.uuid
                    realmDevice.name = device.name
                    realmDevice.rssi = device.rssi
                    realmDevice.date = device.date
                    
                    realm.add(realmDevice, update: .modified)
                }
                print("Devices saved successfully!")
            }
        } catch {
            print("Error saving devices: \(error.localizedDescription)")
        }
    }
    
    func fetchDevices() -> [BluetoothDevice] {
        let realmDevices = realm.objects(BluetoothDeviceObject.self)
        return realmDevices.map { realmDevice in
            BluetoothDevice(
                name: realmDevice.name,
                uuid: realmDevice.uuid,
                rssi: realmDevice.rssi,
                date: realmDevice.date
            )
        }
    }
}
