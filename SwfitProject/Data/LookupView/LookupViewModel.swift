//
//  LookupViewModel.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//


import UIKit
import RxSwift
import RxCocoa

class LookupViewModel{
   
    var input = Input()
    let output = Output()
    
    struct Input {
        let list_Data = ["Lookup(데이터)"]
        
        //옵져버
        var myProperty = 5 {
            //set 되기전에 호출
            willSet(newPropertyValue) {
                print("Will set to \(newPropertyValue). Previous value was \(myProperty)")
            }
            //set 변경후 호출
            didSet(oldPropertyValue) {
                print("Did set to \(myProperty). Previous value was\(oldPropertyValue)")
            }
        }
        
    }
    
    struct Output {
        
    }
     
    var bag = DisposeBag()

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
