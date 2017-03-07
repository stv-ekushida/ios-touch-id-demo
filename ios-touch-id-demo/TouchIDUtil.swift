//
//  TouchIDUtil.swift
//  ios-touch-id-demo
//
//  Created by Eiji Kushida on 2017/03/07.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation
import LocalAuthentication

enum TouchIDStatusType {
    case success
    case failure(message: String)
}

protocol TouchIDAuthable {
    func complated(status: TouchIDStatusType)
}

final class TouchIDUtil {
    
    var authable: TouchIDAuthable!
    
    func setupAuth() {
        
        let context = LAContext()
        var error : NSError?
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "サンプル確認のための認証チェック",
                                   reply: { [weak self] success, error in

                                    if (success) {
                                        self?.authable.complated(status: .success)
                                    } else {
                                        self?.authable.complated(status: .failure(message: error.debugDescription))
                                    }
            })
        } else {
            self.authable.complated(status: .failure(message: "TouchID非対応"))
        }
    }
}
