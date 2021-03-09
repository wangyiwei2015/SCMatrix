//
//  ConvertMatrixHandler.swift
//  Matrix Tools SC
//
//  Created by Wangyiwei on 2020/5/1.
//  Copyright © 2020 Wangyiwei. All rights reserved.
//

import Foundation
import Intents

class ReadMatrixHandler: NSObject, ReadMatrixIntentHandling {
    
    func handle(intent: ReadMatrixIntent, completion: @escaping (ReadMatrixIntentResponse) -> Void) {
        guard let txt = intent.text else {
            completion(ReadMatrixIntentResponse(code: .failure, userActivity: nil))
            return
        }
        guard let resultMat = convertText(txt: txt) else {
            completion(ReadMatrixIntentResponse(code: .failure, userActivity: nil))
            return
        }
        let response = ReadMatrixIntentResponse(code: .success, userActivity: nil)
        response.matrix = resultMat
        completion(response)
    }
    
    func resolveText(for intent: ReadMatrixIntent, with completion: @escaping (ReadMatrixTextResolutionResult) -> Void) {
        if let txt = intent.text {
            completion(ReadMatrixTextResolutionResult.success(with: txt))
            return
        }
        completion(ReadMatrixTextResolutionResult.needsValue())
    }
    
    func convertText(txt: String) -> Matrix? {
        var literalMat = txt
        while(literalMat.contains("  ")) {
            literalMat = literalMat.replacingOccurrences(of: "  ", with: " ")
        }
        literalMat = literalMat.replacingOccurrences(of: " ", with: ",")
        while(literalMat.contains(",,")) {
            literalMat = literalMat.replacingOccurrences(of: ",,", with: ",")
        } // [[[1,2,3,4],[5,6,7,8]],[[1,2,3,4],[5,6,7,8]]]
        var dims = 0
        if(literalMat.first != "[") {return nil}
        while(literalMat.first! == "[") {
            literalMat = String(literalMat.dropFirst())
            if(literalMat.last != "]") {return nil}
            let _ = literalMat.popLast()
            dims += 1
        }
        var size: [Int] = []
        let getLastSizes = {() -> Int in
            if(size.isEmpty) {return 1}
            var product = 1
            for s in size {product *= s}
            return product
        }
        if(dims == 1) {size.append(1)}
        while dims > 1 {
            let splitStr = "\("]".repeating(dims - 1)),\("[".repeating(dims - 1))"
            let currentDim = Float(literalMat.components(separatedBy: splitStr).count) / Float(getLastSizes())
            let currentDimInt = Int(currentDim)
            if(currentDim != Float(currentDimInt)) {return nil}
            size.append(currentDimInt)
            literalMat = literalMat.replacingOccurrences(of: splitStr, with: ",")
            dims -= 1
        }
        if(literalMat.contains("[") || literalMat.contains("]")) {
            return nil
        }
        var mat: [Double] = []
        let numbers = literalMat.split(separator: ",")
        for number in numbers {
            guard let element = Double(number) else {return nil}
            mat.append(element)
        }
        var lastDim = mat.count
        for dim in size {
            lastDim = lastDim / dim
        }
        size.append(lastDim)
        let matrix = Matrix(identifier: nil, display: "Matrix")
        matrix.debugRaw = "\(literalMat)\nMatrix\(size.description)"
        matrix.dims = size
        matrix.values = mat
        return matrix
    }
}
