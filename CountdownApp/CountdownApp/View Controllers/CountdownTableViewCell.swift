//
//  CountdownTableViewCell.swift
//  CountdownApp
//
//  Created by Michael on 1/7/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class CountdownTableViewCell: UITableViewCell {

    @IBOutlet weak var countdownNameLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
      return formatter
    }()
    
    var dateComponentFormatter = DateComponentsFormatter()
        
    var dateString: String?
    
    var eventDate: Date? {
        didSet {
            updateViews()
        }
    }
    
    var countdown: Countdown? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let countdown = countdown else { return }
        dateComponentFormatter.unitsStyle = .full
        dateComponentFormatter.includesApproximationPhrase = false
        dateComponentFormatter.includesTimeRemainingPhrase = false
        
        guard let eventDate = eventDate else { return }
//        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: countdown.date, to: countdown.time)
        let eventTime = eventDate.timeIntervalSinceNow
        
        countdownNameLabel.text = "Until \(countdown.eventName)"
        
        switch eventTime {
        case 1...59:
            dateComponentFormatter.allowedUnits = [.second]
            countdownLabel.text = dateComponentFormatter.string(from: eventTime)
        case 60...3599:
            dateComponentFormatter.allowedUnits = [.second, .minute]
            countdownLabel.text = dateComponentFormatter.string(from: eventTime)
        case 3600...86399:
            dateComponentFormatter.allowedUnits = [.second, .minute, .hour]
            countdownLabel.text = dateComponentFormatter.string(from: eventTime)
        case 86400...2764799:
            dateComponentFormatter.allowedUnits = [.day, .month]
            countdownLabel.text = dateComponentFormatter.string(from: eventTime)
        case 2764800...33177599:
            dateComponentFormatter.allowedUnits = [.day, .month, .year]
            countdownLabel.text = dateComponentFormatter.string(from: eventTime)
        case 33177600...1990656000:
            dateComponentFormatter.allowedUnits = [.month, .year]
            countdownLabel.text = dateComponentFormatter.string(from: eventTime)
        default:
            dateComponentFormatter.allowedUnits = [.second, .minute, .hour, .day, .month, .year]
            countdownLabel.text = dateComponentFormatter.string(from: eventTime)
        }
    }
}

extension CountdownTableViewCell: CountdownDelegate {
    func countdownUpdate(time: TimeInterval) {
        updateViews()
    }
}
