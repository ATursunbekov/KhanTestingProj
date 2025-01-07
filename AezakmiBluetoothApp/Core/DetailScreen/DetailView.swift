//
//  DetailView.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 7/1/25.
//

import SwiftUI

struct DetailView: View {
    
    var device: BluetoothDevice
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Spacer()
                
                LottieView(animationFileName: "devices", loopMode: .autoReverse)
                    .frame(width: 350, height: 350)
                
                Spacer()
            }
            
            
            Text("Device name: \(device.name)")
                .font(.system(size: 24, weight: .bold))
            Text("UUID: \(device.uuid)")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
            Text("RSSI: \(device.rssi)")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrowshape.backward.fill")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}
