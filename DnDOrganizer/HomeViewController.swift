//
//  HomeViewController.swift
//  LEGO
//
//  Created by Klay Erekson on 7/8/19.
//  Copyright © 2019 Klay Erekson. All rights reserved.
//

import UIKit

struct Global {
    static var isKlayMaster: Bool = UserDefaults.standard.bool(forKey: "isKlayMaster")
    
    static var savedProperties: [String: DuploPrice] = [:]
    
    static var savedPDPScreens: [Screen] = []
    
    static var savedActionURIs: [String: String] = [:]
    
    static let mostCommonDevice: Device = .iPhone12Pro
}

struct Version {
    static var current: String = "v7"
}

struct Screen: Codable {
    let key: String
    let title: String
    let category: String?
}

class HomeViewController: UIViewController {
    let baseView = HomeView()
    
    var prefix: String {
        get {
            return Constants.env.appStringInput
        }
    }
    
    private var sections: [HomeSection] = [.components, .pdps, .other]
    private var screens = [Screen]()
    private var createScreens: [Screen] {
        return screens.filter { $0.category == "create" }
    }
    private var pdpScreens: [Screen] {
        let tempScreens = screens.filter { $0.category == "pdp" }
        Global.savedPDPScreens = tempScreens
        return tempScreens
    }
    private var otherScreens: [Screen] {
        return screens.filter { $0.category != "create" && $0.category != "pdp" }
    }

    private var reordering = false
    
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
        baseView.tableView.register(HomeCell.self)
        
        title = "Products Screen"
        
        if Global.isKlayMaster {
            let masterEdit = UIBarButtonItem(image: UIImage.actions, style: .done, target: self, action: #selector(masterEditTapped))
            navigationItem.rightBarButtonItems = [masterEdit]
        }
        
        DuploService.shared.getProductPrice(forDuploSku: "OVERRIDE") { result in
            switch result {
            case .success(let prices):
                print(prices)
                for item in prices {
                    if Global.savedProperties[item.sku] == nil {
                        Global.savedProperties[item.sku] = item
                    }
                }
            case .failure(_):
                break
            }
        }
        
        setScreens()
    }
    
    private func setScreens() {
        self.screens = []
        baseView.activityIndicatorView.startAnimating()
        
        DuploService.shared.getDuplo(env: .staging, key: "chatbooks.duplos.screens", version: "v5") { result in
            switch result {
            case .success(let string):
                if let jsonData = string.value.data(using: .utf8) {
                    do {
                        self.screens = try JSONDecoder().decode([Screen].self, from: jsonData)
                        
                        DispatchQueue.main.async {
                            self.baseView.activityIndicatorView.stopAnimating()
                            self.baseView.tableView.reloadData()
                        }
                    } catch {
                        print("FAILED TO DECODE: \(error.localizedDescription)\n\(string)")
                        self.screens = []
                        DispatchQueue.main.async {
                            self.baseView.activityIndicatorView.stopAnimating()
                            self.baseView.tableView.reloadData()
                        }
                    }
                }
            case .failure(_):
                break
            }
        }
    }
    
    @objc func reloadTapped() {
        setScreens()
    }
    
    @objc func masterEditTapped() {
        let controller = MasterEditViewController(env: .staging, key: "chatbooks.duplos.screens", version: "v5")
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
}

enum HomeSection: String {
    case components = "create"
    case pdps = "pdp"
    case other = "other"
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .components:
            return createScreens.count
        case .pdps:
            return pdpScreens.count
        case .other:
            return otherScreens.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(HomeCell.self, for: indexPath)
        switch sections[indexPath.section] {
        case .components:
            let key = createScreens[indexPath.row].key
            cell.titleLabel.text = createScreens[indexPath.row].title
            cell.detailLabel.text = key
        case .pdps:
            let key = pdpScreens[indexPath.row].key
            cell.titleLabel.text = pdpScreens[indexPath.row].title
            cell.detailLabel.text = key
        case .other:
            let key = otherScreens[indexPath.row].key
            cell.titleLabel.text = otherScreens[indexPath.row].title
            cell.detailLabel.text = key
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .components:
            let title = createScreens[indexPath.row].title
            let key = createScreens[indexPath.row].key
            if key.contains("products.tiles") || key.contains("products.dream.tiles") || key.contains("products.holiday.tiles") || key.contains("shop.categories.tiles") {
                let buildTileController = BuildProductTilesViewController(suffix: key)
                self.navigationController?.pushViewController(buildTileController, animated: true)
            } else if key.contains("products.featured") || key.contains("products.holiday.featured") {
                let buildTileController = BuildFeatureTileViewController(suffix: key, singleTile: nil)
                self.navigationController?.pushViewController(buildTileController, animated: true)
            } else if key.contains("products.categories") || key.contains("products.dream.categories") || key.contains("products.holiday.categories") {
                let buildTileController = BuildCategoryViewController(suffix: key, selectedCategory: nil)
                self.navigationController?.pushViewController(buildTileController, animated: true)
            } else {
                let buildController = BuildViewController(key: key)
                buildController.title = title
                self.navigationController?.pushViewController(buildController, animated: true)
            }
        case .pdps:
            let title = pdpScreens[indexPath.row].title
            let key = pdpScreens[indexPath.row].key
            let buildController = BuildViewController(key: key)
            buildController.title = title
            self.navigationController?.pushViewController(buildController, animated: true)
        case .other:
            let title = otherScreens[indexPath.row].title
            let key = otherScreens[indexPath.row].key
            let buildController = BuildViewController(key: key)
            buildController.title = title
            self.navigationController?.pushViewController(buildController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .components:
            return "Product Screen Components"
        case .pdps:
            return "Product Detail Pages"
        case .other:
            return "Other Screens"
        }
        
    }
}

extension HomeViewController: MasterEditViewDelegate {
    func newDuplo(value: String, key: String) {
        setScreens()
    }
}
        
fileprivate extension String {
    
    /// Inner comparison utility to handle same versions with different length. (Ex: "1.0.0" & "1.0")
    private func compare(toVersion targetVersion: String) -> ComparisonResult {
        
        let versionDelimiter = "."
        var result: ComparisonResult = .orderedSame
        var versionComponents = components(separatedBy: versionDelimiter)
        var targetComponents = targetVersion.components(separatedBy: versionDelimiter)
        let spareCount = versionComponents.count - targetComponents.count
        
        if spareCount == 0 {
            result = compare(targetVersion, options: .numeric)
        } else {
            let spareZeros = repeatElement("0", count: abs(spareCount))
            if spareCount > 0 {
                targetComponents.append(contentsOf: spareZeros)
            } else {
                versionComponents.append(contentsOf: spareZeros)
            }
            result = versionComponents.joined(separator: versionDelimiter)
                .compare(targetComponents.joined(separator: versionDelimiter), options: .numeric)
        }
        return result
    }
    
    func isVersion(equalTo targetVersion: String) -> Bool { return compare(toVersion: targetVersion) == .orderedSame }
    func isVersion(greaterThan targetVersion: String) -> Bool { return compare(toVersion: targetVersion) == .orderedDescending }
    func isVersion(greaterThanOrEqualTo targetVersion: String) -> Bool { return compare(toVersion: targetVersion) != .orderedAscending }
    func isVersion(lessThan targetVersion: String) -> Bool { return compare(toVersion: targetVersion) == .orderedAscending }
    func isVersion(lessThanOrEqualTo targetVersion: String) -> Bool { return compare(toVersion: targetVersion) != .orderedDescending }
}
