//
//  Settings.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/24.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import Foundation

class Settings {
    static let sharedInstance = Settings()
    
    private let defaults = UserDefaults.standard
    private let keyFirstRun = "First Run"
    private let keyBestScore = "Best Score"
    
    // MARK: - Init
    init() {
        if defaults.object(forKey: keyFirstRun) == nil {
            firstLaunch()
        }
    }
 
    private func firstLaunch()  {
        defaults.set(0, forKey: keyBestScore)
        defaults.set(false, forKey: keyFirstRun)
        
        defaults.synchronize()
    }
    
    
    // MARK: - Public saving methods
    func saveBest(score: Int)  {
        defaults.set(score, forKey: keyBestScore)
        
        defaults.synchronize()
    }
    
    
    
    // MARK: - Public retrieving methods
    func getScore() -> Int {
        return defaults.integer(forKey: keyBestScore)
    }
    
    
    
    
    
}
