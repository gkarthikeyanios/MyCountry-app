//
//  ServerAPI.swift
//
//  Created by Smaatone on 1/4/17.
//  Copyright © 2017 Smaatone. All rights reserved.
//

import Foundation



class ServerAPI : NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate
{
    
    var delegate:ServerAPIDelegate?
    let baseURL:String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var data = NSMutableData()
   
    //MARK:country list
    func callCountryList(delegateAPI:ServerAPIDelegate)
    {
        
        delegate = delegateAPI
        let url = NSURL(string:String(format: "%@", arguments: [baseURL]))
        let request = NSMutableURLRequest(url:url! as URL)
        
        request.httpMethod = "GET"
        
        if let connection = NSURLConnection(request: request as URLRequest,delegate: self,startImmediately: true) {
            connection.start()
        }
    }
    
    //MARK:nsurl connection delegate methods
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        print("Failed with error:\(error.localizedDescription)")
        
        delegate?.API_CALLBACK_ERROR(errorNumber: 0,errorMessage:"Server is not responding properly.Please try again")
    }
    
    
    func connection(_ didReceiveResponse: NSURLConnection, didReceive response:URLResponse) {
        self.data = NSMutableData()
        
    }
    
    
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        self.data.append(data)
        
    }
    
    
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        
        print("connectionDidFinishLoading")
        
        let responseStrInISOLatin = String(data: data as Data, encoding: String.Encoding.isoLatin1)
       
        guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
            print("could not convert data to UTF-8 format")
            return
        }
        do {
            let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
            delegate?.CALLBACK_WebService!(dicResult:responseJSONDict as! Dictionary<String, Any>)
        } catch {
            print(error)
        }
    
    }

}
