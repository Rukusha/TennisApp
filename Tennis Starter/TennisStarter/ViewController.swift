import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var p1Button: UIButton!
    @IBOutlet weak var p2Button: UIButton!
    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p2NameLabel: UILabel!
    
    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!
    
    @IBOutlet weak var p1GamesLabel: UILabel!
    @IBOutlet weak var p2GamesLabel: UILabel!
    
    @IBOutlet weak var p1SetsLabel: UILabel!
    @IBOutlet weak var p2SetsLabel: UILabel!
    
    @IBOutlet weak var p1PreviousSetsLabel: UILabel!
    @IBOutlet weak var p2PreviousSetsLabel: UILabel!
    
    
    var player :Bool = true
    var TennisInstance = TennisMain()
    /********Methods*********/
    
    func serverIndicator(){
        if TennisInstance.playerServe == true{
            p1NameLabel.backgroundColor = UIColor.purple
            p2NameLabel.backgroundColor = UIColor.white
        }else{
            p2NameLabel.backgroundColor = UIColor.purple
            p1NameLabel.backgroundColor = UIColor.white
        }
    }
    func greenIndicator(){
//        Points green check ----------------------------------------------------------------------------------------------
        if TennisInstance.GameInstance.greenPointsP1() == true || TennisInstance.TieInstance.greenTieP1() == true{
            p1PointsLabel.backgroundColor = UIColor.green
        }else{
            p1PointsLabel.backgroundColor = UIColor.white
        }
        if TennisInstance.GameInstance.greenPointsP2() == true || TennisInstance.TieInstance.greenTieP2() == true{
            p2PointsLabel.backgroundColor = UIColor.green
        }else{
            p2PointsLabel.backgroundColor = UIColor.white
        }
//        Games green check ----------------------------------------------------------------------------------------------
        if (TennisInstance.SetInstance.greenGamesP1() == true && (TennisInstance.GameInstance.greenPointsP1() == true || TennisInstance.TieInstance.greenTieP1() == true)){
            p1GamesLabel.backgroundColor = UIColor.green
        }
        else if (TennisInstance.SetInstance.greenGamesP1() == true && TennisInstance.TieInstance.greenTieP1() == false){
            p1GamesLabel.backgroundColor = UIColor.white
        }
        else if (TennisInstance.SetInstance.greenGamesP1() == false && (TennisInstance.GameInstance.greenPointsP1() == false || TennisInstance.TieInstance.greenTieP1() == false)){
            p1GamesLabel.backgroundColor = UIColor.white
        }
        if (TennisInstance.SetInstance.greenGamesP2() == true && (TennisInstance.GameInstance.greenPointsP2() == true || TennisInstance.TieInstance.greenTieP2() == true)){
            p2GamesLabel.backgroundColor = UIColor.green
        }
        else if (TennisInstance.SetInstance.greenGamesP2() == true && TennisInstance.TieInstance.greenTieP2() == false){
                p2GamesLabel.backgroundColor = UIColor.white
            }
        else if (TennisInstance.SetInstance.greenGamesP2() == false && (TennisInstance.GameInstance.greenPointsP2() == false || TennisInstance.TieInstance.greenTieP2() == false)){
            p2GamesLabel.backgroundColor = UIColor.white
        }
//        Sets green check ----------------------------------------------------------------------------------------------
        if (TennisInstance.MatchInstance.greenMatchP1() == true && TennisInstance.SetInstance.greenGamesP1() == true && (TennisInstance.GameInstance.greenPointsP1() == true || TennisInstance.TieInstance.greenTieP1() == true)){
            p1SetsLabel.backgroundColor = UIColor.green
        }
        else if (TennisInstance.MatchInstance.greenMatchP1() == false && TennisInstance.SetInstance.greenGamesP1() == true && (TennisInstance.GameInstance.greenPointsP1() == true || TennisInstance.TieInstance.greenTieP1() == true)){
            p1SetsLabel.backgroundColor = UIColor.white
        }
        else if (TennisInstance.MatchInstance.greenMatchP1() == true && TennisInstance.SetInstance.greenGamesP1() == true && (TennisInstance.GameInstance.greenPointsP1() == false || TennisInstance.TieInstance.greenTieP1() == false)){
            p1SetsLabel.backgroundColor = UIColor.white
        }

        if (TennisInstance.MatchInstance.greenMatchP2() == true && TennisInstance.SetInstance.greenGamesP2() == true && (TennisInstance.GameInstance.greenPointsP2() == true || TennisInstance.TieInstance.greenTieP2() == true)){
            p2SetsLabel.backgroundColor = UIColor.green
        }
        else if (TennisInstance.MatchInstance.greenMatchP2() == false && TennisInstance.SetInstance.greenGamesP2() == true && (TennisInstance.GameInstance.greenPointsP2() == true || TennisInstance.TieInstance.greenTieP2() == true)){
            p2SetsLabel.backgroundColor = UIColor.white
        }
        else if (TennisInstance.MatchInstance.greenMatchP2() == true && TennisInstance.SetInstance.greenGamesP2() == true && (TennisInstance.GameInstance.greenPointsP2() == false || TennisInstance.TieInstance.greenTieP2() == false)){
            p2SetsLabel.backgroundColor = UIColor.white
        }


    }
    func MatchFinished(){
        if TennisInstance.MatchInstance.complete() == true{
            p1Button.isEnabled = false
            p2Button.isEnabled = false
            p1PointsLabel.text = ""
            p2PointsLabel.text = ""
            p1GamesLabel.text = "\(TennisInstance.setP1Score.last!)"
            p2GamesLabel.text = "\(TennisInstance.setP2Score.last!)"
            p1PointsLabel.backgroundColor = UIColor.white
            p1GamesLabel.backgroundColor = UIColor.white
            p1SetsLabel.backgroundColor = UIColor.white
            p2PointsLabel.backgroundColor = UIColor.white
            p2GamesLabel.backgroundColor = UIColor.white
            p2SetsLabel.backgroundColor = UIColor.white
            p1NameLabel.backgroundColor = UIColor.white
            p2NameLabel.backgroundColor = UIColor.white
            
            let WinnerAlert = UIAlertController(title: "Game Over", message: "Player \(TennisInstance.MatchInstance.winner) has won the game",         preferredStyle: UIAlertController.Style.alert)
            WinnerAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            }))
            self.present(WinnerAlert, animated: true, completion: nil)
        }
    }
    
    func ScoreView(){
        if TennisInstance.TieBreaker == true{
            p1PointsLabel.text = "\(TennisInstance.TieInstance.player1Score())"
            p2PointsLabel.text = "\(TennisInstance.TieInstance.player2Score())"
        }else{
            p1PointsLabel.text = "\(TennisInstance.GameInstance.player1Score())"
            p2PointsLabel.text = "\(TennisInstance.GameInstance.player2Score())"
        }
    }
    func playerTextLabelsSet(){
        p1GamesLabel.text = "\(TennisInstance.SetInstance.GamesWonForPlayer1())"
        p1SetsLabel.text = "\(TennisInstance.MatchInstance.SetsWonForPlayer1())"
        p2GamesLabel.text = "\(TennisInstance.SetInstance.GamesWonForPlayer2())"
        p2SetsLabel.text = "\(TennisInstance.MatchInstance.SetsWonForPlayer2())"
    }
    @IBAction func p1AddPointPressed(_ sender: UIButton) {
        player = true
        TennisInstance.main(player: player)
        ScoreView()
        serverIndicator()
        playerTextLabelsSet()
        MatchFinished()
        p1PreviousSetsLabel.text = "\(TennisInstance.setP1Score)"
        p2PreviousSetsLabel.text = "\(TennisInstance.setP2Score)"
        greenIndicator()
    }

    @IBAction func p2AddPointPressed(_ sender: UIButton) {
        player = false
        TennisInstance.main(player: player)
        ScoreView()
        serverIndicator()
        playerTextLabelsSet()
        MatchFinished()
        p1PreviousSetsLabel.text = "\(TennisInstance.setP1Score)"
        p2PreviousSetsLabel.text = "\(TennisInstance.setP2Score)"
        greenIndicator()
    }
    
    @IBAction func restartPressed(_ sender: AnyObject) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let viewController = story.instantiateViewController(withIdentifier: "ViewController")

        let transitionFlip: UIView.AnimationOptions = .transitionFlipFromLeft
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = viewController
        let main = (UIApplication.shared.delegate?.window!)!
        UIView.transition(with: main, duration: 0.3, options: transitionFlip, animations: nil, completion: nil)

    }
}

