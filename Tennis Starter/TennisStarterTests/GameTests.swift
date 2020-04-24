import XCTest

class GameTests: XCTestCase {
    
    var game: Game!
    var mirror: Mirror!
    
    override func setUp() {
        super.setUp()
        game = Game()
        mirror = Mirror(reflecting: game!)

    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testMaxTwoInstanceVariables(){
        XCTAssertLessThanOrEqual(mirror.children.count, 2)
    }
    
    func testNotASubclass(){
        XCTAssertNil(mirror.superclassMirror)
    }
        
    func getToDeuce(){
        game.addPointToPlayer1() //15 - 0
        game.addPointToPlayer1() //30 - 0
        game.addPointToPlayer1() //40 - 0
        
        
        game.addPointToPlayer2() //40 - 15
        game.addPointToPlayer2() //40 - 30
        game.addPointToPlayer2() //40 - 40
    }
    

    
    func testZeroPoints(){
        XCTAssertEqual(game.player1Score(), "0", "P1 score correct with 0 points")
        XCTAssertEqual(game.player2Score(), "0", "P2 score correct with 0 points")
    }
    func testP1OutOfBoundsPoints(){
        for _ in 1...10{
            game.addPointToPlayer1()

        }


        XCTAssertEqual(game.player1Score(), "", "P1 score is null")
    }
    func testP2OutOfBoundsPoints(){
        for _ in 1...10{
            game.addPointToPlayer2()

        }
        XCTAssertEqual(game.player2Score(), "", "P2 score is null")
    }

    func testAddOnePoint() {
        
        game.addPointToPlayer1()
        XCTAssertEqual(game.player1Score(),"15","P1 score correct with 1 point")
        
        game.addPointToPlayer2()
        XCTAssertEqual(game.player2Score(),"15","P2 score correct with 1 point")
    }
    
    func testAddTwoPoints() {
        
        game.addPointToPlayer1()
        game.addPointToPlayer1()
        
        XCTAssertEqual(game.player1Score(),"30","P1 score correct with 2 points")
        
        game.addPointToPlayer2()
        game.addPointToPlayer2()
        XCTAssertEqual(game.player2Score(),"30","P2 score correct with 2 points")
    }
    
    func testAddThreePoints() {
        
        game.addPointToPlayer1()
        game.addPointToPlayer1()
        game.addPointToPlayer1()
        XCTAssertEqual(game.player1Score(),"40","P1 score correct with 3 points")
        
        game.addPointToPlayer2()
        game.addPointToPlayer2()
        game.addPointToPlayer2()
        XCTAssertEqual(game.player2Score(),"40","P2 score correct with 3 points")
    }
    
    func testSimpleWinP1(){
        for _ in 0...3{
            game.addPointToPlayer1()
        }
        XCTAssertTrue(game.player1Won(), "P1 win after 4 consecutive points")
    }
    
    func testSimpleWinP2(){
        for _ in 0...3{
            game.addPointToPlayer2()
        }
        XCTAssertTrue(game.player2Won(), "P2 win after 4 consecutive points")
    }
    
    func testReachingDeuce(){
        getToDeuce()
        XCTAssertEqual(game.player1Score(),"40","P1 score correct reaching Deuce")
        XCTAssertEqual(game.player2Score(),"40","P1 score correct reaching Deuce")
        XCTAssertFalse(game.player1Won())
        XCTAssertFalse(game.player2Won())
        XCTAssertFalse(game.complete())
    }
    func testP1score4() {
        for _ in 1...4{
            game.addPointToPlayer1()
        }
        XCTAssertEqual(game.player1Score(),"40","P1 score correct with P1 Advantage")
        
    }
    func testAdvP2score4() {
        for _ in 1...4{
            game.addPointToPlayer2()
        }
        XCTAssertEqual(game.player2Score(),"40","P1 score correct with P1 Advantage")
        
    }
    func testAdvP1Advantage() {
        
        getToDeuce()
        game.addPointToPlayer1()
        XCTAssertEqual(game.player1Score(),"A","P1 score correct with P1 Advantage")
        XCTAssertEqual(game.player2Score(),"40","P2 score correct with P1 Advantage")
        
    }
    
    func testAdvP2Advantage() {
        
        getToDeuce()
        game.addPointToPlayer2()
        XCTAssertEqual(game.player1Score(),"40","P1 score correct with P2 Advantage")
        XCTAssertEqual(game.player2Score(),"A","P2 score correct with P2 Advantage")
        
    }
    
    func testDeuceAfterAdvantageBothPlayers(){
        getToDeuce()
        game.addPointToPlayer1() // A - 40
        game.addPointToPlayer2() //40 - 40
        game.addPointToPlayer2() //40 -  A
        game.addPointToPlayer1() //40 - 40
        XCTAssertEqual(game.player1Score(),"40","P1 score correct after return from Advantage")
        XCTAssertEqual(game.player2Score(),"40","P2 score correct after return from Advantage")
    }
    
    func testMultipleAdvantages(){
        getToDeuce()
        for _ in 0...1023{
            game.addPointToPlayer1()
            game.addPointToPlayer2()
            game.addPointToPlayer2()
            game.addPointToPlayer1()
        }

        XCTAssertEqual(game.player1Score(),"40","P1 score correct after return from Advantage many times")
        XCTAssertEqual(game.player2Score(),"40","P2 score correct after return from Advantage many times")
    }
    func testMultipleAdvantagesEndingUneven(){
        getToDeuce()
        for _ in 0...1023{
            game.addPointToPlayer1()
            game.addPointToPlayer2()
            game.addPointToPlayer2()
            game.addPointToPlayer1()
        }
        game.addPointToPlayer1()

        XCTAssertEqual(game.player1Score(),"A","P1 score correct after return from Advantage many times")
        XCTAssertEqual(game.player2Score(),"40","P2 score correct after return from Advantage many times")
    }
    
    func testGameCompleteP1Win(){
        for _ in 0...3{
            game.addPointToPlayer1()
        }
        XCTAssertTrue(game.complete(), "Game complete with P1 win")
    }
    
    func testGameCompleteP2Win(){
        for _ in 0...3{
            game.addPointToPlayer2()
        }
        XCTAssertTrue(game.complete(), "Game complete with P1 win")
    }
    
    func testNoGamePointsP1() {
        
        game.addPointToPlayer1()
        XCTAssertEqual(game.gamePointsForPlayer1(), 0, "P1 has no game points at 15-0")
        
        game.addPointToPlayer1()
        XCTAssertEqual(game.gamePointsForPlayer1(), 0, "P1 has no game points at 30-0")
        
    }
    
    func testGamePointsP1() {
        
        for _ in 0...2{
            game.addPointToPlayer1()
        }
        XCTAssertEqual(game.gamePointsForPlayer1(), 3, "P1 has 3 game points at 40-0")

        game.addPointToPlayer2()
        XCTAssertEqual(game.gamePointsForPlayer1(), 2, "P1 has 2 game points at 40-15")
        
        game.addPointToPlayer2()
        XCTAssertEqual(game.gamePointsForPlayer1(), 1, "P1 has 1 game point at 40-30")
        
        game.addPointToPlayer2()
        XCTAssertEqual(game.gamePointsForPlayer1(), 0, "P1 has 0 game point at 40-40")
        
        game.addPointToPlayer1()
        XCTAssertEqual(game.gamePointsForPlayer1(), 1, "P1 has 1 game point at A-40")
    }
    
    func testNoGamePointsP2() {
        
        game.addPointToPlayer2()
        XCTAssertEqual(game.gamePointsForPlayer2(), 0, "P2 has no game points at 0-15")
        
        game.addPointToPlayer2()
        XCTAssertEqual(game.gamePointsForPlayer2(), 0, "P1 has no game points at 0-30")
        
    }
    

    
    func testGamePointsP2() {
        
        for _ in 0...2{
            game.addPointToPlayer2()
        }
        XCTAssertEqual(game.gamePointsForPlayer2(), 3, "P2 has 3 game points at 0-40")
        
        game.addPointToPlayer1()
        XCTAssertEqual(game.gamePointsForPlayer2(), 2, "P2 has 2 game points at 15-40")
        
        game.addPointToPlayer1()
        XCTAssertEqual(game.gamePointsForPlayer2(), 1, "P2 has 1 game point at 30-40")
        
        game.addPointToPlayer1()
        XCTAssertEqual(game.gamePointsForPlayer2(), 0, "P2 has 0 game point at 40-40")
        
        game.addPointToPlayer2()
        XCTAssertEqual(game.gamePointsForPlayer2(), 1, "P2 has 1 game point at 40-A")
    }
    
}
