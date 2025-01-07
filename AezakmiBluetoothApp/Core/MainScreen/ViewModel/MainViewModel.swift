//
//  MainViewModel.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 6/1/25.
//

import CoreBluetooth

class MainViewModel: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var discoveredDevices: [BluetoothDevice] = []
    @Published var isPowerOn = true
    @Published var bluetoothTurnedOff = false
    
    private var centralManager: CBCentralManager!
    private var peripherals: [String: CBPeripheral] = [:]
    private var connectingPeripheral: CBPeripheral?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        isPowerOn = (central.state == .poweredOn)
        if isPowerOn {
            print("Bluetooth is powered on")
            bluetoothTurnedOff = false
        } else {
            print("Bluetooth is not available: \(central.state.rawValue)")
            bluetoothTurnedOff = true
            discoveredDevices.removeAll()
        }
    }
    
    func startScanning() {
        guard isPowerOn else {
            bluetoothTurnedOff = true
            return
        }
        
        print("Scanning started...")
        discoveredDevices.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
    }
    
    func stopScanning() {
        RealmManager.shared.saveSearchSeans(SearchSeans(date: Date(), devices: discoveredDevices))
        centralManager.stopScan()
        print("Scanning stopped.")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !discoveredDevices.contains(where: { $0.uuid == peripheral.identifier.uuidString }) && peripheral.name != nil {
            peripherals[peripheral.identifier.uuidString] = peripheral
            let device = BluetoothDevice(
                name: peripheral.name ?? "Unknown",
                uuid: peripheral.identifier.uuidString,
                rssi: RSSI.intValue,
                date: Date()
            )
            discoveredDevices.append(device)
        }
    }
}
