//
//  Set.swift
//  TennisStarter
//
//  Created by Michael Laubscher on 15/02/2020.
//  Copyright © 2020 University of Chester. All rights reserved.
//

class Set {
    var p1GamesWon: Int = 0
    var p2GamesWon: Int = 0
    
    func GamesWonForPlayer1() -> Int{
        return p1GamesWon
    }
    func GamesWonForPlayer2() -> Int {
        return p2GamesWon
    }
    func addGameToPlayer1(){
        p1GamesWon += 1
    }
    func addGameToPlayer2(){
        p2GamesWon += 1
    }
    func player1SetWon() -> Bool{

        if p1GamesWon >= 6 && p1GamesWon >= p2GamesWon + 2{
            return true
        }
        return false

    }


    func player2SetWon() -> Bool{
        if p2GamesWon >= 6 && p2GamesWon >= p1GamesWon + 2{
            return true
        }
        return false
    }
    func complete() ->Bool {
        if  player1SetWon() == true || player2SetWon() == true{
            return true
        }
        return false
    }
}


