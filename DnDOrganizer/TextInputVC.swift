//
//  TextInputVC.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 3/23/22.
//

import UIKit

protocol TextInputVCDelegate: AnyObject {
    func didSubmitText(text: String)
}

class TextInputVC: UIViewController {
    
    private let baseView = BareBonesBottomModalView(frame: .zero, allowsTapToDismiss: true, allowsSwipeToDismiss: true)
    
    override func loadView() {
        view = baseView
        baseView.delegate = self
    }
    
    private let textField = UnderlinedTextField()
    private let submitButton = UIButton()
    
    weak var delegate: TextInputVCDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardWillShow(notification: NSNotification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.5
        let height = (keyboardFrame?.height) ?? 400
        UIView.animate(withDuration: keyboardDuration, animations: {
            self.baseView.modalViewBottomAnchor.constant = -height
            self.baseView.layoutIfNeeded()
        })
    }
    
    @objc private func handleKeyboardWillHide(notification: NSNotification) {
        let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.5
        UIView.animate(withDuration: keyboardDuration, animations: {
            self.baseView.modalViewBottomAnchor.constant = 0
        })
    }
    
    private func setupSubviews() {
        baseView.stack.addArrangedSubview(textField)
        
        textField.height(constant: 50)
        textField.placeholder = "Enter task"
        
        baseView.stack.addArrangedSubview(submitButton)
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.height(constant: 50)
        submitButton.setTitleColor(.black, for: .normal)
        
        submitButton.addTarget(self, action: #selector(didSubmit), for: .touchUpInside)
    }
    
    @objc private func didSubmit() {
        if let text = textField.text {
            delegate?.didSubmitText(text: text)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showModal(vc: UIViewController) {
        vc.present(self, animated: true, completion: nil)
        self.baseView.updateModalConstraints()
    }

}

extension TextInputVC: BareBonesBottomModalViewDelegate {
    func didDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

class UnderlinedTextField: UITextField {
    override func didMoveToSuperview() {
        font = UIFont.systemFont(ofSize: 20, weight: .medium)
        tintColor = .black
        
        let underlineView = UIView()
        underlineView.backgroundColor = .black
        
        addAutoLayoutSubview(underlineView)
        underlineView.height(constant: 2)
        NSLayoutConstraint.activate([
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            underlineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            underlineView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
}
class GButton: UIButton {
    override func didMoveToSuperview() {
        let GButton = UIButton()
        GButton.setTitleColor(.black, for: .normal)
        GButton.setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .highlighted)
        GButton.backgroundColor = .systemBlue
        GButton.cornerRadius(radius: 8)
        addAutoLayoutSubview(GButton)

    }
}
