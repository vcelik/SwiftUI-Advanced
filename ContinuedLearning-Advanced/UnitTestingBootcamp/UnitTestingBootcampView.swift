//
//  UnitTestingBootcampView.swift
//  ContinuedLearning-Advanced
//
//  Created by Volkan Celik on 05/10/2023.
//

import SwiftUI



struct UnitTestingBootcampView: View {
    
    @StateObject private var vm:UnitTestingBootcampViewModel
    
    init(isPremium:Bool){
        _vm=StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootcampView(isPremium: true)
}
