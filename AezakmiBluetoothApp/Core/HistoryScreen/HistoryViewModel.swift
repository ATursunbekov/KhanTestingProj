//
//  HistoryViewModel.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 7/1/25.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    @Published var devices: [BluetoothDevice] = []
    @Published var searchText = ""
    
    var filteredDevices: [BluetoothDevice] {
        if searchText.isEmpty {
            return devices
        } else {
            return devices.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func fetchAllDevices() {
        devices = RealmManager.shared.fetchDevices()
    }
}
