//
//  ViewController.swift
//  ArtificialIntelligenceSwift
//
//  Created by user on 3/14/17.
//  Copyright © 2017 someCompanyNameHere. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var results = [Path]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        testFrontierSearch()
    }

    func testFrontierSearch() {

        let algorith = FrontierSearch()
        let start = createGraphForFrontierSearch()

        let pa = algorith.search(query: "a", node: start)
        print(printer(path: pa))
        results.append(pa)

        let pc = algorith.search(query: "c", node: start)
        print(printer(path: pc))
        results.append(pc)

        let pd = algorith.search(query: "d", node: start)
        print(printer(path: pd))
        results.append(pd)

        let pg = algorith.search(query: "g", node: start)
        print(printer(path: pg))
        results.append(pg)
    }

    func createGraphForFrontierSearch() -> Node {

        // Creates & connects nodes a, b, c, d
        let a = Node( contents: "a")
        let b = Node( contents: "b")
        let c = Node( contents: "c")
        let d = Node( contents: "d")
        a.children.append( b)
        a.children.append( c)
        b.children.append( d)

        return a
    }

    
    func printer( path: Path) -> String {
        if path.contents.isEmpty {
            return "NOTE: No Solution Found"
        } else {
            var solution = "Solution Found! Path: "
            for node in path.contents {
                solution += node.contents + ", "
            }
            return solution
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        cell?.textLabel?.text = printer(path: results[indexPath.row])
        return cell!
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Frontier Search"
    }
}

