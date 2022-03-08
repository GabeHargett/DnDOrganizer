//
//  WeeksClassVC.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 3/2/22.
//

import UIKit

class WeeksClassVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    setupTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeekTableViewCell.identifier,
                                                 for: indexPath) as! WeekTableViewCell
        cell.weekLabel.text = "Week \(indexPath.item + 1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.item+1)
        
        let week1Data = WeekData(weekNumber: indexPath.item + 1, tasks: [])
        let vc = firstvc(weekData: week1Data)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)

     }
//    githubcheck
    
    
    func setupTableView() {
        view.addAutoLayoutSubview(tableView)
        tableView.fillSuperview()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeekTableViewCell.self,
                           forCellReuseIdentifier: WeekTableViewCell.identifier)
    }

    
}

extension WeeksClassVC: firstvcDelegate {

    func didUpdateData(weekNumber: Int) {
        if weekNumber <= 1 {
            print(weekNumber)
}
    }
}

class WeekTableViewCell: UITableViewCell {
    
    static let identifier = "WeekTableViewCell"
    
    let weekLabel = UILabel()

  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
        
        weekLabel.text = ""
        weekLabel.font = UIFont.systemFont(ofSize: 50.0)
        contentView.addAutoLayoutSubview(weekLabel)
        weekLabel.fillSuperview()
    }
    

 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
