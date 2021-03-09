//
//  IntentHandler.swift
//  Matrix Tools SC
//
//  Created by Wangyiwei on 2020/5/1.
//  Copyright © 2020 Wangyiwei. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if(intent is ReadMatrixIntent) {
            return ReadMatrixHandler()
        } else {
        return self
        }
    }
}
