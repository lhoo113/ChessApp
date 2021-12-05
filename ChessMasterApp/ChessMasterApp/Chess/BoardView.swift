//
//  BoardView.swift
//  ChessMaster
//
//  Created by Steven Wong on 24/10/2021.
//

// Chess piece pictures are from https://github.com/zhijunsheng/chess-swiftui-ios/tree/main/Chess/Chess/Assets.xcassets

import UIKit
var margin:CGFloat = 10.0
var wid:CGFloat = 39.375

final class BoardView: UIView {
    var items:[Shape] = []{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        for i in 0...7{
            for j in 0...7{
                drawcell(i, j)
            }
        }
        
        for item in items{
            if item.on_board{
                item.draw()
            }
        }
    }
    func drawcell(_ i: Int, _ j: Int){
        // we add a constrain in storyboard to make the boardview's height = width
//        margin = 10.0
//        wid = (bounds.width - 2 * margin) / 8
        let rec = CGRect(x: margin + CGFloat(j) * wid, y: margin + CGFloat(i) * wid, width: wid, height: wid)
        let path = UIBezierPath(rect: rec)
        let color = ((i + j) % 2 == 0) ? UIColor.white : UIColor.lightGray
        color.setFill()
        path.fill()
    }

    var i:Int = 0
    var j:Int = 0
    var start:Shape?
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touchPoint = (touches.first)!.location(in: self) as CGPoint
//        j = Int((touchPoint.x - margin) / wid)
//        i = Int((touchPoint.y - margin) / wid)
//        start = itemAtLocation(i, j)
//    }
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        return
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touchPoint = (touches.first)!.location(in: self) as CGPoint
//        j = Int((touchPoint.x - margin) / wid)
//        i = Int((touchPoint.y - margin) / wid)
//        if start != nil && start!.on_board{
////            print("next step")
//            start?.move(i, j)
//            setNeedsDisplay()
//        }
//    }
    func itemAtLocation(_ i: Int, _ j: Int) -> [Shape] {
        var found: [Shape] = []
        for piece in items {
            if piece.on_board && piece.row == i && piece.col == j {
                found.append(piece)
            }
        }
//        return items.last {$0.on_board && $0.row == i && $0.col == j}
        return found
    }
    
    func movePiece(startX: Int, startY: Int, endX: Int, endY: Int) {
        guard itemAtLocation(7 - startY, startX).count == 1 else {
            print("More than 1 chess piece at the same place!")
            return
        }
        let start = itemAtLocation(7 - startY, startX).first
        start?.move(7 - endY, endX)
        setNeedsDisplay()
    }
    
    func hidePiece(x: Int, y: Int, color: Int) {
        itemAtLocation(7 - y, x).first {$0.color == color}?.on_board = false
    }
}

