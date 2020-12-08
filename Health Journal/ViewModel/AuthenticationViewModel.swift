//
//  AuthenticationViewModel.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 12/7/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
       
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
}
