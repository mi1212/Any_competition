//
//  MatchViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 25.09.2022.
//

import UIKit
import Lottie

protocol MatchViewControllerDelegate: AnyObject {
    func winning(_ match: Match)
}

class MatchViewController: UIViewController, UITextFieldDelegate {
    
    var match: Match?
    
    var timer: Timer?
    
    var delegate: MatchViewControllerDelegate?

    var animationView = AnimationView()
 
    var winnedPlayerLabel =  AnyCompUILabel(title: "Player win", fontSize: .large)
      
    private lazy var playerStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.alignment = .center
        stack.backgroundColor = .backgroundColor
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var firstPlayerLabel =  AnyCompUILabel(title: "firstPlayerLabel", fontSize: .medium)
    
    var secondPlayerLabel =  AnyCompUILabel(title: "secondPlayerLabel", fontSize: .medium)
    
    private lazy var scoreStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.isLayoutMarginsRelativeArrangement = true
        stack.distribution = .fillEqually
        stack.spacing = 124
        stack.backgroundColor = .backgroundColor
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let scorePlayer1TextField = AnyCompUITextField(placeholder: "", isSecure: false)
    
    let scorePlayer2TextField = AnyCompUITextField(placeholder: "", isSecure: false)
    
    let scorePlayer1Label = AnyCompUILabel(title: "", fontSize: .large)
    
    let scorePlayer2Label = AnyCompUILabel(title: "", fontSize: .large)
      
    let finishMatchButton = AnyCompUIButton(title: "Finish match")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setupViews()
    }
        
    init(match: Match) {
        super.init(nibName: nil, bundle: nil)
        self.match = match
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        switch match?.isDone {
        case true:
            setupViewControllerToCheck()
            if let score1 = match?.scorePlayer1, let score2 = match?.scorePlayer2 {
                
                scorePlayer1Label.text = "\(score1)"
                scorePlayer2Label.text = "\(score2)"
                
                if score1 > score2 {
                    scorePlayer1Label.backgroundColor = .anyGreenColor
                    scorePlayer2Label.backgroundColor = .anyPurpleColor
                } else {
                    scorePlayer2Label.backgroundColor = .anyGreenColor
                    scorePlayer1Label.backgroundColor = .anyPurpleColor
                }
            }
            
        case false:
            setupViewControllerToPlay()
        default:
            break
        }
        setupLabels()
    }
    
    private func setupViewControllerToPlay() {
        self.view.addSubview(playerStack)
        playerStack.addArrangedSubview(firstPlayerLabel)
        playerStack.addArrangedSubview(secondPlayerLabel)
        self.view.addSubview(scoreStack)
        scoreStack.addArrangedSubview(scorePlayer1TextField)
        scoreStack.addArrangedSubview(scorePlayer2TextField)
        self.view.addSubview(finishMatchButton)
        self.view.addGestureRecognizer(tap)
        
        let labelesArray = [firstPlayerLabel, firstPlayerLabel]
        labelesArray.map {
            $0.textAlignment = .center
        }
        
        
        let textFieldSArray = [scorePlayer1TextField, scorePlayer2TextField]
        textFieldSArray.map {
            $0.keyboardType = .numberPad
            $0.delegate = self
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
            $0.leftView = .none
            $0.rightView = .none
        }
        
        finishMatchButton.addTarget(self, action: #selector(finishMatch), for: .touchUpInside)
        
    let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            playerStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: inset),
            playerStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playerStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            playerStack.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            scoreStack.topAnchor.constraint(equalTo: playerStack.bottomAnchor, constant: inset),
            scoreStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scoreStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 4*inset),
            scoreStack.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        NSLayoutConstraint.activate([
            finishMatchButton.topAnchor.constraint(equalTo: scoreStack.bottomAnchor, constant: inset),
            finishMatchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            finishMatchButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            finishMatchButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    private func setupViewControllerToCheck() {
        self.view.addSubview(playerStack)
        playerStack.addArrangedSubview(firstPlayerLabel)
        playerStack.addArrangedSubview(secondPlayerLabel)
        self.view.addSubview(scoreStack)
        scoreStack.addArrangedSubview(scorePlayer1Label)
        scoreStack.addArrangedSubview(scorePlayer2Label)
//        self.view.addSubview(finishMatchButton)
        self.view.addGestureRecognizer(tap)
        
        let labelesArray = [firstPlayerLabel, firstPlayerLabel]
        labelesArray.map {
            $0.textAlignment = .center
        }
        
        
//        let textFieldSArray = [scorePlayer1TextField, scorePlayer2TextField]
//        textFieldSArray.map {
//            $0.keyboardType = .numberPad
//            $0.delegate = self
//            $0.textAlignment = .center
//            $0.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
//            $0.leftView = .none
//            $0.rightView = .none
//        }
        
//        finishMatchButton.addTarget(self, action: #selector(finishMatch), for: .touchUpInside)
        
    let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            playerStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: inset),
            playerStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playerStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            playerStack.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            scoreStack.topAnchor.constraint(equalTo: playerStack.bottomAnchor, constant: inset),
            scoreStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scoreStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 4*inset),
            scoreStack.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    private func setupLabels() {
        firstPlayerLabel.text = (match?.player1.firstName)! + " " + (match?.player1.lastName)!
        secondPlayerLabel.text = (match?.player2.firstName)! + " " + (match?.player2.lastName)!
    }
    
    private func winningAnimation(winnedPlayer: User) {
        
        let animation = Animation.named("73966-confetti")
        animationView = AnimationView(
            animation: animation,
            configuration: LottieConfiguration(renderingEngine: .automatic)
        )
        
        animationView.frame = view.bounds
        animationView.backgroundColor = .backgroundColor
        animationView.contentMode = .scaleAspectFill
        animationView.layer.opacity = 0.7
        animationView.loopMode = .loop
        animationView.play()
        self.view.addSubview(animationView)
        self.view.addSubview(winnedPlayerLabel)
        
        NSLayoutConstraint.activate([
            winnedPlayerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            winnedPlayerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        winnedPlayerLabel.text = winnedPlayer.firstName + " " + winnedPlayer.lastName + " выиграл"
        
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [self] _ in
            animationView.removeFromSuperview()
            winnedPlayerLabel.removeFromSuperview()
            animationView.stop()
            self.dismiss(animated: true)
        })
        
    }

    @objc func finishMatch() {
        view.endEditing(true)
        let scorePlayer1 = Int(scorePlayer1TextField.text!)!
        let scorePlayer2 = Int(scorePlayer2TextField.text!)!

        if scorePlayer1 > scorePlayer2 {
            winningAnimation(winnedPlayer: match!.player1)
        } else {
            winningAnimation(winnedPlayer: match!.player2)
        }
 
        match?.makeMatch(scorePlayer1, scorePlayer2)

        delegate?.winning(match!)
    }
    // проверка на количество элементов в текстовом поле "не больше 1 элемента"
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.count ?? 0
        
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        
        let newLength = currentCharacterCount + string.count - range.length
        
        let maxLength = 1
  
        return newLength <= maxLength
    }

    //MARK: dismissKeyboardTap
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        return tap
    }()
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
