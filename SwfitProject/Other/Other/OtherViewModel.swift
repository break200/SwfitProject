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
        let list_Data = ["SwiftUi 연결","통신 프로그래스","앨범 저장(영상,이미지) 영상 인스타공유"]
    }
    
    struct Output {
        
    }
     
    var disposeBag = DisposeBag()

    init() {

    }
    
}

