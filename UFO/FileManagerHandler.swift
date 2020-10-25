//
//  CacheFile.swift
//  UFO
//
//  Created by Sanghyun Byun on 2020/10/25.
//  Copyright © 2020 Sanghyun Byun. All rights reserved.
//

import Foundation

class FileManagerHandler {
    
    var fileManager: FileManager
    var cachePath: URL
    var filePath: URL
    
    init(filename: String) {
        self.fileManager = FileManager.default
        self.cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        self.filePath = cachePath.appendingPathComponent(filename)
        
    }
    
    func fileExists() -> Bool {
        
        return self.fileManager.fileExists(atPath: self.filePath.path)
    }
    
    func getFileText() -> String {
                
        do  {
            let result = try String(contentsOf: self.filePath, encoding: .utf8)
            
            return result
            
        } catch let e {
            return e.localizedDescription
        }
    }
    
    func setFileText(str: String) {
        
        do {
            let text = NSString(string: str)
            
            try text.write(to: self.filePath, atomically: true, encoding: String.Encoding.utf8.rawValue)
            
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func removeFile() {
        do {
            try self.fileManager.removeItem(at: self.filePath)
        } catch let e {
            print(e.localizedDescription)
        }
    }
        
        
        
}
