//
//  SNTextField.swift
//  Yi
//
//  Created by Darcy on 2021/2/15.
//

import UIKit
import SnapKit
import YiCore

class SNTextField: UIView {

    public var textField : UITextField!
    
    public var line : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        self.setup()        
    }
    
    func setup() {
        
        self.backgroundColor = UIColor.clear
        
        self.textField = UITextField()
        self.textField.textAlignment = .left
        self.textField.placeholder = "请输入内容"
        self.addSubview(self.textField)
           
        self.line = UIView()
        self.line.backgroundColor = UIColor.sepColor
        self.addSubview(self.line)
        
        self.line.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        self.textField.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.line.snp.top).offset(-10)
        }
    }
    
}








