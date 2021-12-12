//
//  DataViewModel.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DataViewModel{
   
    let input = Input()
    let output = Output()
    
    struct Input {
        let list_Data = ["Lookup(데이터)"]
    }
    
    struct Output {
        
    }
     
    var bag = DisposeBag()

    init() {

    }
    
}

