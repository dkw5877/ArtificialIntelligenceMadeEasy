//
//  FrontierSearch.swift
//  ArtificialIntelligenceSwift
//
//  Created by user on 3/22/17.
//  Copyright © 2017 someCompanyNameHere. All rights reserved.
//

import UIKit

class FrontierSearch {

    func search(query:String, node:Node) -> Path {

        var frontier = [Path]()

        //create a new Path and put the Start node in it
        let path = Path()
        path.contents.append(node)

        //put the new Path into the frontier
        frontier.append(path)

        while !frontier.isEmpty {

            //select and remove a path for the frontier
            let pick = pickPath(paths: &frontier)

            //if a node in path has goal, return path
            if hasGoal(s: query, path: pick) {
                return pick
            }

            //for eveey connected node of end node
            let sk = pick.contents.last

            if let sk = sk {

                //add copied path to frontier
                for node in sk.children {
                    //make copy of selected path
                    let toAdd = Path()
                    toAdd.contents.append(contentsOf: pick.contents)

                    //add connected node onto path copy
                    toAdd.contents.append(node)

                    //add copied path to frontier
                    frontier.append(toAdd)
                }
            }
        }

        //return empty path if no solution is found
        return Path()
        
    }

    // INPUT: a List of Paths
    // OUTPUT: a Single Path
    // EFFECT: based on positioning of your choice:
    // - Select & remove a path
    // - output that path
    // NOTE: you can modify the position assignment to change the Search Strategy
    func pickPath(paths:inout [Path]) -> Path {
        let position = 0
        let path = paths[position]
        paths.remove(at: position)
        return path
    }

    // INPUTs: a Path
    // - Node contents that have a solution
    // < same data type as Node’s container >
    // OUTPUT: boolean
    // EFFECT: outputs True if path contains a Goal
    // - If path doesnt contain the goal, output False
    func hasGoal(s:String, path:Path) -> Bool {

        for node in path.contents {
            if node.contents == s {
                return true
            }
        }

        return false
    }

}
