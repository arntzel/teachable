//
//  LastFMStore.swift
//  TeachableExercise
//
//  Created by Eliot Arntz on 8/2/16.
//  Copyright © 2016 bitfountain. All rights reserved.
//

import Foundation

class LastFMStore {
    
    private let rootRef = "http://ws.audioscrobbler.com/2.0/"
    private let apiKey = "3f8aaae9cb949fa12cc175cd97411fdd"
    private let requestLimit = "100"
    
    func fetchTopArtists(success: (songs: [Song]) -> (), error errorCallback: (errorMessage: String) -> ()) {
        
        let endpoint: String = rootRef + "?method=chart.gettoptracks&api_key=" + apiKey + "&format=json&limit=" + requestLimit
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: endpoint)!
        
        session.dataTaskWithURL(url, completionHandler: {( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error != nil {
                errorCallback(errorMessage: error!.description)
            } else {
                do {
                    if NSString(data:data!, encoding: NSUTF8StringEncoding) != nil {
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        if let dict = jsonDictionary["tracks"] as? NSDictionary, artists = dict["track"] as? NSArray {
                            var songs: [Song] = []
                            for artist in artists {
                                if let validArtist = artist as? NSDictionary {
                                    songs.append(Song(jsonData: validArtist as! [String : AnyObject]))
                                }
                            }
                            success(songs: songs)
                        }
                        else {
                            errorCallback(errorMessage: "No Valid Information")
                        }
                    }
                } catch {
                    print("Data was not properly formatted")
                }
            }
        }).resume()
    }
}

//    Application name	Teachable
//    API key	3f8aaae9cb949fa12cc175cd97411fdd
//    Shared secret	f002fd77fd69dd50d2a5626cfa18861e
//    Registered to	arntzel
//    http://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=3f8aaae9cb949fa12cc175cd97411fdd&format=json&limit=100