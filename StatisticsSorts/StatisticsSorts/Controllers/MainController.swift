//
//  ViewController.swift
//  StatisticsSorts
//
//  Created by Oleg Yankiwskyi on 5/10/18.
//  Copyright © 2018 Oleg Yankiwskyi. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var statusBar: UIProgressView!
    @IBOutlet weak var statisticsTable: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    var resultData: [[String]]!
    let arrayTypeSort: [TypeSort] = [.quick, .bubble, .merge, .insert, .select]
    let dataModel = DataModel()
    
    var progress: Float {
        get {
            return statusBar.progress
        }
        set {
            let parseValue = Int(newValue * 100)

            if parseValue < 100 && parseValue >= 0 {
                statusBar.setProgress(newValue, animated: true)
                statusLabel.text = "\( parseValue ) %"
            } else if parseValue == 100 {
                statusBar.setProgress(newValue, animated: true)
                statusLabel.text = "Done"
                reloadButton.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }
    
    private func reload() {
        progress = 0.0
        resultData = Array(repeating: Array(repeating: "wait", count: dataModel.count), count: arrayTypeSort.count)
        statisticsTable.reloadData()
        
        DispatchQueue.global().async {
            self.startStatistics([.bubble])
        }
        OperationQueue().addOperation {
            self.startStatistics([.insert, .quick, .merge, .select])
        }
    }
    
    private func startStatistics(_ typesSorts: [TypeSort]) {
        let model = TimeStatistics()
        var count = Int()
        let step = 1.0 / ( Float(arrayTypeSort.count) * Float(dataModel.count) )

        for typeSort in typesSorts {
            count = 0
            for item in dataModel.data {
                let time = model.timeSort(typeSort: typeSort, array: item.value)
                resultData[typeSort.rawValue][count] = "for \(item.key) , time is \(time) sec"
                DispatchQueue.main.sync {
                    statisticsTable.reloadRows(at: [IndexPath(row: count, section: typeSort.rawValue)], with: .automatic)
                    progress += step
                }
                count += 1
            }
        }
    }
    
    @IBAction func tapReloadButton(_ sender: Any) {
        reloadButton.isEnabled = false
        reload()
    }
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseIdentifier, for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        if resultData.indices.contains(indexPath.section) {
            if resultData[indexPath.section].indices.contains(indexPath.row) {
                cell.label?.text = resultData[indexPath.section][indexPath.row]
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayTypeSort.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 25))
        view.backgroundColor = .lightGray
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width, height: 25))
        label.text = TypeSort(rawValue: section)?.description ?? "default"
        view.addSubview(label)
        return view
    }
}

