//
//  Shape.swift
//  ChessMaster
//
//  Created by Steven Wong on 24/10/2021.
//

import Foundation
import UIKit

enum Troop{
    case Pawn
    case Bishop
    case King
    case Queen
    case Knight
    case Rook
}

class Shape{
    var kind: Troop
    var color: Int // 0 = white, 1 = black
    var row:Int = 0
    var col:Int = 0
    var margin:CGFloat = 0.0
    var width:CGFloat = 0.0
    var image:UIImage?
    var on_board:Bool = true
    var board:BoardView
    
    required init(_ row: Int, _ col: Int, _ kind: Troop, _ color: Int, _ margin: CGFloat, _ width: CGFloat, _ board: BoardView) {
        self.row = row
        self.col = col
        self.kind = kind
        self.color = color
        self.margin = margin
        self.width = width
        let color_str:String = color != 0 ? "black" : "white"
        let name: String = "\(kind)-\(color_str)"
        self.image = UIImage(named: name)
        self.board = board
    }
    
    func draw() {
        let rec = CGRect(x: margin + CGFloat(col) * width, y: margin + CGFloat(row) * width, width: width, height: width)
        image?.draw(in: rec)
    }
    
    func move(_ i: Int, _ j: Int){
        self.row = i
        self.col = j
    }
}
