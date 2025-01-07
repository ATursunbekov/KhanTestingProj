//
//  ContentView.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 6/1/25.
//

import SwiftUI
import Lottie

struct MainView: View {
    
    @State var showSplash = true
    @State private var showSuccessPopup = false
    @State private var showSearchingView = false
    @State private var deviceCount = 0
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        if showSplash {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            self.showSplash = false
                        }
                    }
                }
        } else {
            ZStack {
                VStack{
                    HStack(alignment: .center) {
                        Text("Start scanning devices:")
                        
                        Spacer()
                        
                        Button(action: startScan) {
                            Text("Scan for Devices")
                                .font(.headline)
                                .padding(8)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    List {
                        ForEach(viewModel.discoveredDevices) { device in
                            NavigationLink(destination: DetailView(device: device)) {
                                Text("Device name: \(device.name)")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(.black)
                            }
                            .disabled(showSearchingView)
                        }
                    }
                }
                if viewModel.discoveredDevices.isEmpty {
                    Text("No devices!")
                        .font(.system(size: 32, weight: .bold))
                }
            }
            .navigationTitle("Bluetooth Devices")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(destination: HistoryView()) {
                    Image(systemName: "clock")
                        .foregroundStyle(.black)
                }
                .disabled(showSearchingView)
            }
            .overlay(content: {
                ZStack {
                    if showSuccessPopup || showSearchingView || viewModel.bluetoothTurnedOff {
                        Color.black
                            .opacity(0.2)
                            .ignoresSafeArea()
                        Color.white
                            .frame(width: 250, height: 250)
                            .cornerRadius(20)
                            .shadow(radius: 2)
                    }
                    
                    if showSearchingView {
                        VStack {
                            LottieView(animationFileName: "searching", loopMode: .autoReverse)
                                .frame(width: 150, height: 150)
                            Text("Searching...")
                                .fontWeight(.medium)
                                .font(.system(size: 18))
                        }
                    } else if viewModel.bluetoothTurnedOff {
                        VStack {
                            LottieView(animationFileName: "error", loopMode: .autoReverse)
                                .frame(width: 150, height: 150)
                            
                            VStack {
                                Text("Turn on Bluetooth")
                                    .fontWeight(.medium)
                                    .font(.system(size: 18))
                                    .offset(y: -10)
                                
                                Button{
                                    viewModel.bluetoothTurnedOff = false
                                }label: {
                                    Text("OK")
                                        .font(.headline)
                                        .padding(8)
                                }
                                .offset(y: -10)
                            }
                        }
                    } else if showSuccessPopup {
                        VStack {
                            LottieView(animationFileName: "success", loopMode: .autoReverse)
                                .frame(width: 100, height: 100)
                            
                            Spacer()
                                .frame(height: 30)
                            
                            VStack {
                                Text("Found \(deviceCount)")
                                    .fontWeight(.medium)
                                    .font(.system(size: 18))
                                
                                Button{
                                    showSuccessPopup = false
                                }label: {
                                    Text("OK")
                                        .font(.headline)
                                        .padding(8)
                                }
                            }
                        }
                    }
                }
            })
        }
    }
    
    private func startScan() {
        viewModel.startScanning()
        if !viewModel.bluetoothTurnedOff {
            showSearchingView = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                viewModel.stopScanning()
                deviceCount = viewModel.discoveredDevices.count
                showSearchingView = false
                showSuccessPopup = true
            }
        }
    }
}

#Preview {
    MainView()
}

