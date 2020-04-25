//
//  TennisTests.swift
//  TennisStarterTests
//
//  Created by Michael Laubscher on 06/03/2020.
//  Copyright © 2020 University of Chester. All rights reserved.
//

import XCTest

class TennisTests: XCTestCase {
    
    var tennis: TennisMain!
    var mirror: Mirror!
    
    var game: Game!
    var gameMirror: Mirror!
    
    var set: Set!
    var setMirror: Mirror!
    
    var match: Match!
    var matchMirror: Mirror!
    let path = Bundle.main.path(forResource: "Sound.wav", ofType:nil)!

    override func setUp() {
        super.setUp()
        tennis = TennisMain()
        mirror = Mirror(reflecting: tennis!)
        match = Match()
        matchMirror = Mirror(reflecting: match!)
        set = Set()
        setMirror = Mirror(reflecting: set!)
        game = Game()
        gameMirror = Mirror(reflecting: game!)

    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testTone(){

        tennis.tonePlay(path: path)
        XCTAssertTrue((tennis.toneSound != nil), "Tone has played")
    }
    func testToneNoThrow(){
         XCTAssertNoThrow( tennis.tonePlay(path: path), "Tone has played")
     }
 
    func testTextToSpeach(){
        let speach = tennis.speachString
        tennis.textToSpeech()
        XCTAssertNotEqual(speach, tennis.speachString)
    }
    func testTextToSpeach7Games(){
        for _ in 1...7{
            tennis.gamesPlayed += 1
        }
        print(tennis.gamesPlayed)
        let result = tennis.textToSpeech()
        XCTAssertTrue(result)
    }
    func testTextToSpeach16Games(){
        for _ in 1...16{
            tennis.gamesPlayed += 1
        }
        print(tennis.gamesPlayed)
        let result = tennis.textToSpeech()
        XCTAssertTrue(result)
    }
    func testTextToSpeach25Games(){
        for _ in 1...25{
            tennis.gamesPlayed += 1
        }
        print(tennis.gamesPlayed)
        let result = tennis.textToSpeech()
        XCTAssertTrue(result)
    }
    func testServeSwitch(){
        let serve = tennis.playerServe
        tennis.serveSwitch()
        XCTAssertNotEqual(serve, tennis.playerServe)
        tennis.serveSwitch()
        XCTAssertEqual(serve, tennis.playerServe)
        
    }
    
    func testTieLock(){
        let TieServe = tennis.tieServeCount
        tennis.tie(player: true)
        XCTAssertNotEqual(TieServe, tennis.tieServeCount)
    }

    func testServe(){
        tennis.serve()
        XCTAssertTrue((tennis.toneSound != nil), "Tone has played")
        
    }
    func testServe6GamesAll(){
        for _ in 0...6{
            tennis.SetInstance.addGameToPlayer1()
            tennis.SetInstance.addGameToPlayer2()
        }
        print(tennis.SetInstance.GamesWonForPlayer1(), tennis.SetInstance.GamesWonForPlayer2())
        tennis.serve()
        XCTAssertFalse((tennis.toneSound == nil), "Tone has not played")
        
    }
    func testServe6GamesP1(){
        for _ in 0...6{
            tennis.SetInstance.addGameToPlayer1()
        }
        tennis.SetInstance.addGameToPlayer2()

        print(tennis.SetInstance.GamesWonForPlayer1(), tennis.SetInstance.GamesWonForPlayer2())
        tennis.serve()
        XCTAssertTrue((tennis.toneSound != nil), "Tone has played")
    }
    func testServe2SetsAll(){
        for _ in 0...2{
            tennis.MatchInstance.addSetsToPlayer1()
            tennis.MatchInstance.addSetsToPlayer2()
        }

        print(tennis.SetInstance.GamesWonForPlayer1(), tennis.SetInstance.GamesWonForPlayer2())
        tennis.serve()
        XCTAssertTrue((tennis.toneSound != nil), "Tone has played")
        
    }
    func testServeGames6(){
        for _ in 1...6{
             tennis.SetInstance.addGameToPlayer1()
             tennis.SetInstance.addGameToPlayer2()
        }

        print(tennis.SetInstance.GamesWonForPlayer1(), tennis.SetInstance.GamesWonForPlayer2())
        tennis.serve()
        XCTAssertTrue((tennis.toneSound == nil), "Tone has not played")
        
    }
    func testGame(){
        tennis.game(player: true)
        for _ in 1...3{
            game.addPointToPlayer1()
        }
        let setCheck = game.p1Score
        XCTAssertEqual(3, setCheck)
        
    }
    func testSet(){
        tennis.set(player: true)
        for _ in 1...3{
            set.addGameToPlayer1()
        }
        let setCheck = set.GamesWonForPlayer1()
        XCTAssertEqual(3, setCheck)
    }
    func testMatch(){
        tennis.match(player: true)
        for _ in 1...3{
            match.addSetsToPlayer1()
        }
        let setCheck = match.p1SetsWon
        XCTAssertEqual(3, setCheck)
    }
    func testMainP1(){
        var Check = tennis.matchCompleted
        for _ in 1...7{
            tennis.match(player: true)
        }
        tennis.main(player: true)
        Check = tennis.matchCompleted
        XCTAssertTrue(Check)
    }
    func testMainP2(){
        var Check = tennis.matchCompleted
        for _ in 1...7{
            tennis.match(player: false)
        }
        tennis.main(player: false)
        Check = tennis.matchCompleted
        XCTAssertTrue(Check)
    }
    func testMainGameinstanceP1(){
        var Check = tennis.gamesPlayed
        for _ in 1...5{
            tennis.game(player: true)
        }
        tennis.main(player: true)
        Check = tennis.gamesPlayed
        XCTAssertEqual(1, Check)
    }
    func testMainGameinstanceP2(){
        var Check = tennis.gamesPlayed
        for _ in 1...5{
            tennis.game(player: false)
        }
        tennis.main(player: false)
        Check = tennis.gamesPlayed
        XCTAssertEqual(1, Check)
    }
    func testMainTieP1(){
        var Check = tennis.gamesPlayed
        for _ in 1...7{
            tennis.tie(player: true)
        }
        tennis.main(player: true)
        Check = tennis.gamesPlayed
        XCTAssertEqual(1, Check)
    }
    func testMain2Sets1GameP11(){
        let result = tennis.gamesPlayed
        for _ in 1...2{
            tennis.MatchInstance.addSetsToPlayer1()
        }
        tennis.serve()
        let Check = tennis.MatchInstance.p1SetsWon
        XCTAssertNotEqual(result, Check)
    }
    
    func testMain2Sets1GameP1(){
        tennis.MatchInstance.addSetsToPlayer2()
        for _ in 1...12{
            tennis.SetInstance.addGameToPlayer1()
            tennis.SetInstance.addGameToPlayer2()
        }
        tennis.serve()
        let Check = tennis.playerServe

        XCTAssertTrue(Check)
    }
    func testMain2Sets1GameP2(){
        for _ in 1...2{
            tennis.MatchInstance.addSetsToPlayer2()
        }
        for _ in 1...2{
            tennis.SetInstance.addGameToPlayer2()
        }
        tennis.serveSwitch()
        let Check = tennis.playerServe

        XCTAssertFalse(Check)
    }
    func testMain2Sets126Game(){
        for _ in 0...1{
            tennis.MatchInstance.addSetsToPlayer1()

        tennis.MatchInstance.addSetsToPlayer2()
        }
        for _ in 1...6{
            tennis.SetInstance.addGameToPlayer1()
            tennis.SetInstance.addGameToPlayer2()
        }
        tennis.serve()
        let Check = tennis.playerServe
        print(tennis.MatchInstance.p2SetsWon,tennis.SetInstance.GamesWonForPlayer2())
        
        XCTAssertTrue(Check)
    }
    func testMain2Sets126GameCheckServeswitch(){
        let check = tennis.playerServe
        for _ in 0...1{
            tennis.MatchInstance.addSetsToPlayer1()

        tennis.MatchInstance.addSetsToPlayer2()
        }
        for _ in 1...5{
            tennis.SetInstance.addGameToPlayer1()
            tennis.SetInstance.addGameToPlayer2()
        }
        tennis.serve()
        let result = tennis.playerServe
        print(tennis.MatchInstance.p2SetsWon,tennis.SetInstance.GamesWonForPlayer2())
        
        XCTAssertNotEqual(check, result)
    }
    func testMain2Sets12Game(){
        for _ in 0...1{
            tennis.MatchInstance.addSetsToPlayer1()

        tennis.MatchInstance.addSetsToPlayer2()
        }
        for _ in 1...12{
            tennis.SetInstance.addGameToPlayer1()
            tennis.SetInstance.addGameToPlayer2()
        }
        tennis.serve()
        let Check = tennis.playerServe

        XCTAssertTrue(Check)
    }
    func testMain1Sets6Game(){
            tennis.MatchInstance.addSetsToPlayer1()
            tennis.MatchInstance.addSetsToPlayer2()
        for _ in 0...5{
            tennis.SetInstance.addGameToPlayer1()
            tennis.SetInstance.addGameToPlayer2()
        }

        tennis.main(player: true)
        let result = tennis.TieBreaker
        XCTAssertTrue(result)
    }
    func testMain2Sets6Game(){
        for _ in 0...1{
            tennis.MatchInstance.addSetsToPlayer1()
            tennis.MatchInstance.addSetsToPlayer2()        }
        for _ in 0...5{
            tennis.SetInstance.addGameToPlayer1()
            tennis.SetInstance.addGameToPlayer2()
        }

        tennis.main(player: true)
        let result = tennis.TieBreaker
        XCTAssertFalse(result)
    }
    func testMainSet2All12GamesAll(){
        for _ in 0...1{
            tennis.MatchInstance.addSetsToPlayer1()
            tennis.MatchInstance.addSetsToPlayer2()        }
        for _ in 0...11{
            tennis.SetInstance.addGameToPlayer1()
            tennis.SetInstance.addGameToPlayer2()
        }

        tennis.main(player: true)
        let result = tennis.TieBreaker
        XCTAssertTrue(result)
    }
    func testMainTiePlayer2(){
        tennis.tie(player: false)
        
        let check = tennis.TieInstance.gamePointsForPlayer2()

        XCTAssertEqual(1, check)
    }
    func testMainToneFailed(){
        let pathFail = "fail"
        tennis.tonePlay(path: pathFail)
        let check = tennis.audioFailCheck


        XCTAssertTrue(check)
    }
}

