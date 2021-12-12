//
//  UiinViewModel.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import Foundation
import Foundation
import UIKit
import RxSwift
import RxCocoa

class UiinViewModel{
   
    let input = Input()
    let output = Output()
    
    struct Input {
        let list_Data = ["UI","데이터","추가"]
    }
    
    struct Output {
        
    }
     
    var bag = DisposeBag()

    init() {

    }
    
}

