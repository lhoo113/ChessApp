//
//  ViewController.swift
//  ChessMaster
//
//  Created by Steven Wong on 24/10/2021.
//

import UIKit
import SwiftChess

class ChessViewController: UIViewController, GameDelegate {

    @IBOutlet weak var board: BoardView!
    let game = Game(firstPlayer: Human(color: .white), secondPlayer: AIPlayer(color: .black, configuration: AIConfiguration(difficulty: .easy)))
    var margin:CGFloat = 10.0
    var wid:CGFloat = 39.375
    var current = (0, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        board.backgroundColor = UIColor.black
//        view.addSubview(board)
        init_board()
        game.delegate = self
    }
    
    func init_board(){
        board.items = []
        for i in 0...7{
            board.items.append(Shape(1, i, .Pawn, 1, margin, wid, board))
            board.items.append(Shape(6, i, .Pawn, 0, margin, wid, board))
        }
        for i in 0...1{ // code reuse
            let a = i == 0 ? 0 : 7 // line index
            let b = 1 - i // color
            board.items.append(Shape(a, 0, .Rook, b, margin, wid, board))
            board.items.append(Shape(a, 1, .Knight, b, margin, wid, board))
            board.items.append(Shape(a, 2, .Bishop, b, margin, wid, board))
            board.items.append(Shape(a, 3, .Queen, b, margin, wid, board))
            board.items.append(Shape(a, 4, .King, b, margin, wid, board))
            board.items.append(Shape(a, 5, .Bishop, b, margin, wid, board))
            board.items.append(Shape(a, 6, .Knight, b, margin, wid, board))
            board.items.append(Shape(a, 7, .Rook, b, margin, wid, board))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: board) as CGPoint
        current.0 = Int((touchPoint.x - margin) / wid)
        current.1 = 7 - Int((touchPoint.y - margin) / wid)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: board) as CGPoint
        let i = Int((touchPoint.x - margin) / wid)
        let j = 7 - Int((touchPoint.y - margin) / wid)
        if let player = game.currentPlayer as? Human {
            let start = BoardLocation(x: current.0, y: current.1)
            let end = BoardLocation(x: i, y: j)
            do {
                try player.movePiece(from: start, to: end)
            } catch {
                print(error)
            }
        }
        if let player = game.currentPlayer as? AIPlayer {
            player.makeMoveAsync()
        }
    }
    
    func gameDidChangeCurrentPlayer(game: Game) {
        return
    }
    
    func gameWonByPlayer(game: Game, player: Player) {
        return
    }
    
    func gameEndedInStaleMate(game: Game) {
        return
    }
    
    func gameWillBeginUpdates(game: Game) {
        return
    }
    
    func gameDidAddPiece(game: Game) {
        return
    }
    
    func gameDidRemovePiece(game: Game, piece: Piece, location: BoardLocation) {
        let c = piece.color == .white ? 0 : 1
        board.hidePiece(x: location.x, y: location.y, color: c)
    }
    
    func gameDidMovePiece(game: Game, piece: Piece, toLocation: BoardLocation) {
        board.movePiece(startX: piece.location.x, startY: piece.location.y, endX: toLocation.x, endY: toLocation.y)
    }
    
    func gameDidTransformPiece(game: Game, piece: Piece, location: BoardLocation) {
        return
    }
    
    func gameDidEndUpdates(game: Game) {
        return
    }
    
    func promotedTypeForPawn(location: BoardLocation, player: Human, possiblePromotions: [Piece.PieceType], callback: @escaping (Piece.PieceType) -> Void) {
        return
    }

}

