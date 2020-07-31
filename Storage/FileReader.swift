//
//  FileReader.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 19/07/2020.
//

import Foundation


class FileReader {
    
    static func getContent(ofFileName fileName:String, withExtension type: String = "json") -> Data? {
        let bundle = Bundle.main
        
        guard let pathOfFile = bundle.path(forResource: fileName, ofType: type) else {
            print("[FILE][ERROR] Cannot find file for path : \(fileName).\(type)")
            return nil
        }
        
        guard let contentString = try? String(contentsOfFile: pathOfFile, encoding: String.Encoding.utf8) else {
            print("[FILE][ERROR] Cannot read file : \(fileName).\(type)")
            return nil
        }
        
        guard let dataFromFile = contentString.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
            print("[FILE][ERROR] Cannot decode file : \(fileName).\(type)")
            return nil
        }
        
        return dataFromFile
        
    }
}
