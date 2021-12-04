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
   
    let input = Input()
    let output = Output()
    
    struct Input {
        let list_Data = ["UI","데이터","추가"]
    }
    
    struct Output {
        
    }
     
    var disposeBag = DisposeBag()

    init() {

    }
    
}


