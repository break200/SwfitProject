//
//  AlbumViewModel.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/12.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumViewModel{
   
    var input = Input()
    let output = Output()
    
    struct Input {
        var filePath = String()
        var videoPath = String()
        
        let file_Name = "mograine"
        let video_Url = "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4"
    }
    
    struct Output {
        
    }
     
    var bag = DisposeBag()

    init() {

    }
    
}

