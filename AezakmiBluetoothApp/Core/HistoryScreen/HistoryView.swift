//
//  HistoryView.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 6/1/25.
//

import SwiftUI

struct HistoryView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        ZStack {
            List(viewModel.filteredDevices) { device in
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
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
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
        .onAppear {
            viewModel.fetchAllDevices()
        }
    }
}

#Preview {
    HistoryView()
}
