//
//  Utils.swift
//  Matrix Tools SC
//
//  Created by Wangyiwei on 2020/5/3.
//  Copyright © 2020 Wangyiwei. All rights reserved.
//

import Foundation

extension String {
    func repeating(_ times: Int) -> String {
        if(times < 1) {return ""}
        else if(times == 1) {return self}
        else {
            var result = ""
            for _ in 1...times {
                result = result + self
            }
            return result
        }
    }
}

func getProduct(_ array: [Int]) -> Int {
    if(array.isEmpty) {return 1}
    var product = 1
    for s in array {product *= s}
    return product
}

extension Matrix {
    func getValue(from axis: [Int]) -> Double {
        if(dims!.count != axis.count) {fatalError()}
        var index = 0
        for i in 0..<axis.count {
            index += dims![i] * axis[i]
        }
        return values![index]
    }
    
    func setValue(_ value: Double, to axis: [Int]) {
        if(dims!.count != axis.count) {fatalError()}
        var index = 0
        for i in 0..<axis.count {
            index += dims![i] * axis[i]
        }
        values![index] = value
    }
}
