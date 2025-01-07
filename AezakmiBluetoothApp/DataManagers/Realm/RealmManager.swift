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

    func saveSearchSeans(_ searchSeans: SearchSeans) {
        do {
            try realm.write {
                let realmSeans = SearchSeansRealm()
                realmSeans.date = searchSeans.date
                
                for device in searchSeans.devices {
                    let realmDevice = BluetoothDeviceRealm()
                    realmDevice.name = device.name
                    realmDevice.uuid = device.uuid
                    realmDevice.rssi = device.rssi
                    realmDevice.date = device.date
                    
                    realmSeans.devices.append(realmDevice)
                }

                realm.add(realmSeans, update: .modified)
                print("SearchSeans saved successfully!")
            }
        } catch {
            print("Error saving SearchSeans: \(error.localizedDescription)")
        }
    }

    func fetchSearchSeans() -> [SearchSeans] {
        let realmSeances = realm.objects(SearchSeansRealm.self)
        return realmSeances.map { realmSeans in
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
}
