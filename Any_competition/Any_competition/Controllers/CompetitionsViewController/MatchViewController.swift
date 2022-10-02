//
//  MatchViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 25.09.2022.
//

import UIKit
import KRTournamentView

protocol MatchViewControllerDelegate: AnyObject {
    func firstPlayerWin(matchPath: MatchPath)
    
    func secondPlayerWin(matchPath: MatchPath)
}

class MatchViewController: UIViewController {
    
    weak var delegate: MatchViewControllerDelegate?

    var matchPath: MatchPath?
 
    var firstPlayerLabel =  AnyCompUILabel(title: "firstPlayerLabel", fontSize: .small)
    
    var secondPlayerLabel =  AnyCompUILabel(title: "secondPlayerLabel", fontSize: .small)
    
    var firstPlayerWinButton = AnyCompUIButton(title: "WinFirst")
    
    var secondlayerWinButton = AnyCompUIButton(title: "WinSecond")
    
    private lazy var playerStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.alignment = .center
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var buttonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.isLayoutMarginsRelativeArrangement = true
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setupViewController()
    }
    
    init(matchPath: MatchPath) {
        super.init(nibName: nil, bundle: nil)
        self.matchPath = matchPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViewController() {
        self.view.addSubview(playerStack)
        playerStack.addArrangedSubview(firstPlayerLabel)
        playerStack.addArrangedSubview(secondPlayerLabel)
        self.view.addSubview(buttonsStack)
        buttonsStack.addArrangedSubview(firstPlayerWinButton)
        buttonsStack.addArrangedSubview(secondlayerWinButton)
        
        firstPlayerWinButton.addTarget(self, action: #selector(tapFirstPlayerWin), for: .touchUpInside)
        secondlayerWinButton.addTarget(self, action: #selector(tapSecondPlayerWin), for: .touchUpInside)
        
    let inset: CGFloat = 60
        
        NSLayoutConstraint.activate([
            playerStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: inset),
            playerStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playerStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            playerStack.heightAnchor.constraint(equalToConstant: inset)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStack.topAnchor.constraint(equalTo: playerStack.bottomAnchor, constant: inset),
            buttonsStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            buttonsStack.heightAnchor.constraint(equalToConstant: inset)
        ])
    }
    
    private func setupLabels() {
//        print(firstPlayerLabel.text)
//        print(secondPlayerLabel.text)
    }
    
    @objc func tapFirstPlayerWin() {
        delegate?.firstPlayerWin(matchPath: matchPath!)
        self.dismiss(animated: true)
    }
    
    @objc func tapSecondPlayerWin() {
        delegate?.secondPlayerWin(matchPath: matchPath!)
        self.dismiss(animated: true)
    }

}
