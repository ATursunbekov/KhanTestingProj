//
//  HistoryViewModel.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 7/1/25.
//

import Foundation
import SwiftUI

class HistoryViewModel: ObservableObject {
    
    @Published var searchSeances: [SearchSeans] = []
    @Published var searchText = ""
    @Published var fromDate: Date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
    @Published var toDate: Date = Date()
    
    var filteredDevices: [SearchSeans] {
        if searchText.isEmpty {
            return searchSeances.filter { $0.date >= fromDate && $0.date <= toDate }.sorted { $0.date > $1.date }
        } else {
            return searchSeances.filter { $0.date >= fromDate && $0.date <= toDate }.filter { seans in
                seans.devices.contains { device in
                    device.name.lowercased().contains(searchText.lowercased())
                }
            }.sorted { $0.date > $1.date }
        }
    }
    
    func fetchAllDevices() {
        searchSeances = RealmManager.shared.fetchSearchSeans().sorted { $0.date > $1.date }
    }
}
