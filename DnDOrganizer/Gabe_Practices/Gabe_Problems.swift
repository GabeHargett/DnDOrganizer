//
//  Gabe_Problems.swift
//  DnDOrganizer
//
//  Created by Tanner Rozier on 3/3/22.
//

import Foundation

class GabePractice {

    //The class to initiate this func is in HomeViewCOntroller's viewDidLoad
    class func start() {

        //Question 1 Test. Uncomment below 2 lines to start testing

        let answer1 = getIndexOfFirst(desiredValue: 3, numbers: [3, 6, 4, 8, 3, 6])

        func getIndexOfFirst(desiredValue: Int, numbers: [Int]) -> [Int]{
        var answer = [Int]()
            for (index, number) in numbers.enumerated() {
                if number == desiredValue {
                    answer.append(index)
                }

            }
return answer
        }
        print("Answer 1 is \(answer1)")




        //         this should print [0, 4]


        //Question 2 Test. Uncomment below 2 lines to start testing
        let answer2 = returnAllIntegersThatAreMultipleOf(value: 3, numbers: [2, 3, 4, 9])

        func returnAllIntegersThatAreMultipleOf(value: Int, numbers: [Int]) -> [Int] {
            var answer = [Int]()
            for number in numbers {
                if number % value == 0 {
                    answer.append(number)
                }
            }
            return answer
        }
        print("Answer 2 is \(answer2)")



        
//         this should print [3, 9]
//
   }

//Question 1 Method. Uncomment below function to start
//    private class func getIndexOfFirst(desiredValue: Int, numbers: [Int]) -> [Int] {
//
//        return[]
//    }
//    
//
//
//    Question 2 Method. Uncomment below function to start
//    private class func returnAllIntegersThatAreMultipleOf(value: Int, numbers: [Int]) -> [Int] {
//
//    }
//
//}
    }
