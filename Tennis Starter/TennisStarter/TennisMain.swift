//
//  TennisMain.swift
//  TennisStarter
//
//  Created by Michael Laubscher on 29/02/2020.
//  Copyright © 2020 University of Chester. All rights reserved.
//

import AVFoundation

class TennisMain{
    
    var GameInstance = Game()
    var SetInstance = Set()
    var MatchInstance = Match()
    var TieInstance = TieBreak()
    
    var TieBreaker: Bool =  false
    var SetP1Score: String = ""
    var SetP2Score: String = ""
    var playerServe: Bool = true
    var gamesPlayed: Int = 0
    
    var toneSound: AVAudioPlayer?
    var speechString: String = "Test"
    
    var servedFirst = true
    
    var TieServeCount = 0
    var tieLock: Bool = false
    var reciever: Bool = true
    var setCheck: Int = 1
    var matchCompleted: Bool =  false
    
    let path = Bundle.main.path(forResource: "Sound.wav", ofType:nil)!
    var audioFailCheck = false
    
    func tonePlay(path: String){
        let url = URL(fileURLWithPath: path)
        
        do {
            toneSound = try AVAudioPlayer(contentsOf: url)
            toneSound?.prepareToPlay()
            toneSound?.play()

        } catch{
            audioFailCheck = true
        }
    }
    func textToSpeech() -> Bool{
        speechString = "New Ball Please"
        if ((gamesPlayed + 11) % 9 == 0) && gamesPlayed != 0 && gamesPlayed != 9 || gamesPlayed == 7{
            let speech = AVSpeechUtterance(string: speechString)
            speech.voice = AVSpeechSynthesisVoice(language: "en-US")
            
            let audio = AVSpeechSynthesizer()
            audio.speak(speech)
            return true
        }
        return false
    }
    func serveSwitch(){
        if playerServe == true{
            tonePlay(path: path)
            playerServe = false
        }else{
            tonePlay(path: path)
            playerServe = true
        }
    }
    func main(player: Bool){
        
        if MatchInstance.SetsWonForPlayer1() == 2 && MatchInstance.SetsWonForPlayer2() == 2{
            if SetInstance.GamesWonForPlayer1() == 12 && SetInstance.GamesWonForPlayer2() == 12{
                TieBreaker = true
                tie(player: player)
            }else{
                game(player: player)
            }
        }else{
            if SetInstance.GamesWonForPlayer1() == 6 && SetInstance.GamesWonForPlayer2() == 6{
                TieBreaker = true
                tie(player: player)
            }else{
                game(player: player)
            }
        }
        
        if TieInstance.complete() ==  true{
            textToSpeech() // returned value is used for unit tests
            if TieInstance.player1Won() == true{
                gamesPlayed += 1

                SetInstance.addGameToPlayer1()
            }
            
             if TieInstance.player2Won() == true{
                gamesPlayed += 1

                SetInstance.addGameToPlayer2()
            }
            
            SetP1Score += "\(SetInstance.GamesWonForPlayer1())"
            SetP2Score += "\(SetInstance.GamesWonForPlayer2())"
            
            match(player: player)
            TieInstance = TieBreak()
            SetInstance = Set()
            
            TieBreaker = false
            TieServeCount = 0
            serve()
        }
        if GameInstance.complete() ==  true{
            gamesPlayed += 1
            textToSpeech() // returned value is used for unit tests
            serve()
            set(player: player)
            GameInstance = Game()
            
            if SetInstance.complete() ==  true{
                match(player: player)
                SetP1Score += "\(SetInstance.GamesWonForPlayer1())"
                SetP2Score += "\(SetInstance.GamesWonForPlayer2())"
                SetInstance = Set()
                setCheck = MatchInstance.p1SetsWon + MatchInstance.p2SetsWon
                
                if setCheck % 2 == 0{
                    playerServe = true
                }else{
                    playerServe = false
                }
                servedFirst = false
            }
        }
        if MatchInstance.complete() == true{
            matchCompleted = true
        }else{
            matchCompleted = false
        }
    }
    func serve(){
        if !(MatchInstance.SetsWonForPlayer1() == 2 && MatchInstance.SetsWonForPlayer2() == 2){
            if !(SetInstance.GamesWonForPlayer1() == 12 && SetInstance.GamesWonForPlayer2() == 12){
                if !(SetInstance.GamesWonForPlayer1() == 6 && SetInstance.GamesWonForPlayer2() == 6){
                    serveSwitch()
                    tonePlay(path: path)
                }
            }
        }else{
            if !(SetInstance.GamesWonForPlayer1() == 12 && SetInstance.GamesWonForPlayer2() == 12){
                if !(SetInstance.GamesWonForPlayer1() == 6 && SetInstance.GamesWonForPlayer2() == 6){
                    serveSwitch()
                    tonePlay(path: path)
                }
            }
        }
    }
    
    func tie(player: Bool){
        if TieServeCount % 2 == 0 && TieServeCount != 0 || TieServeCount % 2 != 1{
            serveSwitch()
        }
        
        if TieServeCount == 0 {
            if tieLock == false{
                reciever = playerServe
                tieLock = true
            }
        }
        
        TieServeCount += 1
        
        if player == true{
            TieInstance.addPointToPlayer1()
        }else{
            TieInstance.addPointToPlayer2()
        }
    }
    func match(player: Bool){
        tonePlay(path: path)
        if player == true{
            MatchInstance.addSetsToPlayer1()
        }else{
            MatchInstance.addSetsToPlayer2()
        }
        
    }
    
    func set(player: Bool){
        if player == true{
            SetInstance.addGameToPlayer1()
        }else{
            SetInstance.addGameToPlayer2()
        }
    }
    func game(player: Bool){
        if player == true{
            GameInstance.addPointToPlayer1()
        }else{
            GameInstance.addPointToPlayer2()
        }
    }
}
