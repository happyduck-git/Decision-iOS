//
//  ViewController.swift
//  Decision
//
//  Created by HappyDuck on 2022/02/28.
//

import UIKit
import Lottie

class HighlightedButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1) : UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 0.7)
        }
    }
}

class ViewController: UIViewController {
    
    var choices = [String]()
    var animationView: AnimationView?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to decide?"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.textColor = .darkGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let testStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let testView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 65, y: 50, width: 300, height: 300)
        view.layer.cornerRadius = 300/2
//        view.layer.borderWidth = 5
//        view.layer.borderColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1).cgColor
        
        return view
    }()
    

    
    private let candidatesTextField1: UITextField = {
        let textField = UITextField()
        textField.placeholder = "1st option here"
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1).cgColor
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let candidatesTextField2: UITextField = {
        let textField = UITextField()
        textField.placeholder = "2nd Option here"
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1).cgColor
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let spinningBtn: HighlightedButton = {
        let button = HighlightedButton()
        button.setTitle("My fate", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 0.7)
        button.addTarget(self, action: #selector(selectChoice), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 98).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40)
        label.widthAnchor.constraint(equalToConstant: 400).isActive = true
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let restartBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Redo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1)
        
        button.addTarget(self, action: #selector(restart), for: .touchUpInside)
        
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1.0)
        
        view.addSubview(testView)
        view.addSubview(titleLabel)
        view.addSubview(candidatesTextField1)
        view.addSubview(candidatesTextField2)
        
        view.addSubview(spinningBtn)
        view.addSubview(answerLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

      
        layout()
        animate()
    }
    
    private func layout() {
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        candidatesTextField1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        candidatesTextField1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        candidatesTextField2.topAnchor.constraint(equalTo: candidatesTextField1.bottomAnchor, constant: 20).isActive = true
        candidatesTextField2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        spinningBtn.topAnchor.constraint(equalTo: candidatesTextField2.bottomAnchor, constant: 30).isActive = true
        spinningBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        answerLabel.topAnchor.constraint(equalTo: spinningBtn.bottomAnchor, constant: 100).isActive = true
        answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        testStackView.addArrangedSubview(testView)
//        testView.center = testStackView.center

    }
    
    @objc func selectChoice() {
        
        spinningBtn.isEnabled = false
        if let firstChoice = candidatesTextField1.text {
            choices.append(firstChoice)
        } else {
            
        }
        if let secondChoice = candidatesTextField2.text {
            choices.append(secondChoice)
        }
        print(choices)
        
        let randomElement = choices.randomElement()
        answerLabel.text = "\(randomElement ?? "에러")!"
        
        //다시하기 버튼
        view.addSubview(restartBtn)

//        restartBtn.setTitleColor(.black, for: .normal)
//        restartBtn.layer.borderColor = UIColor.black.cgColor
        restartBtn.addTarget(self, action: #selector(restart), for: .touchUpInside)
        restartBtn.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 100).isActive = true
        restartBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //view 배경 alpha 값 변경
        view.backgroundColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 0.5)
        testView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        testView.layer.borderColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 0.5).cgColor
        candidatesTextField1.layer.borderColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 0.5).cgColor
        candidatesTextField2.layer.borderColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 0.5).cgColor
        candidatesTextField1.textColor = .darkGray
        
        
        //폭죽 애니메이션
        
        animationView = .init(name: "16764-firework-animaiton")
        view.addSubview(animationView!)
        animationView?.frame = view.bounds
        animationView?.play(completion: { (finished) in
            self.animationView?.isHidden = true
        })
        animationView?.loopMode = .repeat(2.0)
        
        //
        view.endEditing(true)
    }
    
    @objc func nothing() {
        print("Pressed")
    }
    
    @objc func restart() {
//        candidatesTextField1.text = ""
//        candidatesTextField2.text = ""
        choices.removeAll()
        answerLabel.text = ""
        spinningBtn.isEnabled = true
        restartBtn.removeFromSuperview()
        view.backgroundColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1.0)
        testView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        testView.layer.borderColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1.0).cgColor
        candidatesTextField1.layer.borderColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1.0).cgColor
        candidatesTextField2.layer.borderColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1.0).cgColor
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func animate() {
        UIView.animate(withDuration: 1) {
            self.testView.frame = CGRect(x: 65, y: 50, width: 300, height: 300)
            self.testView.layer.cornerRadius = 300/2
            
//            self.testView.center = self.view.center

        } completion: { done in
            if done {
                self.shrink()
            }
        }
    }

    func shrink() {
        UIView.animate(withDuration: 1) {
            self.testView.frame = CGRect(x: 80, y: 70, width: 270, height: 270)
            self.testView.layer.cornerRadius = 270/2

//            self.testView.center = self.view.center

        } completion: { done in
            if done {
                self.animate()
            }
        }
    }



}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

