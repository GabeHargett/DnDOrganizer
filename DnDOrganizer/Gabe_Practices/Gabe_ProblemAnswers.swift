//
//  Gabe_ProblemAnswers.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 3/3/22.
//

import UIKit

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




//Problem 4 Answer
//func findThePointClosestToTheKeyPoint(keyPoint: CGPoint, points: [CGPoint]) -> CGPoint {
//
//    func distanceBetweenTwoPoints(point1: CGPoint, point2: CGPoint) -> CGFloat {
//        let changeXSquared = pow(point2.x-point1.x, 2)
//        let changeYSquared = pow(point2.y-point1.y, 2)
//        return pow(changeXSquared + changeYSquared, 0.5)
//    }
//
//    var closestPoint: CGPoint?
//    var closestDistance: CGFloat?
//    for point in points {
//        if let closestDistanceTemp = closestDistance {
//            let newDistance = distanceBetweenTwoPoints(point1: point, point2: keyPoint)
//            if newDistance < closestDistanceTemp {
//                closestPoint = point
//                closestDistance = newDistance
//            }
//        } else {
//            closestPoint = point
//            closestDistance = distanceBetweenTwoPoints(point1: point, point2: keyPoint)
//        }
//    }
//    return closestPoint!
//}
