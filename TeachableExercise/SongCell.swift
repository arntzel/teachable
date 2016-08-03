//
//  SongCell.swift
//  TeachableExercise
//
//  Created by Eliot Arntz on 8/2/16.
//  Copyright © 2016 bitfountain. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    let profileImage = UIImageView()
    let artistLabel = UILabel()
    let nameLabel = UILabel()
    let durationLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        artistLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightBold)
        nameLabel.font = UIFont.systemFontOfSize(12)
        nameLabel.textColor = UIColor.grayColor()
        durationLabel.font = UIFont.systemFontOfSize(12)
        durationLabel.textColor = UIColor.grayColor()
        
        let views = [profileImage, artistLabel, nameLabel, durationLabel]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
        
        let constraints: [NSLayoutConstraint] = [
            profileImage.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
            profileImage.leadingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.leadingAnchor),
            profileImage.bottomAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.bottomAnchor),
            profileImage.widthAnchor.constraintEqualToConstant(contentView.frame.size.height * 2),
            artistLabel.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
            artistLabel.leadingAnchor.constraintEqualToAnchor(profileImage.trailingAnchor, constant: 5),
            nameLabel.topAnchor.constraintEqualToAnchor(artistLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraintEqualToAnchor(profileImage.trailingAnchor, constant: 5),
            durationLabel.topAnchor.constraintEqualToAnchor(nameLabel.bottomAnchor, constant: 5),
            durationLabel.leadingAnchor.constraintEqualToAnchor(profileImage.trailingAnchor, constant: 5),
        ]
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
