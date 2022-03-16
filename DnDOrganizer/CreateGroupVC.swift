//
//  CreateGroupVC.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 2/2/22.
//

import UIKit
import SwiftUI

class CreateGroupVC: UIViewController {
    
    let stackView = UIStackView()
    let button = UIButton()
    let label = UILabel()
    let label2 = UILabel()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let button5 = UIButton()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setupStackView()
    }
    
    private func setupStackView() {
        view.addAutoLayoutSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 12
        
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        button.backgroundColor = .blue
        button.cornerRadius(radius: 8)
        
        button3.backgroundColor = .blue
        button3.cornerRadius(radius: 8)
        
        button4.backgroundColor = .blue
        button4.cornerRadius(radius: 8)
        
        button5.backgroundColor = .blue
        button5.cornerRadius(radius: 8)
        
        print("cool")
        
        button2.backgroundColor = .blue
        button2.cornerRadius(radius: 8)
        
        label.text = "Campaign Image"
        label2.text = "Campaign Name"
        label3.text = "Campaign Approximate length"
        label4.text = "Campaign Type"
        label5.text = "Campaign Theme"

        button.setTitle("Add Image Here", for: .normal)
        button2.setTitle("Add Campaign Name Here", for: .normal)
        button3.setTitle("Add Campaign Approximate length Here", for: .normal)
        button4.setTitle("Add Campaign Type", for: .normal)
        button5.setTitle("Add Campaign Theme", for: .normal)

        stackView.addArrangedSubviews([
            label,
            button,
            label2,
            button2,
            label3,
            button3,
            label4,
            button4,
            label5,
            button5
        ])
        button.height(constant: 40)
        

        
    }
}
struct WeekData {

    var weekNumber: Int

    var tasks: [WeekTask]
    
    func allTasksComplete() -> Bool {
        var allComplete = true
        for task in tasks {
            if !task.isComplete {
                allComplete = false
            }
        }
        return allComplete
    }

}



struct WeekTask {

    var title: String

    var isComplete: Bool

}

protocol firstvcDelegate: AnyObject {
//    func hideText(isCompleted: Bool)
    func didUpdateData(weekData: WeekData)
}


class firstvc: UIViewController {

    
    private var weekData: WeekData

    

    init(weekData: WeekData) {

        self.weekData = weekData
        
        super.init(nibName: nil, bundle: nil)

    }

  
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)

        return tableView
        

    }()

    private var items = [String]()
    let myTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 50.00))
        
    weak var delegate: firstvcDelegate?
    var isCompleted: Bool?
  
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.myTextField.delegate = self
                
        view.backgroundColor = .systemBlue
        tableView.dataSource = self
        view.addAutoLayoutSubview(tableView)
        tableView.fillSuperview()
        title = "Week \(weekData.weekNumber)"
        
        myTextField.center = self.view.center
        myTextField.placeholder = "Place holder text"
        //myTextField.text = "UITextField example"
        myTextField.borderStyle = UITextField.BorderStyle.line
        myTextField.backgroundColor = .white
        myTextField.textColor = UIColor.blue
        myTextField.isHidden = true
        self.view.addSubview(myTextField)
        
        let barButtonItem = UIBarButtonItem(title: "Next Week", style: .done, target: self, action: #selector(didTapToolBarButton))

        if weekData.weekNumber < 7 {
            navigationItem.rightBarButtonItem = barButtonItem
        }
        else if weekData.weekNumber == 7 {
            
        }
        
        weekData.tasks.removeAll()

        if let taskTitles = UserDefaults.standard.array(forKey: "Week\(weekData.weekNumber)Titles") as? [String],

           let taskCompletes = UserDefaults.standard.array(forKey: "Week\(weekData.weekNumber)Completes") as? [Bool] {

            for index in 0..<taskTitles.count {

                weekData.tasks.append(WeekTask(title: taskTitles[index], isComplete: taskCompletes[index]))

            }

        }

        tableView.reloadData()

            
        
        let add = UIBarButtonItem(title: "Add To-Do task", style: .done, target: self, action: #selector(addItem))
        toolbarItems = [add]
        navigationController?.setToolbarHidden(false, animated: false)
        
    }
    
   
    @objc private func didTapToolBarButton() {
        let vc = firstvc(weekData: WeekData(weekNumber: weekData.weekNumber + 1, tasks: []))
        navigationController?.pushViewController(vc, animated: true)
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //tableView.frame = view.bounds
    }
    
    @objc private func addItem() {
        myTextField.isHidden = false
                
    }
}

extension firstvc: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        myTextField.isHidden = true
        if let text = myTextField.text, myTextField.text != "" {
            
            weekData.tasks.append(WeekTask(title: text, isComplete: false))
            
            UserDefaults.standard.set(weekData.tasks.map({$0.title}), forKey: "Week\(weekData.weekNumber)Titles")

            UserDefaults.standard.set(weekData.tasks.map({$0.isComplete}), forKey: "Week\(weekData.weekNumber)Completes")
            
            tableView.reloadData()
            
            myTextField.text = nil
            
            
            
        }
        
        return true
    }
    
    func didSelectUseMap() {

        
    }


}

extension firstvc: CustomTableViewCellDelegate {
    func didCheckBox(taskIndex: Int) {
        print("checked")
        weekData.tasks[taskIndex].isComplete.toggle()
        delegate?.didUpdateData(weekData: weekData)
        UserDefaults.standard.set(weekData.tasks.map({$0.isComplete}), forKey: "Week\(weekData.weekNumber)Completes")
//       delegate?.hideText(isCompleted: true)
    }
}

extension firstvc: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
        return weekData.tasks.count

    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                 for: indexPath) as! CustomTableViewCell
        cell.delegate = self
        cell.taskIndex = indexPath.item
        cell.textLabel?.text = weekData.tasks[indexPath.item].title
        if weekData.tasks[indexPath.item].isComplete {
            cell.checkbox1.toggle()
        }
        return cell


    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

      if editingStyle == .delete {
        print("Deleted")
          self.weekData.tasks.remove(at: indexPath.item)
          self.tableView.deleteRows(at: [indexPath], with: .automatic)
          delegate?.didUpdateData(weekData: weekData)
      }
    }

    

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        weekData.tasks[indexPath.row].isComplete = true
//
//        UserDefaults.standard.set(weekData.tasks.map({$0.title}), forKey: "Week\(weekData.weekNumber)Titles")
//
//        UserDefaults.standard.set(weekData.tasks.map({$0.isComplete}), forKey: "Week\(weekData.weekNumber)Completes")
//
//        tableView.reloadData()
//
//    }

}

