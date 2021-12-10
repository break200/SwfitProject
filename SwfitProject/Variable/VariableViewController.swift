//
//  VariableViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/11.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture


protocol VariableDelegate{
    func clickBtnVariable(check:Bool)
}

class VariableViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: (VariableDelegate)?
    
    fileprivate(set) var viewModel = DataViewModel()
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
  
    }

}


extension VariableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.input.list_Data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VariableTableCell", for: indexPath) as? VariableTableCell else {
            return UITableViewCell()
        }
        cell.lab_Title.text = viewModel.input.list_Data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row{
//          case 0:
//            let lookup : LookupViewController = UIStoryboard.storyboard(storyboard: .Data).instantiateViewController()
//            navigationController?.pushViewController(lookup, animated: true)
//        default:
//            return
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
