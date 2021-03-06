//
//  Gabe_Problems.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 3/3/22.
//

import UIKit

class GabePractice {
    
    //The class to initiate this func is in HomeViewCOntroller's viewDidLoad
    class func start() {
        
        //Question 1 Test. Uncomment below 2 lines to start testing
        
//        let answer1 = getIndexOfFirst(desiredValue: 3, numbers: [3, 6, 4, 8, 3, 6])
//
//        func getIndexOfFirst(desiredValue: Int, numbers: [Int]) -> [Int]{
//            var answer = [Int]()
//            for (index, number) in numbers.enumerated() {
//                if number == desiredValue {
//                    answer.append(index)
//                }
//
//            }
//            return answer
//        }
//        print("Answer 1 is \(answer1)")
        
        
        
        
        //         this should print [0, 4]
        
        
//        Question 2 Test. Uncomment below 2 lines to start testing
//        let answer2 = returnAllIntegersThatAreMultipleOf(value: 3, numbers: [2, 3, 4, 9])
//
//        func returnAllIntegersThatAreMultipleOf(value: Int, numbers: [Int]) -> [Int] {
//            var answer = [Int]()
//            for number in numbers {
//                if number % value == 0 {
//                    answer.append(number)
//                }
//            }
//            return answer
//        }
//        print("Answer 2 is \(answer2)")
//                 this should print [3, 9]
        
        
        
        
        
        //Question 3 Test. Uncomment below lines to start testing
        
//        func findTheLargestSumTwoDifferentNumbersCanMakeInNumbersArray(numbers: [Int]) -> Int {
//            var numbers = numbers
//            numbers.sort()
//            var answer: Int = 0
//            let numbersCount = numbers.count
//            if numbersCount < 2 {
//                return 0
//            }
//            let lastNumber = numbers[numbersCount - 1]
//            let secondLastNumber = numbers[numbersCount - 2]
//answer = lastNumber + secondLastNumber
//return(answer)
//        }
//        func findTheLargestSumTwoDifferentNumbersCanMakeInNumbersArray(numbers: [Int]) -> Int {
//            var firstLargest: Int?
//            var secondLargest: Int?
//            for number in numbers {
//                if let firstLargestTemp = firstLargest {
//                    if number > firstLargestTemp {
//                        secondLargest = firstLargest
//                        firstLargest = number
//                    } else {
//                        if let secondLargestTemp = secondLargest {
//                            if number > secondLargestTemp {
//                                secondLargest = number
//                            }
//                        } else {
//                            secondLargest = number
//                        }
//                    }
//                } else {
//                    firstLargest = number
//                }
//
//            }
//            return firstLargest! + secondLargest!
//        }
//
//        let answer3 = findTheLargestSumTwoDifferentNumbersCanMakeInNumbersArray(numbers: [5, 3, 12, 4, 10])
//
//        print("Answer 3 is \(answer3)")
//                 this should print 23
//
//         [-3, 4, -1] should print 3
        
        
        
        
        
        //Question 4 Test. Uncomment below lines to start testing
        struct PointAndDistance {
            var closestPoint: CGPoint
            var closestDistance: CGFloat
        }
        
        func findThePointClosestToTheKeyPoint(keyPoint: CGPoint, points: [CGPoint]) -> PointAndDistance {


                func distanceBetweenTwoPoints(point1: CGPoint, point2: CGPoint) -> CGFloat {
                    let changeXSquared = pow(point2.x-point1.x, 2)
                    let changeYSquared = pow(point2.y-point1.y, 2)
                    return pow(changeXSquared + changeYSquared, 0.5)
                }

            var pointAndDistance:PointAndDistance?
            
                for point in points {
                    if let closestDistanceTemp = pointAndDistance?.closestDistance {
                        let newDistance = distanceBetweenTwoPoints(point1: point, point2: keyPoint)
                        if newDistance < closestDistanceTemp {
                            pointAndDistance?.closestPoint = point
                            pointAndDistance?.closestDistance = newDistance
                        }
                    } else {
                    pointAndDistance = PointAndDistance(closestPoint: point, closestDistance: distanceBetweenTwoPoints(point1: point, point2: keyPoint))
                    }
                }
            return pointAndDistance!            }


        let answer4 = findThePointClosestToTheKeyPoint(keyPoint: CGPoint(x: 2, y: 5), points: [CGPoint(x: 0, y: 0), CGPoint(x: 5, y: 5), CGPoint(x: 1.5, y: 7.9)])
        print("Answer 4 is \(answer4)")
//        This should print (1.5, 7.9)
        
    }
}
