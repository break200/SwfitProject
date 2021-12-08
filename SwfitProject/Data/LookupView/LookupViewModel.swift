//
//  LookupViewModel.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LookupViewModel{
   
    let input = Input()
    let output = Output()
    
    struct Input {
        let list_Data = ["Lookup(데이터)"]
    }
    
    struct Output {
        
    }
     
    var disposeBag = DisposeBag()

    init() {

    }
    
}

@dynamicMemberLookup
struct Thing {
    subscript(dynamicMember member:String) -> String {
        let props = [
            "name":"mograine",
            "channel":"Ios developer",
            "platform":"IOS",
            "country":"korea",
        ]
        return props[member,default: "-"]
    }
}
