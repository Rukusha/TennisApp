//
//  Match.swift
//  TennisStarter
//
//  Created by Michael Laubscher on 25/02/2020.
//  Copyright © 2020 University of Chester. All rights reserved.
//

class Match{
    var p1SetsWon : Int = 0
    var p2SetsWon : Int = 0
    
    var winner: String = ""
    
    func greenMatchP1() -> Bool{
        if SetsWonForPlayer1() > SetsWonForPlayer2() && SetsWonForPlayer1() >= 2{
           return true
        }else if SetsWonForPlayer1() == SetsWonForPlayer2() {
           return false
        }
        return false
    }
    func greenMatchP2() -> Bool{
        if SetsWonForPlayer2() > SetsWonForPlayer1() && SetsWonForPlayer2() >= 2{
           return true
        }else if SetsWonForPlayer1() == SetsWonForPlayer2() {
           return false
        }
        return false
    }
    
    func SetsWonForPlayer1() -> Int{
        return p1SetsWon
    }
    func SetsWonForPlayer2() -> Int {
        return p2SetsWon
    }
    func addSetsToPlayer1(){
        p1SetsWon += 1
    }
    func addSetsToPlayer2(){
        p2SetsWon += 1
    }
    
    func player1MatchWon() -> Bool{
        if ((p1SetsWon >= 2 && p2SetsWon >= 2) && (p1SetsWon > p2SetsWon)){
            return true
        }
        else if p1SetsWon >= 3 && p1SetsWon >= p2SetsWon + 2{
            return true
        }
        return false
    }
    
    func player2MatchWon() -> Bool{
        if ((p1SetsWon >= 2 && p2SetsWon >= 2) && (p1SetsWon < p2SetsWon)){
            return true
        }
        else if p2SetsWon >= 3 && p2SetsWon >= p1SetsWon + 2{
            return true
        }
        return false
    }
    
    func complete() ->Bool {
        
        if ((player1MatchWon() == true) || (player2MatchWon() == true)){
            if p1SetsWon > p2SetsWon{
                winner = "1"
            }else{
                winner = "2"
            }
            
            return true
        }
        return false
    }
}
