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
        testFrontierSearch(searchMethod: .DFS)
    }

    func testFrontierSearch(searchMethod: SearchMethod) {

        simplaGraphTest(searchMethod: searchMethod)
        complexGraphTest(searchMethod: searchMethod)

    }

    func simplaGraphTest(searchMethod: SearchMethod) {

        let algorith = FrontierSearch()
        let start = createSimpleGraph()

        let pa = algorith.search(query: "a", node: start, searchMethod: searchMethod)
        print(printer(path: pa))
        results.append(pa)

        let pc = algorith.search(query: "c", node: start, searchMethod: searchMethod)
        print(printer(path: pc))
        results.append(pc)

        let pd = algorith.search(query: "d", node: start, searchMethod: searchMethod)
        print(printer(path: pd))
        results.append(pd)

        let pg = algorith.search(query: "g", node: start, searchMethod: searchMethod)
        print(printer(path: pg))
        results.append(pg)
    }

    func complexGraphTest(searchMethod: SearchMethod) {

        let algorith = FrontierSearch()
        let start = createComplexGraph()

        let pg = algorith.search(query: "g", node: start, searchMethod: searchMethod)
        print(printer(path: pg))
        results.append(pg)
    }

    func createSimpleGraph() -> Node {

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

    func createComplexGraph() -> Node {

        // Creates & connects nodes a, b, c, d, e, f, g, h, i, j, k
        let a = Node( contents: "a")
        let b = Node( contents: "b")
        let c = Node( contents: "c")
        let d = Node( contents: "d")
        let e = Node( contents: "e")
        let f = Node( contents: "f")
        let g = Node( contents: "g")
        let h = Node( contents: "h")
        let i = Node( contents: "i")
        let j = Node( contents: "j")
        let k = Node( contents: "k")

        //level 1
        a.children.append( b)
        a.children.append( c)
        a.children.append( d)

        //level 2
        b.children.append( e)
        b.children.append( f)

        c.children.append( g)
        c.children.append( h)
        c.children.append( i)

        d.children.append(j)

        //level 3
        j.children.append( k)
        j.children.append( g)

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

