//
//  ViewController.swift
//  ticTacToe
//
//  Created by Sergio Gomez on 10/7/16.
//  Copyright © 2016 Sergio Gomez. All rights reserved.
//
/*****************************************************************************************************************************************
 this program creates a tic tac toe game which allows users to play again once the game is over.
 *************************************************************************************************************************************************/

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var winningLabel: UILabel!
    @IBOutlet var playAgainButton: UIButton!
    
    //1 is noughts; 2 is crosses
    var activePlayer = 1
    var activeGame = true
    var gameState = [0,0,0,0,0,0,0,0,0] //0 - empty; 1 - noughts; 2 - crosses
    var isDraw = false
    
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8],[0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        let activePosition = sender.tag - 1 //tags started at 1; arrays start at 0
        if gameState[activePosition] == 0 && activeGame{
            //empty slot so move is valid
            gameState[activePosition] = activePlayer
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), for:[])
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "cross.png"), for:[])
                activePlayer = 1
            }
            for combination in winningCombinations {
                //check the combinations that we currently have on the board and if they match a winning combo then we got a winner.
                if gameState[combination[0]] != 0 && gameState[combination[0]]==gameState[combination[1]] && gameState[combination[1]]==gameState[combination[2]]{
                    //we have a winner
                    activeGame = false
                    winningLabel.isHidden = false
                    winningLabel.backgroundColor = UIColor.red
                    playAgainButton.isHidden = false
                    playAgainButton.backgroundColor = UIColor.red
                    
                    if gameState[combination[0]]==1{
                        winningLabel.text = "Noughts has won!"
                    } else {
                        winningLabel.text = "Crosses has won!"
                    }
                    UIView.animate(withDuration: 1, animations: {
                        self.winningLabel.center = CGPoint(x: self.winningLabel.center.x + 500, y: self.winningLabel.center.y)
                        self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x + 500, y: self.playAgainButton.center.y)
                    })
                }//end if gameState[combination[0]]
            }//end for combination in
            isDraw = checkForDraw()
            if isDraw && activeGame{
                print("in the right else statement")
                winningLabel.isHidden = false
                winningLabel.backgroundColor = UIColor.red
                playAgainButton.isHidden = false
                playAgainButton.backgroundColor = UIColor.red
                winningLabel.text = "Draw!"
                UIView.animate(withDuration: 1, animations: {
                self.winningLabel.center = CGPoint(x: self.winningLabel.center.x + 500, y: self.winningLabel.center.y)
                self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x + 500, y: self.playAgainButton.center.y)
                })
            }
        }
    }
    
    @IBAction func playAgain(_ sender: AnyObject) {
        activePlayer = 1
        activeGame = true
        gameState = [0,0,0,0,0,0,0,0,0] //0 - empty; 1 - noughts; 2 - crosses
        
        for i in 1..<10{
            if let button = view.viewWithTag(i) as? UIButton{
                //need to cast it to a button because view.viewWithTag will return a view, want button specific functions
                button.setImage(nil, for: [])
            }
        }
        winningLabel.isHidden = true
        playAgainButton.isHidden = true
        winningLabel.center = CGPoint(x: winningLabel.center.x - 500, y: winningLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        winningLabel.isHidden = true
        playAgainButton.isHidden = true
        winningLabel.center = CGPoint(x: winningLabel.center.x - 500, y: winningLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkForDraw() -> Bool{
        for i in 0..<gameState.count{
            if (gameState[i] == 0){
                //there is an empty space so cannot be draw
                return false
            }
        }
        //if went through the whole array without any 0s then we have a draw
        return true
    }


}

