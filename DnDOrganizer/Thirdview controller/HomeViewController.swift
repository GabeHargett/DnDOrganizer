//
//  ViewController.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 2/2/22.
//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

import UIKit

class HomeViewController: UIViewController {
    
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        configureBackground()
        print("cool")
        
        var integer: Int?
        var cgFloat: CGFloat?
        var double: Double?
        
        integer = 4
        
        guard let integer = integer else {
            return
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
        let week1Data = WeekData(weekNumber: 1, tasks: [])
        let vc = firstvc(weekData: week1Data)
        navigationController?.pushViewController(vc, animated: true)
    }
}



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
