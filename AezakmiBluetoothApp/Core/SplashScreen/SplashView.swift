//
//  SplashView.swift
//  AezakmiBluetoothApp
//
//  Created by Alikhan Tursunbekov on 6/1/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            LottieView(animationFileName: "launch", loopMode: .autoReverse)
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    SplashView()
}
