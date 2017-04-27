//
//  ProfileViewController.swift
//  lab9Tinder
//
//  Created by Sarah Gemperle on 4/26/17.
//  Copyright © 2017 Sarah Gemperle. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var image: UIImage?
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var navBarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UI setup
        navBarImageView.image = #imageLiteral(resourceName: "nav_bar2")
        if let image = image {
            profileImageView.image = image
        }
        
        let tapGestureRec = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        navBarImageView.addGestureRecognizer(tapGestureRec)
        navBarImageView.isUserInteractionEnabled = true
        
    }
    
    @IBAction
    func didTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
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
