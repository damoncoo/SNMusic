//
//  SNJobNewViewController.swift
//  SNMusic
//
//  Created by Darcy on 2021/7/15.
//

import YiCore
import RxSwift
import HandyJSON

class NoUse: HandyJSON {
    required init(){}
}

class SNJobNewViewController: SNRouteViewController {
    
    @IBOutlet weak var titleTextField: SNTextField!
    
    @IBOutlet weak var nameTextField: SNTextField!
    
    @IBOutlet weak var urlTextField: SNTextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    let presenter = SNMusicNewJobPresenter<NoUse>()
    
    let disposeBag = DisposeBag()
    
    deinit {
        print("apply deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func setup() {
        
        self.title = "新建任务"
        
        self.view.backgroundColor = .pageBgColor
        let scroll = self.view as! UIScrollView
    
        scroll.contentSize = CGSize.init(width: UIScreenWidth, height: UIScreenHeight + 0.5)
        
        self.titleTextField.textField.placeholder = "创作者名字"

        self.nameTextField.textField.placeholder = "作品名字"

        self.urlTextField.textField.placeholder = "地址ß"

        let ges = UITapGestureRecognizer()
        ges.numberOfTapsRequired = 1
        ges.rx.event.subscribe { [weak self](gesture) in
            self?.view.endEditing(true)
        }.disposed(by: disposeBag)
        self.view.addGestureRecognizer(ges)
        
        self.submitButton.backgroundColor = .themeColor2
        self.submitButton.layer.cornerRadius = 8
        self.submitButton.layer.masksToBounds = true
        self.submitButton.rx.tap.subscribe { (event) in
            self.didHitSubmit()
        }.disposed(by: disposeBag)
        
        let valid = self.observeTextValid()
        valid.map{ enabled in
            return enabled
        }.bind(to: self.submitButton.rx.isEnabled).disposed(by: disposeBag)
        
    }
    
    func observeTextValid() -> Observable<Bool> {
        
//        // 用户名是否有效
//        let singerValid = self.titleTextField.textField.rx.text.orEmpty
//            .map { $0.count >= 2 }
//            .share(replay: 1)
        
        // 用户名是否有效
        let urlValiad = self.urlTextField.textField.rx.text.orEmpty
            .map { $0.matches(pattern: "^https://([a-z]+\\.)?youtube.com") }
            .share(replay: 1)
        
//        // 所有输入是否有效
//        let everythingValid = Observable.combineLatest(
//            singerValid,
//            urlValiad
//        ) {
//            $0 && $1
//        }
//        .share(replay: 1)
        
        return urlValiad
    }
    
    func didHitSubmit() {
        
        let title = self.titleTextField.textField.text ?? ""
        let name = self.nameTextField.textField.text ?? ""
        var url = self.urlTextField.textField.text ?? ""

        let pattern = "([a-z]+\\.)(?=youtube.com)"
        url = url.replacingOccurrences(of: pattern, with: "www.", options: .regularExpression, range: nil)
        
        self.presenter.searchMusic(title: title, name: name, url: url)
            .done { success in
                UIUtils.showToast(message: "提交成功", duration: 2, level: .info)
                self.popBack()
                
        }.catch { err in
            if case SNError.commonError(let str) = err {
                UIUtils.showToast(message: str, duration: 2, level: .info)
            } else {
                UIUtils.showToast(message: "提交失败")
            }
        }
    }
    
    func popBack() {
        self.navigationController?.popViewController()
    }
    
    
}
