//
//  UnitTestingBootcampViewModel.swift
//  ContinuedLearning-Advanced
//
//  Created by Volkan Celik on 05/10/2023.
//

import Foundation
import SwiftUI

class UnitTestingBootcampViewModel:ObservableObject{
    
    @Published var isPremium:Bool
    @Published var dataArray:[String]=[]
    @Published var selectedItem:String?=nil
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item:String){
        guard !item.isEmpty else {return}
        self.dataArray.append(item)
    }
    
    func selectItem(item:String){
        if let x=dataArray.first(where: {$0 == item}){
            selectedItem=x
        }else{
            selectedItem=nil
        }
    }
}
