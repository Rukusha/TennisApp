//
//  MatchTests.swift
//  TennisStarter
//
//  Created by Michael Laubscher on 25/02/2020.
//  Copyright © 2020 University of Chester. All rights reserved.
//
import XCTest

class MatchTests: XCTestCase {
    
    var match: Match!
    var mirror: Mirror!
    
    override func setUp() {
        super.setUp()
        match = Match()
        mirror = Mirror(reflecting: match!)

    }
    override func tearDown() {
        super.tearDown()
    }
    func test3SetComplete(){

        for _ in 0...6{
            match.addSetsToPlayer1()
        }
        for _ in 0...12{
            match.addSetsToPlayer2()
        }

        XCTAssertTrue(match.complete(), "Game complete with P2 wins after 3 sets with a 2 point leed")
    }
    func test4SetComplete(){

        for _ in 0...6{
            match.addSetsToPlayer1()
        }
        for _ in 0...18{
            match.addSetsToPlayer2()
        }
        XCTAssertTrue(match.complete(), "Game complete with P2 wins after 4 sets with a 2 point leed")
    }
    func test5SetComplete(){

        for _ in 0...12{
            match.addSetsToPlayer1()
        }

        for _ in 0...18{
            match.addSetsToPlayer2()
        }
        XCTAssertTrue(match.complete(), "Game complete with P2 wins after 5 sets with a 2 point leed")
    }
    func testSetTieCheck(){
        for _ in 0...4{
            match.addSetsToPlayer1()
            match.addSetsToPlayer2()

        }
        XCTAssertEqual(match.SetsWonForPlayer1(),5,"P1 score")
        XCTAssertEqual(match.SetsWonForPlayer2(),5,"P2 score")

    }
    func testSetTieP1Check(){
        testSetTieCheck()
        print(match.SetsWonForPlayer1())
        print(match.SetsWonForPlayer2())

        match.addSetsToPlayer1()

        XCTAssertTrue(match.complete(), "Game complete with P1 Wins")

    }
    func testSetTieP2Check(){
        testSetTieCheck()
        match.addSetsToPlayer2()

        XCTAssertTrue(match.complete(), "Game complete with P2 Wins")

    }
    func testSetsWonP1(){
        match.addSetsToPlayer1()

        XCTAssertEqual(match.SetsWonForPlayer1(),1,"P1 sets won")
    }
    func testSetsWonP2(){
        match.addSetsToPlayer2()

        XCTAssertEqual(match.SetsWonForPlayer2(),1,"P2 sets won")
    }

    func testPlayer1MatchWon2sets(){
         for _ in 0...2{
            match.addSetsToPlayer1()
        }
        match.addSetsToPlayer2()

        XCTAssertTrue(match.complete(), "P1 match won")

    }
    func testPlayer1MatchWon3sets(){
         for _ in 0...1{
            match.addSetsToPlayer1()
            match.addSetsToPlayer2()

        }
        print(match.SetsWonForPlayer1(), match.SetsWonForPlayer2())
        match.addSetsToPlayer1()

        XCTAssertTrue(match.complete(), "P1 match won")

    }
    func testPlayer2MatchWon(){
         for _ in 0...2{
            match.addSetsToPlayer2()
        }
        XCTAssertTrue(match.complete(), "P2 match won")
    }
    func testMatchEnd3_3(){
         for _ in 0...2{
            match.addSetsToPlayer1()
            match.addSetsToPlayer2()

        }
        XCTAssertFalse(match.complete(), "no win")

    }
}
