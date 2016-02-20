//
//  Team.swift
//  scout-viewer-2015-iOS
//
//  Created by Samuel Resendez on 1/23/16.
//  Copyright © 2016 Citrus Circuits. All rights reserved.
//

import UIKit

@objc class Team: NSObject {
    
    var TeamInMatchDatas = [TeamInMatchData]()
    var name = String?()
    var number = NSNumber?()
    var calculatedData = CalculatedTeamData?()
    var pitBumperHeight = NSNumber?()
    var pitDriveBaseLength = NSNumber?()
    var pitDriveBaseWidth = NSNumber?()
    var pitLowBarCapability = Bool?()
    var pitNotes = String?()
    var pitNumberOfWheels = NSNumber?()
    var pitOrganization = NSNumber?()
    var pitPotentialLowBarCapability = NSNumber?()
    var pitPotentialMidlineBallCapability = NSNumber?()
    var pitPotentialShotBlockerCapability = NSNumber?()
    var selectedImageUrl = String?()

}
