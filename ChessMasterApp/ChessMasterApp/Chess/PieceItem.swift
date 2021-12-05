//
//  Cell.swift
//  ChessMaster
//
//  Created by Steven Wong on 24/10/2021.
//

import Foundation
import UIKit

protocol PieceItem: AnyObject{
    init(row: Int, col: Int)
    func draw()
    func contains(point: CGPoint) -> Bool
}
