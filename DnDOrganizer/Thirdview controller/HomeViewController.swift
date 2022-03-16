//
//  ViewController.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 2/2/22.
//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

import UIKit
struct FullName{
    var firstName: String
    var lastName: String
    
    func initials() -> String {
        var initials = ""
        initials.append(firstName.first!)
        initials.append(lastName.first!)
        return initials
    }
    
    func firstAndLastInitial() -> String {
        var string = ""
        string.append(firstName)
        string.append(" ")
        string.append(lastName.first!)
        return string
    }
}


class HomeViewController: UIViewController {
    
    func structPlayground() {
        let tannersName: FullName = FullName(firstName: "Tanner", lastName: "Rozier")
        print(tannersName.firstAndLastInitial())
    }
    
    let imageView = UIImageView()
    let completionLabel = UILabel()
    
    private let gameButton = UIButton()
    private var pressesLeft = 5
    private var gameButtonCenterXAnchor = NSLayoutConstraint()
    private var gameButtonCenterYAnchor = NSLayoutConstraint()
    private let timerLabel = UILabel()
    private let winLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        structPlayground()
        configureBackground()
        setupGame()
//        var integer: Int?
//        var cgFloat: CGFloat?
//        var double: Double?
//
//        integer = 4
//
//        guard let integer = integer else {
//            return
//        }
        GabePractice.start()
    }
    
    private func setupGame() {
        gameButton.setTitle("Press me \(pressesLeft) more times", for: .normal)
        gameButton.setTitleColor(.black, for: .normal)
        gameButton.backgroundColor = .white
        gameButton.cornerRadius(radius: 8)
        gameButton.width(constant: 200)
        gameButton.height(constant: 30)
        gameButton.addTarget(self, action: #selector(didTapGameButton), for: .touchUpInside)
        
        winLabel.quickConfigure(textAlignment: .center, font: .boldSystemFont(ofSize: 20), textColor: .white)
        view.addAutoLayoutSubview(winLabel)
        winLabel.centerInSuperview()
        winLabel.isHidden = true
        
        timerLabel.quickConfigure(textAlignment: .center, font: .boldSystemFont(ofSize: 20), textColor: .white)
        timerLabel.text = "5.0"
        
        let timerHolder = UIView()
        timerHolder.backgroundColor = .black
        timerHolder.cornerRadius(radius: 8)
        timerHolder.height(constant: 50)
        timerHolder.width(constant: 100)
        
        timerHolder.addAutoLayoutSubview(timerLabel)
        timerLabel.centerInSuperview()
        
        view.addAutoLayoutSubview(timerHolder)
        
        view.addAutoLayoutSubview(gameButton)
        
        gameButtonCenterXAnchor = gameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        gameButtonCenterYAnchor = gameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            timerHolder.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            timerHolder.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            gameButtonCenterXAnchor,
            gameButtonCenterYAnchor,
        ])
        
        var totalTime: Int = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            totalTime += 1
            let timeLeft = 50-totalTime
            let firstDigits = timeLeft / 10
            let lastDigits = timeLeft % 10
            self.timerLabel.text = "\(firstDigits).\(lastDigits)"

            if totalTime == 50 {
                timer.invalidate()
                self.evaluateResult()
            }
        }
    }
    
    @objc private func didTapGameButton() {
        pressesLeft -= 1
        if pressesLeft == 0 {
            gameButton.isHidden = true
            return
        }
        gameButton.setTitle("Press me \(pressesLeft) more times", for: .normal)
        
        let randomXUpperRange = UIScreen.main.bounds.width / 2 - 100
        let randomXLowerRange = -randomXUpperRange
        
        let randomYUpperRange = UIScreen.main.bounds.height / 2 - 60
        let randomYLowerRange = -randomYUpperRange + 30
        
        gameButtonCenterXAnchor.constant = CGFloat.random(in: randomXLowerRange...randomXUpperRange)
        gameButtonCenterYAnchor.constant = CGFloat.random(in: randomYLowerRange...randomYUpperRange)
    }
    
    private func evaluateResult() {
        gameButton.isHidden = true
        winLabel.isHidden = false
        if pressesLeft == 0 {
            winLabel.text = "You win!"
        } else {
            winLabel.text = "You lose you pathetic moron"
        }
        UIView.animate(withDuration: 2, animations: {
            self.winLabel.transform = CGAffineTransform(scaleX: 3, y: 3)
        }) {result in
            self.winLabel.isHidden = true
        }
    }
    
    
    func addImage() {
        let imageName = "cool"
        let image = UIImage(named: imageName)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        
        view.addAutoLayoutSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])

    }
    
    func configureBackground() {
        view.backgroundColor = .blue
        
        addImage()
        
        print("c")
        
        completionLabel.text = "Task are not completed for Week 1"
        completionLabel.textColor = .black
        completionLabel.textAlignment = .center
        completionLabel.font = UIFont.systemFont(ofSize: 20.0)
        completionLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        completionLabel.font = UIFont.italicSystemFont(ofSize: 20.0)
        
        view.addAutoLayoutSubview(completionLabel)
        
        NSLayoutConstraint.activate([
            completionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completionLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant:  -16),
            //completionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16),
            //completionLabel.heightAnchor.constraint(equalTo: completionLabel.widthAnchor),
        ])

        let whiteBox = UIButton()
        whiteBox.setTitle("Cool", for: .normal)
        whiteBox.setTitleColor(.red, for: .normal)
        whiteBox.setTitleColor(UIColor.red.withAlphaComponent(0.3), for: .highlighted)
        whiteBox.backgroundColor = .white
        
        whiteBox.layer.cornerRadius = 5
        
        view.addAutoLayoutSubview(whiteBox)

        NSLayoutConstraint.activate([
            whiteBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whiteBox.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            whiteBox.widthAnchor.constraint(equalToConstant: 50),
            whiteBox.heightAnchor.constraint(equalToConstant: 50),
            ])
        
        whiteBox.addTarget(self, action: #selector(didTapWhiteBox), for: .touchUpInside)
        
//        whiteBox.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapWhiteBox))
//        whiteBox.addGestureRecognizer(tapGesture)
        
        let redBox = UILabel()
        redBox.text = "D&D"
        redBox.textColor = .white
        redBox.textAlignment = .center
        redBox.backgroundColor = .red
        redBox.layer.masksToBounds = true
        redBox.layer.cornerRadius = 5

        view.addAutoLayoutSubview(redBox)
        
        let blackBox = UILabel()
        blackBox.text = "Todo"
        blackBox.textColor = .white
        blackBox.textAlignment = .center
        blackBox.backgroundColor = .black
        blackBox.layer.masksToBounds = true
        blackBox.layer.cornerRadius = 5

        view.addAutoLayoutSubview(blackBox)

        NSLayoutConstraint.activate([
            redBox.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            redBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            redBox.widthAnchor.constraint(equalToConstant: 50),
            redBox.heightAnchor.constraint(equalToConstant: 50),
            ])
        
        NSLayoutConstraint.activate([
            blackBox.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            blackBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            blackBox.widthAnchor.constraint(equalToConstant: 50),
            blackBox.heightAnchor.constraint(equalToConstant: 50),
            ])
        
        redBox.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(didTapRedBox))
        redBox.addGestureRecognizer(tapGesture2)
        
        blackBox.isUserInteractionEnabled = true
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(didTapBlackBox))
        blackBox.addGestureRecognizer(tapGesture3)

    }
    
    @objc private func didTapWhiteBox() {
        imageView.isHidden.toggle()
        

    }
    
    @objc private func didTapRedBox() {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapBlackBox() {
        let vc = WeeksClassVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//extension HomeViewController: firstvcDelegate {
//
////    func hideText(isCompleted: Bool) {
////        completionLabel.isHidden = isCompleted
//    }
//}



class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let tableview = UITableView()
    
    var groupNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Second"
        
        let barButtonItem = UIBarButtonItem(title: "Create Group", style: .done, target: self, action: #selector(createNewGroup))
        navigationItem.rightBarButtonItem = barButtonItem
        
        tableview.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
        configureTableView()
        configureBackground()
        
        groupNames.append("coolio")
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    @objc private func createNewGroup() {
        let vc = CreateGroupVC()
        navigationController?.pushViewController(vc, animated: true)

//        groupNames.append("Provo")
//        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        cell.textLabel?.text = groupNames[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell tapped")
    }

    
    func configureTableView() {
        view.addAutoLayoutSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableview.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }
    
    func configureBackground() {
        view.backgroundColor = .green
        
//        let whiteBox = UIView()
//        whiteBox.backgroundColor = .blue
//
//        view.addSubview(whiteBox)
//        whiteBox.layer.cornerRadius = 25
//      whiteBox.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
    }


    
    
}



extension UIView {
    
    func addShadow(shadowColor: UIColor, shadowOpacity: Float, shadowRadius: CGFloat, shadowOffset: CGSize) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
    }
    
    func addBorders(color: UIColor, thickness: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = thickness
    }
    
    func cornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func centerInSuperview() {
        guard let superview = self.superview else { return }
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ])
    }
    
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
    
    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }
    
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
    
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
            NSLayoutConstraint(item: self,
                               attribute: attribute,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }
    
    public func fillSuperview() {
        guard let superview = self.superview else { return }
        activate(
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        )
    }
    
    @discardableResult
    public func fillSuperviewLayoutMargins() -> (left: NSLayoutConstraint, right: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
        guard let superview = self.superview else {
            fatalError("\(self) has not been added as a subview")
        }
        let left = leftAnchor.constraint(equalTo: superview.leftMargin)
        let right = rightAnchor.constraint(equalTo: superview.rightMargin)
        let top = topAnchor.constraint(equalTo: superview.topMargin)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomMargin)
        activate(left, right, top, bottom)
        return (left, right, top, bottom)
    }
    
    @discardableResult
    public func fillSuperviewMargins() -> (left: NSLayoutConstraint, right: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
        guard let superview = self.superview else {
            fatalError("\(self) has not been added as a subview")
        }
        let left = leftAnchor.constraint(equalTo: superview.leftAnchor, constant: superview.layoutMargins.left)
        let right = rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -superview.layoutMargins.right)
        let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: superview.layoutMargins.top)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -superview.layoutMargins.bottom)
        activate(left, right, top, bottom)
        return (left, right, top, bottom)
    }
    
    public func activate(_ constraints: NSLayoutConstraint...) {
        NSLayoutConstraint.activate(constraints)
    }
    
    func addAutoLayoutSubview(_ subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private var leftMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.leftAnchor
    }
    
    private var leadingMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.leadingAnchor
    }
    
    private var rightMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.rightAnchor
    }
    
    private var trailingMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.trailingAnchor
    }
    
    private var centerXMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.centerXAnchor
    }
    
    private var widthMargin: NSLayoutDimension {
        return layoutMarginsGuide.widthAnchor
    }
    
    private var topMargin: NSLayoutYAxisAnchor {
        return layoutMarginsGuide.topAnchor
    }
    
    private var bottomMargin: NSLayoutYAxisAnchor {
        return layoutMarginsGuide.bottomAnchor
    }
    
    private var centerYMargin: NSLayoutYAxisAnchor {
        return layoutMarginsGuide.centerYAnchor
    }
    
    private var heightMargin: NSLayoutDimension {
        return layoutMarginsGuide.heightAnchor
    }
    
    func makeToast(view: UIView, duration: Double) {
        self.addSubview(view)
        UIView.animate(withDuration: 0.6, delay: duration, options: .curveEaseOut, animations: {
             view.alpha = 0.0
        }, completion: {(isCompleted) in
            view.removeFromSuperview()
        })
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach(addArrangedSubview)
    }
}

extension UILabel {
    func quickConfigure(textAlignment: NSTextAlignment, font: UIFont, textColor: UIColor, numberOfLines: Int = 1) {
        self.textAlignment = textAlignment
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
}
