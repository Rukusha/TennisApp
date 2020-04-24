class Game{
    var p1Score: Int
    var p2Score: Int
    
    init(){
        p1Score = 0
        p2Score = 0
    }
    func gamePointsForPlayer1() -> Int{
        if p1Score >= 3{
            return p1Score - p2Score
        }
        return 0
    }
    func gamePointsForPlayer2() -> Int {
        if p2Score >= 3{
            return p2Score - p1Score
        }
        return 0
    }
    func addPointToPlayer1(){
        p1Score += 1
    }
    
    func addPointToPlayer2(){
        p2Score += 1
    }
    
    func evenUnevenScore(){
        if p1Score >= 4 && p2Score >= 4{
            if p1Score == p2Score {
                p1Score = 3
                p2Score = 3
            }else if p1Score > p2Score{
                    p1Score = 4
                    p2Score = 3
                }else{
                    p1Score = 3
                    p2Score = 4
                }
            }
        }
    
    
    func player1Score() -> String {
        evenUnevenScore()
        switch p1Score{
        case 0:
            return "0"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4:
            if p1Score == p2Score + 1{
                return "A"
            }
            return "40"
        default:
            return ""
        }
    }
    
    func player2Score() -> String {
        evenUnevenScore()
        switch p2Score{
        case 0:
            return "0"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4 :
            if p2Score == p1Score + 1{
                return "A"
            }
            return "40"
        default:
            return ""
        }
    }
    
    func player1Won() -> Bool{
        if p1Score >= 4 && p1Score >= p2Score + 2{
            
            return true
        }
        return false
    }
    
    func player2Won() -> Bool{
        if p2Score >= 4 && p2Score >= p1Score + 2{
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

