//
//  ServerAPIDelegate.swift
//  Created by Smaatone on 1/4/17.
//  Copyright © 2017 Smaatone. All rights reserved.
//

import Foundation
@objc protocol ServerAPIDelegate
{
    func API_CALLBACK_ERROR(errorNumber:Int, errorMessage:String)
    @objc optional func CALLBACK_WebService(dicResult:Dictionary<String, Any>)
}
