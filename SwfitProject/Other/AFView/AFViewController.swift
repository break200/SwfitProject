//
//  AFViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/12.
//

import UIKit
import Alamofire

class AFViewController: BaseViewController {

    @IBOutlet weak var lab_Int: UILabel!
    @IBOutlet weak var btn_Progress: UIButton!
    fileprivate(set) var viewModel = AFViewModel()
    
    typealias handle = (Bool) -> ()
    typealias progress = (Int) -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        screenSetupConfig()
    }
    
    //MARK: - 화면 구성 메서드 모음
    private func screenSetupConfig() {
        bindButton()
    }
    
    private func bindButton(){
          
        //UI 버튼
        btn_Progress.rx.tap.bind { [weak self] _ in
            self?.escapingClouser(with: "") { progress in
                print(progress)
            } handle: { check in
                print(check)
            }
        }.disposed(by: viewModel.bag)
        
    }
    
    func escapingClouser(with s1:String , pro:@escaping progress , handle:@escaping handle){
    
        let url = "http://212.183.159.230/50MB.zip"
        // 파일매니저
        let fileManager = FileManager.default
        // 앱 경로
        let appURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // 파일이름 url 의 맨 뒤 컴포넌트로 지정 (50MB.zip)
        let fileName : String = URL(string: url)!.lastPathComponent
        // 파일 경로 생성
        let fileURL = appURL.appendingPathComponent(fileName)
        // 파일 경로 지정 및 다운로드 옵션 설정 ( 이전 파일 삭제 , 디렉토리 생성 )
        let destination: DownloadRequest.Destination = { _, _ in
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        // 다운로드 시작
        AF.download(url, method: .get, parameters: nil, encoding: JSONEncoding.default, to: destination).downloadProgress { (progress) in
            // 이 부분에서 프로그레스 수정
//            print(Float(progress.fractionCompleted))
//            print(Int(progress.fractionCompleted * 100))
            self.lab_Int.text = "\(Int(progress.fractionCompleted * 100))"
            pro(Int(progress.fractionCompleted * 100))
        }.response{ response in
                if response.error != nil {
                    print("파일다운로드 실패")
                    handle(false)
                }else{
                    print("파일다운로드 완료")
                    handle(true)
                }
            
        }
    }
    
}
