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

    // Save or update a SearchSeans
    func saveSearchSeans(_ searchSeans: SearchSeans) {
        do {
            try realm.write {
                // Convert SearchSeans to SearchSeansRealm
                let realmSeans = SearchSeansRealm()
                realmSeans.date = searchSeans.date
                
                // Map BluetoothDevice to BluetoothDeviceRealm
                for device in searchSeans.devices {
                    let realmDevice = BluetoothDeviceRealm()
                    realmDevice.name = device.name
                    realmDevice.uuid = device.uuid
                    realmDevice.rssi = device.rssi
                    realmDevice.date = device.date
                    
                    // Add device to SearchSeansRealm
                    realmSeans.devices.append(realmDevice)
                }

                // Save or update
                realm.add(realmSeans, update: .modified)
                print("SearchSeans saved successfully!")
            }
        } catch {
            print("Error saving SearchSeans: \(error.localizedDescription)")
        }
    }

    // Fetch all SearchSeans
    func fetchSearchSeans() -> [SearchSeans] {
        let realmSeances = realm.objects(SearchSeansRealm.self)
        return realmSeances.map { realmSeans in
            // Convert SearchSeansRealm back to SearchSeans
            let devices = Array(realmSeans.devices.map { realmDevice in
                BluetoothDevice(
                    name: realmDevice.name,
                    uuid: realmDevice.uuid,
                    rssi: realmDevice.rssi,
                    date: realmDevice.date
                )
            })
            return SearchSeans(date: realmSeans.date, devices: devices)
        }
    }


    // Update SearchSeans with new devices
    func updateSearchSeansDate(id: ObjectId, newDevices: [BluetoothDevice]) {
        do {
            try realm.write {
                if let realmSeans = realm.object(ofType: SearchSeansRealm.self, forPrimaryKey: id) {
                    for device in newDevices {
                        if let existingDevice = realmSeans.devices.first(where: { $0.uuid == device.uuid }) {
                            // Update the device's date if it exists
                            existingDevice.date = device.date
                        } else {
                            // Add the new device
                            let newRealmDevice = BluetoothDeviceRealm()
                            newRealmDevice.name = device.name
                            newRealmDevice.uuid = device.uuid
                            newRealmDevice.rssi = device.rssi
                            newRealmDevice.date = device.date
                            realmSeans.devices.append(newRealmDevice)
                        }
                    }
                    print("SearchSeans updated successfully!")
                }
            }
        } catch {
            print("Error updating SearchSeans: \(error.localizedDescription)")
        }
    }
}
