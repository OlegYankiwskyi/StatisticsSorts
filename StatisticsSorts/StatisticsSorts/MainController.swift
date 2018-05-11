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
    var resultData: Array<Array<String>>!
    let arrayTypeSort: [TypeSort] = [.quick, .bubble, .merge, .insert, .select]
    let firstData = [
        "1000"  :  Array<Int>.makeList(count: 1000, range: 999)
        ,"2000"  :  Array<Int>.makeList(count: 2000, range: 999)
        ,"4000"  :  Array<Int>.makeList(count: 4000, range: 999)
        ,"8000"  :  Array<Int>.makeList(count: 8000, range: 999)
        ,"16000" :  Array<Int>.makeList(count: 16000,range: 999)
    ]
    
    var progress: Float {
        get {
            return statusBar.progress
        }
        set {
            statusBar.setProgress(newValue, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBar.setProgress(0, animated: false)
        resultData = Array(repeating: Array(repeating: "", count: firstData.count), count: arrayTypeSort.count)

        DispatchQueue.global().async {
            self.startStatistics([.insert, .bubble, .select])
        }
        OperationQueue().addOperation {
            self.startStatistics([.merge, .quick])
        }
    }
    
    private func startStatistics(_ typesSorts: [TypeSort]) {
        let model = TimeStatistics()
        var count = Int()
        let step = 1.0 / ( Float(arrayTypeSort.count) * Float(firstData.count) )

        for typeSort in typesSorts {
            count = 0
            for item in firstData {
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
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstData.count
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
        label.text = TypeSort(rawValue: section).description
        view.addSubview(label)
        return view
    }
}

