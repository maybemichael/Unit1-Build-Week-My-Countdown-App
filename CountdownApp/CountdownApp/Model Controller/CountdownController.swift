//
//  CountdownController.swift
//  CountdownApp
//
//  Created by Michael on 1/5/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

class CountdownController {
    
    var countdowns: [Countdown] = []
    
    weak var delegate: CountdownDelegate?
    
    var timer: Timer?
    
    var eventDate: Date?
    
    var eventTime: TimeInterval = 0
    
    var remainingTimeInterval: TimeInterval {
        var timeRemaining: TimeInterval = 0
        if let eventDate = eventDate {
            timeRemaining = eventDate.timeIntervalSinceNow
        }
        return timeRemaining
    }
    
    func getEventDate(date: Date, time: Date) -> Date {
        var mergedComponents = DateComponents()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
        let timeComponents = calendar.dateComponents([.second, .minute, .hour], from: time)

        mergedComponents.second = timeComponents.second
        mergedComponents.minute = timeComponents.minute
        mergedComponents.hour = timeComponents.hour
        mergedComponents.day = dateComponents.day
        mergedComponents.month = dateComponents.month
        mergedComponents.year = dateComponents.year

        guard let updatedEventDate = calendar.date(from: mergedComponents) else { return date }
        return updatedEventDate
    }
    
    func createCountdown(name: String, date: Date, time: Date) {
        let countdown = Countdown(eventName: name, date: date, time: time)
        countdowns.append(countdown)
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateTimer(timer:))
//        print("How many timers are there?")
        saveToPersistentStore()
    }
    
    func deleteCountdown(countdown: Countdown) {
        guard let countdownToRemove = countdowns.firstIndex(of: countdown) else { return }
        countdowns.remove(at: countdownToRemove)
//        timer?.invalidate()
        
        saveToPersistentStore()
    }
    
    var countdownURL: URL? {
        let fileManager = FileManager.default
        
        guard let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let countdownsURL = documentDir.appendingPathComponent("Countdowns.plist")
        
        return countdownsURL
    }
    
    func saveToPersistentStore() {
        guard let countdownsURL = countdownURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            
            let countdownsData = try encoder.encode(countdowns)
            
            try countdownsData.write(to: countdownsURL)
        } catch {
            print("Error saving data: \(error).")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let countdownsURL = countdownURL else { return }
            
            let countdownsData = try Data(contentsOf: countdownsURL)
            
            let decoder = PropertyListDecoder()
            
            let countdownsArray = try decoder.decode([Countdown].self, from: countdownsData)
            
            self.countdowns = countdownsArray
        } catch {
            print("Error loading data from plist: \(error).")
        }
    }
}
