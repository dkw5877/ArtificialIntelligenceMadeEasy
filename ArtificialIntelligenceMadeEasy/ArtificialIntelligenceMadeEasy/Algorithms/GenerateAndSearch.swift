//
//  GenerateAndSearch.swift
//  ArtificialIntelligenceMadeEasy
//
//  Created by user on 3/23/17.
//  Copyright © 2017 someCompanyNameHere. All rights reserved.
//

import UIKit

class GenerateAndSearch: NSObject {

    func generateAndSearch(anna:[Int], betty:[Int], cara:[Int], donna:[Int]) -> [String] {

        var availableTimes = [String]()
        for v in anna {

            for w in betty {

                for x in cara {

                    for y in donna {

                        if goal(a: v, b: w, c: x, d: y) &&
                        constraint1(hour: v) &&
                        constraint2(hour: w) &&
                        constraint3(hour: x) &&
                            constraint4(hour: y) {
                            availableTimes.append("Anna, Betty, Cara and Donna can hang out at \(v):00")
                        }

                    }

                }
            }
        }
        return availableTimes
    }

    /**
     Have an hour of the day when EVERYONE is available to meet
     - parameter Int: an hour of the day for a person
     - parameter Int: an hour of the day for a person
     - parameter Int: an hour of the day for a person
     - parameter Int: an hour of the day for a person
     - returns: Bool return True if all input hours are equal
     - note: one input for each person
     */
    func goal(a:Int, b:Int, c:Int, d:Int) -> Bool {
        return (a == b && b == c && c == d)
    }

    //Anna has classes from 11:00 - 1:50 pm
    /**
    Hours of the day when person is unavaialble
     - parameter Int: an hour of the day for a person
     - returns: Bool return True if hour is outside of constraint, false otherwise
     */
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

    //Diana has volunteer hours from 6 to 8 pm
    func constraint4(hour:Int) -> Bool {
        return (hour < 18 || hour > 22)
    }

}
