//
//  SetTests.swift
//  TennisStarter
//
//  Created by Michael Laubscher on 15/02/2020.
//  Copyright © 2020 University of Chester. All rights reserved.
//
import XCTest

class SetTests: XCTestCase {
    var tennis: TennisMain!
    var tennisMirror: Mirror!
    var set: Set!
    var mirror: Mirror!
    var match: Match!
    var matchMirror: Mirror!
        
    override func setUp() {
        super.setUp()
        set = Set()
        mirror = Mirror(reflecting: Set?.self)
        
        tennis = TennisMain()
        tennisMirror = Mirror(reflecting: TennisMain?.self)
        
        match = Match()
        matchMirror = Mirror(reflecting: Match?.self)
    }
        
    override func tearDown() {
        super.tearDown()
    }
    
    func testZeroGamesPoints(){
        XCTAssertEqual(set.GamesWonForPlayer1(), 0, "P1 set score correct with 0 points")
        XCTAssertEqual(set.GamesWonForPlayer2(), 0, "P2 set score correct with 0 points")
    }

    func testGamesWonForPlayers() {
        set.addGameToPlayer1()
        set.addGameToPlayer2()
        XCTAssertEqual(set.GamesWonForPlayer1(), 1, "P1 has won 1 sets")
        XCTAssertEqual(set.GamesWonForPlayer2(), 1, "P2 has won 1 sets")
    }
    func testSetCompleteP1Win(){
        for _ in 0...6{
            set.addGameToPlayer1()
        }
        XCTAssertTrue(set.complete(), "Game complete with P1 win")
    }
    func testSetCompleteP2Win(){
        for _ in 0...6{
            set.addGameToPlayer2()
        }
        XCTAssertTrue(set.complete(), "Game complete with P2 win")
    }
    func testSetCompletePlus2(){
        for _ in 0...6{
            set.addGameToPlayer1()
        }
        for _ in 0...4{
            set.addGameToPlayer2()
        }
        XCTAssertTrue(set.complete(), "Game complete with P1 win with a 2 point leed")
    }

    func testSetCompleteSetP1Score(){
        let preCheck = "\(tennis.setP1Score)"
        for _ in 0...6{
            tennis.GameInstance.addPointToPlayer1()
        }
        for _ in 0...6{
            tennis.SetInstance.addGameToPlayer1()
        }
        tennis.main(player: true)
        let check = "\(tennis.setP1Score)"

        XCTAssertNotEqual(check, preCheck)
    }
    func testSetCheck(){
        var playerServe = true
        for _ in 0...6{
            tennis.GameInstance.addPointToPlayer1()
        }
        for _ in 0...6{
            tennis.SetInstance.addGameToPlayer1()
        }
        tennis.main(player: true)
        let setCheck = tennis.setsPlayedCheck
        if setCheck % 2 == 0{
            playerServe = true
        }else{
            playerServe = false
        }
        print(setCheck)
        XCTAssertFalse(playerServe)
    }
    func testSetCheck2Sets(){
        var playerServe = false

        testSetCheck()

        for _ in 0...6{
            tennis.GameInstance.addPointToPlayer1()
        }
        for _ in 0...6{
            tennis.SetInstance.addGameToPlayer1()
        }
        tennis.main(player: true)
        let setCheck = tennis.setsPlayedCheck
        if setCheck % 2 == 0{
            playerServe = true
        }else{
            playerServe = false
        }
        XCTAssertTrue(playerServe)
    }
    func testSetGreenP1() {
        
        for _ in 1...5{
            set.addGameToPlayer1()
        }
        print(set.GamesWonForPlayer1())
        XCTAssertTrue(set.greenGamesP1(), "P1 has green indicator")
    }
    func testSetGreenP2() {
        
        for _ in 1...5{
             set.addGameToPlayer2()
        }
        XCTAssertTrue(set.greenGamesP2(), "P2 has green indicator")
    }
    func testSetGreenP1False() {
        
        for _ in 1...4{
            set.addGameToPlayer1()
        }
        print(set.GamesWonForPlayer1())
        XCTAssertFalse(set.greenGamesP1(), "P1 has green indicator")
    }
    func testSetGreenP2False() {
        
        for _ in 1...4{
             set.addGameToPlayer2()
        }
        XCTAssertFalse(set.greenGamesP2(), "P2 has green indicator")
    }
    func testSetGreen66False() {
        
        for _ in 1...6{
            set.addGameToPlayer1()
            set.addGameToPlayer2()
        }
        XCTAssertFalse(set.greenGamesP1(), "P1 has no green indicator")
        XCTAssertFalse(set.greenGamesP2(), "P2 has no green indicator")
    }
    func testSetGreen12allTrue() {
        
        for _ in 1...12{
            set.addGameToPlayer1()
            set.addGameToPlayer2()
        }
        XCTAssertTrue(set.greenGamesP1(), "P1 has a green indicator")
        XCTAssertTrue(set.greenGamesP2(), "P2 has a green indicator")
    }

}
