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

    var paths = [Path]()
    var availableTimes = [String]()
    var availableTimes2 = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        testFrontierSearch(searchMethod: .DFS)
        testGenerateAndSearch()
        testGenerateAndSearchFast()
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension

    }

    func testFrontierSearch(searchMethod: SearchMethod) {

        simplaGraphTest(searchMethod: searchMethod)
        complexGraphTest(searchMethod: searchMethod)

    }

    func testGenerateAndSearch() {
        let inputs = createSearchInputs()
        let constraints = createContraints()
        let algorithm = GenerateAndSearch()
//        availableTimes = algorithm.generateAndSearch(anna: inputs[0], betty: inputs[1], cara: inputs[2], donna: inputs[3])
        availableTimes = algorithm.genericGenerateAndSearch(inputs: inputs, constaints: constraints)
        print(availableTimes)
    }

    func testGenerateAndSearchFast() {
        let inputs = createSearchInputs()
        let algorithm = GenerateAndSearch()
        availableTimes2 = algorithm.generateAndSearchFast(anna: inputs[0], betty: inputs[1], cara: inputs[2], donna: inputs[3])
        print(availableTimes2)
    }

    func simplaGraphTest(searchMethod: SearchMethod) {

        let algorith = FrontierSearch()
        let start = createSimpleGraph()

        let pa = algorith.search(query: "a", node: start, searchMethod: searchMethod)
        print(printer(path: pa))
        paths.append(pa)

        let pc = algorith.search(query: "c", node: start, searchMethod: searchMethod)
        print(printer(path: pc))
        paths.append(pc)

        let pd = algorith.search(query: "d", node: start, searchMethod: searchMethod)
        print(printer(path: pd))
        paths.append(pd)

        let pg = algorith.search(query: "g", node: start, searchMethod: searchMethod)
        print(printer(path: pg))
        paths.append(pg)
    }

    func complexGraphTest(searchMethod: SearchMethod) {

        let algorith = FrontierSearch()
        let start = createComplexGraph()

        let pg = algorith.search(query: "g", node: start, searchMethod: searchMethod)
        print(printer(path: pg))
        paths.append(pg)
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


    func createSearchInputs() -> [[Int]]{

        let anna = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let betty = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let cara = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let donna = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]

        return [anna, betty, cara, donna]

    }

    func createContraints() -> [(Int) -> Bool] {

        //Anna has classes from 11:00 - 1:50 pm
        func constraint1(hour:Int) -> Bool {
            return (hour < 11 || hour > 13)
        }

        //Betty has classes from noon to 3
        func constraint2(hour:Int) -> Bool {
            return (hour < 12 || hour > 15)
        }

        //Cara has work from 7 to 11 pm
        func constraint3(hour:Int) -> Bool {
            return (hour < 19 || hour > 23)
        }

        //Donna has volunteer hours from 6 to 8 pm
        func constraint4(hour:Int) -> Bool {
            return (hour < 18 || hour > 22)
        }


        let annaConstraint: (Int) -> Bool = constraint1
        let bettyConstraint: (Int) -> Bool = constraint2
        let caraConstraint: (Int) -> Bool = constraint3
        let dianaConstraint: (Int) -> Bool = constraint4

        return [annaConstraint, bettyConstraint, caraConstraint, dianaConstraint]
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
             return paths.count
        case 1:
             return availableTimes.count
        case 2:
            return availableTimes2.count
        default:
            return 0
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .byWordWrapping

        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = printer(path: paths[indexPath.row])
        case 1:
            cell?.textLabel?.text = availableTimes[indexPath.row]
        case 2:
             cell?.textLabel?.text = availableTimes2[indexPath.row]
        default: break

        }

        return cell!
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Frontier Search"
        case 1:
            return "Generate and Test"
        case 2:
            return "Generate and Test Fast"
        default:
            return nil
        }

    }
}

