//
//  Gabe_ProblemAnswers.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 3/3/22.
//

import Foundation

//Problem 1 Answer
//private class func getIndexOfFirst(desiredValue: Int, numbers: [Int]) -> [Int] {
//    var answer = [Int]()
//    for (index, number) in numbers.enumerated() {
//        if number == desiredValue {
//            answer.append(index)
//        }
//    }
//    return answer
//}








//Problem 2 Answer
//private class func returnAllIntegersThatAreMultipleOf(value: Int, numbers: [Int]) -> [Int] {
//    var answer = [Int]()
//    for number in numbers {
//        if number % value == 0 {
//            answer.append(number)
//        }
//    }
//    return answer
//}





//Problem 3 Answer
//func findTheLargestSumTwoDifferentNumbersCanMakeInNumbersArray(numbers: [Int]) -> Int {
//    var firstLargest: Int?
//    var secondLargest: Int?
//    for number in numbers {
//        if let firstLargestTemp = firstLargest {
//            if number > firstLargestTemp {
//                secondLargest = firstLargest
//                firstLargest = number
//            } else {
//                if let secondLargestTemp = secondLargest {
//                    if number > secondLargestTemp {
//                        secondLargest = number
//                    }
//                } else {
//                    secondLargest = number
//                }
//            }
//        } else {
//            firstLargest = number
//        }
//    }
//    return firstLargest! + secondLargest!
//}
