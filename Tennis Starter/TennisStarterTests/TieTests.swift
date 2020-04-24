//
//  Tietests.swift
//  TennisStarterTests
//
//  Created by Michael Laubscher on 29/02/2020.
//  Copyright © 2020 University of Chester. All rights reserved.
//

//
import XCTest

class TieTests: XCTestCase {
    
    var tie: TieBreak!
    var setMirror: Mirror!
    
    var set: Set!
    var mirror: Mirror!
    
    var tennis: TennisMain!
    var tennisMirror: Mirror!
    
    override func setUp() {
        super.setUp()
        tie = TieBreak()
        mirror = Mirror(reflecting: tie!)
        set = Set()
        setMirror = Mirror(reflecting: Set?.self)
        tennis = TennisMain()
        tennisMirror = Mirror(reflecting: TennisMain?.self)
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testTieCheck(){
        for _ in 0...5{
            set.addGameToPlayer1()
        }
        for _ in 0...5{
            set.addGameToPlayer2()
        }
        
        XCTAssertEqual(set.GamesWonForPlayer1(), 6, "P1 has won 6 games")
        XCTAssertEqual(set.GamesWonForPlayer2(), 6, "P2 has won 6 games")
    }
    func testTieP1WinCheck(){
        for _ in 0...6{
            tie.addPointToPlayer1()
        }
        for _ in 0...4{
            tie.addPointToPlayer2()
        }
        XCTAssertTrue(tie.complete(), "Tie complete with P1 wins after 7 points with a 2 point leed")
    }
    func testGamePointsForPlayer1(){
        for _ in 0...2{
            set.addGameToPlayer1()
        }
        XCTAssertEqual(set.GamesWonForPlayer1(), 3, "P1 has won 3 game")
        
    }
    func testGamePointsForPlayer2(){
        for _ in 0...2{
            set.addGameToPlayer2()
        }
        XCTAssertEqual(set.GamesWonForPlayer2(), 3, "P1 has won 3 game")
        
    }
    func testAddPointToPlayer1(){
        tie.addPointToPlayer1()
        XCTAssertEqual(tie.player1Score(), "1", "P1 has won 1 game")
        
    }
    
    func testAddPointToPlayer2(){
        tie.addPointToPlayer2()
        XCTAssertEqual(tie.player2Score(), "1", "P1 has won 1 game")
        
    }
    func testPlayer1Won(){
        for _ in 0...6{
            tie.addPointToPlayer1()
        }
        XCTAssertTrue(tie.player1Won(), "P1 has won game")
    }

    func testPlayer2Won(){
        for _ in 0...6{
            tie.addPointToPlayer2()
        }
        XCTAssertTrue(tie.player2Won(), "P2 has wongame")
    }
    func testPlayer2TieWon(){
        for _ in 0...7{
            tennis.TieInstance.addPointToPlayer2()
        }
        tennis.main(player: false)
       
        
        let result = tennis.gamesPlayed

        XCTAssertNotEqual(0, result)
    }
}

