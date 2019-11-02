//
//  Math.swift
//  FlappyBird
//
//  Created by 邓康大 on 2017/6/23.
//  Copyright © 2017年 邓康大. All rights reserved.
//

import SpriteKit


func RandomIntegerBetween(min: Int, max: Int) -> Int {
    return Int(UInt32(min) + arc4random_uniform(UInt32(max - min + 1)))
}

func RandomFloatBetween(min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
}
