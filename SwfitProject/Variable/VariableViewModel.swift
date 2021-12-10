//
//  VariableViewModel.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/11.
//

import Foundation
import Foundation
import UIKit
import RxSwift
import RxCocoa

class VariableViewModel{
   
    let input = Input()
    let output = Output()
    
    struct Input {
        let list_Data = ["didset"]
    }
    
    struct Output {
        
    }
     
    var disposeBag = DisposeBag()

    init() {

    }
    
}

