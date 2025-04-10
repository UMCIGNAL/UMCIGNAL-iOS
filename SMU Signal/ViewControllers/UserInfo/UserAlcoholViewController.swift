//
//  UserAlcoholViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserAlcoholViewController: UIViewController {
    
    private let userAlcoholView = UserAlcoholView()
    
    override func viewDidLoad() {
        self.view = userAlcoholView
        self.setButtonActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userAlcoholView.setButtonConstraints()
    }
    
    private func setButtonActions() {
        userAlcoholView.aGlassButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        userAlcoholView.aBottleButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        userAlcoholView.bottlesButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        userAlcoholView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userAlcoholView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func selectAlcohol(_ sender: AlcoholCapabilityButton) {
        let buttons = [userAlcoholView.aGlassButton, userAlcoholView.aBottleButton, userAlcoholView.bottlesButton]
        
        for button in buttons {
            if sender == button {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        userAlcoholView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let buttons = [userAlcoholView.aGlassButton, userAlcoholView.aBottleButton, userAlcoholView.bottlesButton]
        for button in buttons {
            if button.isChecked {
                UserInfoSingletone.typeIsDrinking(button.alcohol!.toResponse())
            }
        }
        
        let nextVC = UserMBTIViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
}

import SwiftUI
#Preview {
    UserAlcoholViewController()
}
