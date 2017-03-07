//
//  ViewController.swift
//  ios-touch-id-demo
//
//  Created by Eiji Kushida on 2017/03/07.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit
import LocalAuthentication

final class ViewController: UIViewController {

    private var auth = TouchIDUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        auth.authable = self
        auth.setupAuth()
    }
}

//MARK:-TouchIDAuthable
extension ViewController: TouchIDAuthable {
    
    func complated(status: TouchIDStatusType) {
        
        switch status {
        case .success:
            print("認証完了")
        case .failure(let message):
            print(message)
        }
    }
}

