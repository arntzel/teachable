//
//  SongsSearchResultsController.swift
//  TeachableExercise
//
//  Created by Eliot Arntz on 8/3/16.
//  Copyright © 2016 bitfountain. All rights reserved.
//

import UIKit

class SongsSearchResultsController: UITableViewController {

    private var filteredSongs = [Song]()
    
    var songSelector: SongSelector?
    
    var songs = [Song](){
        didSet {
            filteredSongs = songs
        }
    }
    
    private let cellIdentifier = "SongsSearchCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSongs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let song = filteredSongs[indexPath.row]
        cell.textLabel?.text = song.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let song = filteredSongs[indexPath.row]
        songSelector?.selectedsong(song)
    }
}

extension SongsSearchResultsController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        
        if searchText.characters.count > 0 {
            filteredSongs = songs.filter{
                $0.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil}
        } else {
            filteredSongs = songs
        }
        tableView.reloadData()
    }
}


