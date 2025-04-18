//
//  IdealAgeView.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class IdealAgeView: UIView {
    
    public lazy var navigationBar = NavigationBarView()
    public lazy var progressBar = ProgressBar()
    private lazy var mainTitle = UILabel().then {
        $0.font = Fonts.H1
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private lazy var subTitle = UILabel().then {
        $0.font = Fonts.B1
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private lazy var buttonStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    public lazy var youngerButton = AgeButton()
    public lazy var sameButton = AgeButton()
    public lazy var olderButton = AgeButton()
    
    public lazy var nextButton = ConfirmButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setBasicConstraints()
    }
    
    public func configure(mainText: String, subText: String, progress: Float) {
        mainTitle.text = mainText
        subTitle.text = subText
        progressBar.progress = progress
    }
    
    private func setBasicConstraints() {
        self.addSubview(navigationBar)
        self.addSubview(progressBar)
        self.addSubview(mainTitle)
        self.addSubview(subTitle)
        self.addSubview(nextButton)
        
        navigationBar.hideRightButton()
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        nextButton.configure(labelText: "다음")
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
        self.addSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.height.equalTo(340)
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalTo(nextButton.snp.top).offset(-60)
        }
        
        buttonStack.addArrangedSubview(youngerButton)
        buttonStack.addArrangedSubview(sameButton)
        buttonStack.addArrangedSubview(olderButton)
        
        let buttons = [youngerButton, sameButton, olderButton]
        let age: [Age] = [.younger, .same, .older]
        
        for (index, button) in buttons.enumerated() {
            button.configure(age[index])
            button.snp.makeConstraints { make in
                make.height.equalTo(100)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

