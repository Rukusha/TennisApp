//
//  TieBreak.swift
//  TennisStarter
//
//  Created by Michael Laubscher on 28/02/2020.
//  Copyright © 2020 University of Chester. All rights reserved.
//

class TieBreak {
    var p1Score: Int
    var p2Score: Int
    
    init(){
        p1Score = 0
        p2Score = 0
    }
    
    func gamePointsForPlayer1() -> Int{
        return p1Score
    }
    func gamePointsForPlayer2() -> Int {
        return p2Score
    }
    func player1Score() -> String {
        return "\(gamePointsForPlayer1())"
    }
    func player2Score() -> String {
        return "\(gamePointsForPlayer2())"
    }
    
    func addPointToPlayer1(){
        p1Score += 1
    }
    
    func addPointToPlayer2(){
        p2Score += 1
    }
    func player1Won() -> Bool{
        if p1Score >= 7 && p1Score  >= p2Score + 2{
            return true
        }
        return false
    }
    
    func player2Won() -> Bool{
        if p2Score >= 7 && p2Score >= p1Score + 2{
            return true
        }
        return false
    }
    
    func complete() ->Bool {
        if player1Won() == true || player2Won() == true{
            
            return true
        }
        return false
    }
}
