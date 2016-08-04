//
//  ArtistsViewController.swift
//  TeachableExercise
//
//  Created by Eliot Arntz on 8/1/16.
//  Copyright © 2016 bitfountain. All rights reserved.
//

import UIKit

class SongsViewController: UIViewController, SongSelector {

    var lastFMStore: LastFMStore?
    
    private let tableView = UITableView(frame: CGRectZero, style: .Plain)
    private let cellIdentifier = "SongCell"
    
    var songs: [Song]?
    
    private var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resultsVC = SongsSearchResultsController()
        
        lastFMStore = LastFMStore()

        lastFMStore?.fetchTopArtists({artists in
            self.songs = artists
            resultsVC.songs = artists

            //necessary since we are kicking off the API request in the background
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })

            }) { (errorMessage) in
        }
        
        automaticallyAdjustsScrollViewInsets = false
        
        tableView.registerClass(SongCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.dataSource = self
        tableView.delegate = self

        fillViewWith(tableView)
        
        resultsVC.songSelector = self
        
        searchController = UISearchController(searchResultsController: resultsVC)
        searchController?.searchResultsUpdater = resultsVC
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchController?.searchBar
        
        title = "Press to View in AppStore"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectedsong(song: Song) {
        searchController?.active = false
    }

}


extension SongsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SongCell

        if let songs = songs {
            let song = songs[indexPath.row]
            cell.artistLabel.text = song.artist
            cell.nameLabel.text = song.name
            cell.durationLabel.text = "Listeners: " + song.listeners!
            
            if let url = song.imagesUrl {
                cell.profileImage.setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: "placeholder"))
            }
        }
        return cell
    }
}

extension SongsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let song = songs![indexPath.row]
        selectedsong(song)
    }
}

