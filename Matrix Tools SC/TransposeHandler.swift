//
//  TransposeHandler.swift
//  Matrix Tools SC
//
//  Created by Wangyiwei on 2020/5/3.
//  Copyright © 2020 Wangyiwei. All rights reserved.
//

import Foundation
import Intents

class TransposeHandler: NSObject, TransposeMatrixIntentHandling {
    
    func handle(intent: TransposeMatrixIntent, completion: @escaping (TransposeMatrixIntentResponse) -> Void) {
        guard let matrix = intent.input, let axis = intent.axis else {
            completion(TransposeMatrixIntentResponse(code: .failure, userActivity: nil))
            return
        }
        if(matrix.values!.count != getProduct(matrix.dims!)) {
            completion(TransposeMatrixIntentResponse(code: .failure, userActivity: nil))
            return
        }
        if(matrix.dims!.count == 1) {
            matrix.dims!.append(1)
            let response = TransposeMatrixIntentResponse(code: .success, userActivity: nil)
            response.result = matrix
            completion(response)
            return
        }
        
        //TODO: >1 dims
        // [0 1 2 3] -> [a b c d]
    }
    
    func resolveInput(for intent: TransposeMatrixIntent, with completion: @escaping (TransposeMatrixInputResolutionResult) -> Void) {
        guard let mat = intent.input else {
            completion(TransposeMatrixInputResolutionResult.needsValue())
            return
        }
        completion(TransposeMatrixInputResolutionResult.success(with: mat))
    }
    
    func resolveAxis(for intent: TransposeMatrixIntent, with completion: @escaping ([TransposeMatrixAxisResolutionResult]) -> Void) {
        if let matrix = intent.input {
            if(matrix.dims!.count < 2) {
                completion([TransposeMatrixAxisResolutionResult.notRequired()])
            } else if(matrix.dims!.count == 2){
                let result = [TransposeMatrixAxisResolutionResult.success(with: 1), TransposeMatrixAxisResolutionResult.success(with: 0)]
                completion(result)
            } else {
                if(intent.axis!.count == matrix.dims!.count) {
                    var result: [TransposeMatrixAxisResolutionResult] = []
                    for axis in intent.axis! {
                        result.append(TransposeMatrixAxisResolutionResult.success(with: axis))
                    }
                    completion(result)
                } else {
                    completion([TransposeMatrixAxisResolutionResult.needsValue()])
                }
            }
            return
        }
    }
}
