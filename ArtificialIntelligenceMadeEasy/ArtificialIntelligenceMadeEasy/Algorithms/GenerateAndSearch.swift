//
//  GenerateAndSearch.swift
//  ArtificialIntelligenceMadeEasy
//
//  Created by user on 3/23/17.
//  Copyright © 2017 someCompanyNameHere. All rights reserved.
//

import UIKit

class GenerateAndSearch: NSObject {


    /**
     Slow version of generate and search algorithm, all hours are included as inputs
     - parameter [Int]: available hours person 1
     - parameter [Int]: available hours person 2
     - parameter [Int]: available hours person 3
     - parameter [Int]: available hours person 4
     - returns: [String]
     */
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
     Generic slow version of generate and search algorithm, all hours are included as inputs
     - parameter [T]: available hours person 1
     - parameter [T]: available hours person 2
     - parameter [T]: available hours person 3
     - parameter [T]: available hours person 4
     - returns: [String]
     */
    func genericGenerateAndSearch<T:Equatable>(inputs:[[T]], constaints:[(T) -> Bool]) -> [String] {

        var availableTimes = [String]()
        for v in inputs[0] {

            for w in inputs[1] {

                for x in inputs[2] {

                    for y in inputs[3] {

                        if goal(a: v, b: w, c: x, d: y) &&
                            constaints[0](v) &&
                            constaints[1](w) &&
                            constaints[2](x) &&
                            constaints[3](y) {
                            availableTimes.append("Anna, Betty, Cara and Donna can hang out at \(v):00")
                        }

                    }
                    
                }
            }
        }
        return availableTimes
    }

    /**
     Improved version of generate and search algorithm, removes unavailable hours from inputs
      - parameter [Int]: available hours person 1
      - parameter [Int]: available hours person 2
      - parameter [Int]: available hours person 3
      - parameter [Int]: available hours person 4
      - returns: [String]
     */
    func generateAndSearchFast(anna:[Int], betty:[Int], cara:[Int], donna:[Int]) -> [String] {
        let a = available1(hours: anna)
        let b = available2(hours: betty)
        let c = available3(hours: cara)
        let d = available4(hours: donna)

        var availableTimes = [String]()
        for v in a {

            for w in b {

                for x in c {

                    for y in d {

                        if goal(a: v, b: w, c: x, d: y) {
                            availableTimes.append("Anna, Betty, Cara and Donna can hang out at \(v):00")
                        }

                    }
                    
                }
            }
        }
        return availableTimes
    }

    /**
    Generic function to compare four inputs for equality.
     Have an hour of the day when EVERYONE is available to meet
     - parameter Int: an hour of the day for a person
     - parameter Int: an hour of the day for a person
     - parameter Int: an hour of the day for a person
     - parameter Int: an hour of the day for a person
     - returns: Bool return True if all input hours are equal
     - note: one input for each person
     */
    func goal<T:Equatable>(a:T, b:T, c:T, d:T) -> Bool {
        return (a == b && b == c && c == d)
    }


    /**
    Hours of the day when person is unavaialble
     - parameter Int: an hour of the day for a person
     - returns: Bool return True if hour is outside of constraint, false otherwise
     */
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


    //Anna has classes from 11:00 - 1:50 pm
    func available1(hours:[Int]) -> [Int] {
        let delList = hours.filter{ $0 >= 11 && $0 <= 14}
        return hours.filter{ !delList.contains($0) }
    }

    //Betty has classes from noon to 3
    func available2(hours:[Int]) -> [Int] {
        let delList = hours.filter{ $0 >= 12 && $0 < 16}
        return hours.filter{ !delList.contains($0) }
    }

    //Cara has work from 7 to 11 pm
    func available3(hours:[Int]) -> [Int] {
        let delList = hours.filter{ $0 >= 19 && $0 <= 23}
        return hours.filter{ !delList.contains($0) }
    }

    //Donna has volunteer hours from 6 to 8 pm
    func available4(hours:[Int]) -> [Int] {
        let delList = hours.filter{ $0 >= 18 && $0 <= 22}
        return hours.filter{ !delList.contains($0) }
    }

}
