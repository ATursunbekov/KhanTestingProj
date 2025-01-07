//
//  SeanceScreen.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 7/1/25.
//

import SwiftUI

struct SeanceScreen: View {
    
    var seance: SearchSeans = SearchSeans(date: Date(), devices: [])
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List(seance.devices) { device in
            NavigationLink(destination: DetailView(device: device)) {
                VStack(alignment: .leading) {
                    Text("Device name: \(device.name)")
                        .font(.system(size: 18, weight: .bold))
                    Text("Date: \(device.date)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Detected devices")
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

#Preview {
    SeanceScreen()
}
