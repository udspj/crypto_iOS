//
//  AddAccountViewController.swift
//  cryptoios
//
//  Created by sunpeijia on 2018/11/21.
//  Copyright © 2018年 udspj. All rights reserved.
//

import Foundation
import UIKit

class AddAccountViewController: UIViewController {
    
    @IBOutlet var memoText: UITextView!
    @IBOutlet var pwText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "添加账号";
    }
    
    @IBAction func submit(_ sender: Any) {
        
    }
}
