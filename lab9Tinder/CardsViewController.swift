//
//  CardsViewController.swift
//  lab9Tinder
//
//  Created by Sarah Gemperle on 4/26/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var navBarImageView: UIImageView!
    @IBOutlet weak var actionButtonImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    var previousXLocation: CGFloat!
    
    var cardInitialCenter: CGPoint!
    var initialPanLocation: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBarImageView.image = #imageLiteral(resourceName: "nav_bar")
        actionButtonImageView.image = #imageLiteral(resourceName: "action_buttons")
        
        //Initialize the pan and tap gesture recognizers for avatar image view.
        let panGestureRec = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        let tapGestureRec = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        avatarImageView.addGestureRecognizer(tapGestureRec)
        avatarImageView.addGestureRecognizer(panGestureRec)
        
        //Initial setup
        avatarImageView.image = #imageLiteral(resourceName: "ryan")
        cardInitialCenter = avatarImageView.center
        previousXLocation = cardInitialCenter.x

    }

    @IBAction
    func didTap(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toProfileSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ProfileViewController
        dest.image = avatarImageView.image
    }
    
    //Action method for pan gesture recognizer binded to avatar image view.
    @IBAction
    func didPan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        
        let halfPoint = avatarImageView.center.y
        
        if sender.state == .began {
            print("Gesture began")
            //Give an initial rotation
            avatarImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
            initialPanLocation = location.y
            
        //During user panning:
        } else if sender.state == .changed {
            print("Gesture is changing")
            
            //If x translation great enough, animate off the view.
            if(abs(translation.x) > 120) {
                UIView.animate(withDuration: 0.35, animations: { 
                    self.avatarImageView.alpha = 0
                }, completion: { (bool: Bool) in

                })
            }
            
            avatarImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y + translation.y)
            
            //Tried different options, like a percentage of the translation of x but this random number worked better so 0.026 it is.
            let rotation = (translation.x > 0) ? 0.026 : -0.026
            
                //Started panning in top half.
                if( initialPanLocation <= halfPoint) {
                  avatarImageView.transform = avatarImageView.transform.rotated(by: CGFloat(rotation))
                //Started panning in bottom half.
                } else {
                     avatarImageView.transform = avatarImageView.transform.rotated(by: CGFloat(-rotation))
                }
            
        } else if sender.state == .ended {
            print("Gesture ended")
            
            //Reset position of card fyi ryan gosling wut a babe :)))
            avatarImageView.center = cardInitialCenter
            avatarImageView.transform = CGAffineTransform.identity
            previousXLocation = cardInitialCenter.x


        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
