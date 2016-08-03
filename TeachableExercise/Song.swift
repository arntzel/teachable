//
//  Song.swift
//  TeachableExercise
//
//  Created by Eliot Arntz on 8/2/16.
//  Copyright © 2016 bitfountain. All rights reserved.
//

import Foundation

class Song {
    var name: String?
    var duration: String?
    var listeners: String?
    var artist: String?
    var imagesUrl: String?
        
    static func new(jsonData:[String: AnyObject])->Song{
        
        let newSong = Song()
        
        if let name = jsonData["name"] {
            newSong.name = name as? String
        }
        
        if let playcount = jsonData["duration"] {
            newSong.duration = playcount as? String
        }
        
        if let listeners = jsonData["listeners"] {
            newSong.listeners = listeners as? String
        }
        
        if let artistDictionary = jsonData["artist"] as? NSDictionary, artistName = artistDictionary["name"] as? String{
            newSong.artist = artistName
        }
        
        if let imagesUrlArray = jsonData["image"] as? NSArray, firstImageDictionary = imagesUrlArray.firstObject as? NSDictionary {
            newSong.imagesUrl = firstImageDictionary["#text"] as? String
        }
        
        return newSong
    }

}