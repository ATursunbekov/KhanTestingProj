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
            VStack {
                HStack {
                    VStack {
                        Text("From")
                        DatePicker("", selection: $viewModel.fromDate, displayedComponents: [.date])
                            .labelsHidden()
                    }
                    VStack {
                        Text("To")
                        DatePicker("", selection: $viewModel.toDate, displayedComponents: [.date])
                            .labelsHidden()
                    }
                }
                .padding()
                
                List(viewModel.filteredDevices) { seance in
                    NavigationLink(destination: SeanceScreen(seance: seance)) {
                        VStack(alignment: .leading) {
                            Text("Scanned at: \(seance.date)")
                                .font(.system(size: 18, weight: .bold))
                            Text(seance.devices.map { $0.name }.joined(separator: ", "))
                                .font(.system(size: 12, weight: .light))
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
            
            if viewModel.filteredDevices.isEmpty {
                Text("No Seances!")
                    .font(.system(size: 32, weight: .bold))
            }
        }
        .navigationTitle("Scan history")
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
    HistoryView()
}
