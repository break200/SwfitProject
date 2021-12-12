//
//  ViewModel.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ViewModel{
   
    var input = Input()
    let output = Output()
    
    struct Input {
        let list_Data = ["UI","데이터","추가"]
        
        //
        var tabbar_index = Int()
        var tabbar_index_Save = Int()
    }
    
    struct Output {
        
    }
     
    var bag = DisposeBag()

    init() {

    }
    
}


