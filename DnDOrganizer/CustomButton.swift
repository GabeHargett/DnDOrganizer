//
//  CustomButton.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 3/26/22.
//

import UIKit


struct MyCustomButtonViewModel {
    let title: String
    let subTitle: String
    let imageName: String
}

class CustomButton: UIButton {
    
    private let stack = UIStackView()
    
    private let myTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        return label
        
    }()
    
    private let mySubTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        return label
        
    }()
    
    private let myIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
        
    }()
    
    private var viewModel: MyCustomButtonViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: MyCustomButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
                
//        addSubviews()
        setupStackView()
        configure(with: viewModel)
        
    }
    
//    private func addSubviews() {
//        guard !myTitleLabel.isDescendant(of: self) else {
//            return
//        }
//        addSubview(myTitleLabel)
//        addSubview(mySubTitleLabel)
//        addSubview(myIconView)
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: MyCustomButtonViewModel) {
        
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        layer.borderWidth = 1.5

//        addSubviews()
        setupStackView()
        
        myTitleLabel.text = viewModel.title
        mySubTitleLabel.text = viewModel.subTitle
        myIconView.image = UIImage(systemName: viewModel.imageName)
        

    }



private func setupStackView() {
    
    
    addAutoLayoutSubview(stack)
    
    let verticalStack = UIStackView()
    verticalStack.axis = .vertical
    verticalStack.alignment = .trailing
    verticalStack.addArrangedSubviews([mySubTitleLabel, myTitleLabel])
    
    stack.centerInSuperview()
    stack.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    stack.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    stack.alignment = .trailing
    
    myIconView.height(constant: 32)
    myIconView.width(constant: 32)

    
    stack.axis = .horizontal
    stack.spacing = 8
    stack.layoutMargins = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 16)
    stack.isLayoutMarginsRelativeArrangement = true

    
    stack.addArrangedSubviews([
        verticalStack,
        myIconView
    ])
 }
//    MyCustomButtonViewModel.height(constant: 40)
    
    
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
        
        
        
//        myIconView.frame = CGRect(
//            x: 7,
//            y: 5,
//            width: 50,
//            height: frame.height-5
//        ).integral
//
//
//        mySubTitleLabel.frame = CGRect(
//            x: 60,
//            y: 5,
//            width: frame.width-65,
//            height: (frame.height-10)/2
//        ).integral
//
//
//        myTitleLabel.frame = CGRect(
//            x: 60,
//            y: (frame.height+10)/2,
//            width: frame.width-65,
//            height: (frame.height-15)/2
//        ).integral
//}
    
}

class TemporaryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
    }
}
