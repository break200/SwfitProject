//
//  ViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/04.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit
class ViewController: BaseViewController {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var btn_UI: UIButton!
    @IBOutlet weak var btn_Data: UIButton!
    @IBOutlet weak var btn_Variable: UIButton!
    @IBOutlet weak var btn_Other: UIButton!
    
    fileprivate(set) var viewModel = ViewModel()
    let oneCall = OneCheckCall()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        screenSetupConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      oneCall.call {
         //앱실행시 한번 실행할 작업 내용 선언
         print("하하하")
      }
    }
    
    //MARK: - 화면 구성 메서드 모음
    private func screenSetupConfig() {
        //메인 화면 addChild 지정 세팅
        configtabbarBar()
        bindButton()
        
        
    }
    
    
    //메인 ADDCHILD 세팅
    func configtabbarBar(){
        let youView : UiinViewController = UIStoryboard.storyboard(storyboard: .UI).instantiateViewController()
        let dataView : DataViewController = UIStoryboard.storyboard(storyboard: .Data).instantiateViewController()
        let variableView : VariableViewController = UIStoryboard.storyboard(storyboard: .Variable).instantiateViewController()
        let otherView : OtherViewController = UIStoryboard.storyboard(storyboard: .Other).instantiateViewController()
        
        youView.delegate = self
        dataView.delegate = self
        variableView.delegate = self
        otherView.delegate = self
        
        addChild(youView)
        addChild(dataView)
        addChild(variableView)
        addChild(otherView)
        //실행시 화면 index
        changeVCFromIndex(from: 0)
    }
    
    //MARK:  - 화면 이동 메서드 모음
    func changeVCFromIndex(from index: Int) {
        //상단 체인지 뷰 히든 처리
        if index == 0{
//            view_Title.isHidden = true
//            if viewModel.tabbar_index_Before == 0 {
////                printd("0번 다시 누름")
//                NotificationCenter.default.post(name:Notification.Name(rawValue:Definition.TABLETOP),object: nil,userInfo: nil)
//            }
            viewModel.input.tabbar_index = 0
            btn_UI.isSelected = true
            btn_Data.isSelected = false
            btn_Variable.isSelected = false
            btn_Other.isSelected = false
        }else{
//            view_Title.isHidden = false
            if index == 1{
                viewModel.input.tabbar_index = 1
                btn_UI.isSelected = false
                btn_Data.isSelected = true
                btn_Variable.isSelected = false
                btn_Other.isSelected = false
            }else if index == 2{
                viewModel.input.tabbar_index = 2
                btn_UI.isSelected = false
                btn_Data.isSelected = false
                btn_Variable.isSelected = true
                btn_Other.isSelected = false
                
            }else if index == 3{
                viewModel.input.tabbar_index = 3
                btn_UI.isSelected = false
                btn_Data.isSelected = false
                btn_Variable.isSelected = false
                btn_Other.isSelected = true
            }
        }
        
        //뒤로 가기 위한 인덱스값 저장
        if index != 2{
            viewModel.input.tabbar_index_Save = index
        }
        displayVC(index)
        changeTabbarButton(from:index)
    }
    
    //버튼 클릭시 이미지 버튼 변경 및
    func changeTabbarButton(from index: Int) {
//        p_Image_Total.image = UIImage(named: "home_off")
//        p_Image_My.image = UIImage(named: "tabfeed_off")
//        p_Image_Profile.image = UIImage(named: "tabmypage_off")
//        p_Image_Setting.image = UIImage(named: "tabsetting_off")
        
        if index == 0 {
//            p_Image_Total.image = UIImage(named: "home_on")
        }else if index == 1 {
//            p_Image_My.image = UIImage(named: "tabfeed_on")
        }else if index == 2 {
//            let bWrite =  UIStoryboard(name: Definition.STORY_WRITE, bundle: nil).instantiateViewController(withIdentifier: "BWriteViewController") as! BWriteViewController
//             let bWrite : BWriteViewController = UIStoryboard.storyboard(storyboard: .Main_Write).instantiateViewController()
//            self.navigationController?.pushViewController(bWrite, animated: false)
        }else if index == 3 {
//            p_Image_Profile.image = UIImage(named: "tabmypage_on")
        }else if index == 4 {
//            p_Image_Setting.image = UIImage(named: "tabsetting_on")
        }
    }
    
    func displayVC(_ index: Int) {
        for view: UIView in contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childView: UIView? = children[index].view
        if let aView = childView {
            contentView.addSubview(aView)
            aView.snp.makeConstraints { (make) in
                make.top.equalTo((aView.superview?.snp_top)!)
                make.left.equalTo((aView.superview?.snp.left)!)
                make.right.equalTo((aView.superview?.snp.right)!)
                make.bottom.equalTo((aView.superview?.snp.bottom)!)
            }
        }
    }
    
    //버튼 클릭 이벤트
    func bindButton(){
          
        //UI 버튼
        btn_UI.rx.tap.bind { [weak self] _ in
            if self?.btn_UI.isSelected ?? false{
                return
            }
            self?.changeVCFromIndex(from: 0)
        }.disposed(by:viewModel.bag)
        
        //Data 버튼
        btn_Data.rx.tap.bind { [weak self] _ in
            if self?.btn_Data.isSelected ?? false{
                return
            }
            self?.changeVCFromIndex(from: 1)
        }.disposed(by: viewModel.bag)
        
        //Variable 버튼
        btn_Variable.rx.tap.bind { [weak self] _ in
            if self?.btn_Variable.isSelected ?? false{
                return
            }
            self?.changeVCFromIndex(from: 2)
        }.disposed(by: viewModel.bag)
        
        
        //Other 버튼
        btn_Other.rx.tap.bind { [weak self] _ in
            if self?.btn_Other.isSelected ?? false{
                return
            }
            self?.changeVCFromIndex(from: 3)
        }.disposed(by: viewModel.bag)
    }
    
}

//앱실행시 한번만 호출원할경우
class OneCheckCall {
    var isExec = false
    func call(one: () -> ()) {
        if !isExec {
            one()
            isExec = true
        }
    }
 
}

//버튼 클릭시 호출
extension ViewController:UiinViewDelegate,OtherViewDelegate,VariableDelegate,DataViewDelegate {

    func clickBtnUI(check: Bool) {
        print(check)
    }

    func clickBtnData(check: Bool) {
        print(check)
    }
    
    func clickBtnVariable(check: Bool) {
        print(check)
    }
    
    func clickBtnOther(check: Bool) {
        print(check)
    }
    
    
}
