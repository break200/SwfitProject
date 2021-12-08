//
//  OtherViewModel.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class OtherViewModel{
   
    let input = Input()
    let output = Output()
    
    struct Input {
        let list_Data = ["SwiftUi 연결"]
    }
    
    struct Output {
        
    }
     
    var disposeBag = DisposeBag()

    init() {

    }
    
}

