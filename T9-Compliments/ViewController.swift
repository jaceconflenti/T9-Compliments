//
//  ViewController.swift
//  T9-Compliments
//
//  Created by Jace Conflenti on 2/26/17.
//  Copyright © 2017 Last Words Project. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet weak var complimentLabel: UILabel!
    var ref: FIRDatabaseReference!
    var compliment: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.changeCompliment(_:)))
        complimentLabel.addGestureRecognizer(tap)
    }
    
    func getRandomNum(max: UInt32) -> String {
        return String(arc4random_uniform(100))
    }
    
    func changeCompliment(_ sender: UITapGestureRecognizer) {
        ref.child("compliments").child(getRandomNum(max: 333)).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let comp = dictionary["value"] as? String
                self.complimentLabel.text = comp
            }
        })
        UIView.transition(with: complimentLabel, duration: 0.5, options: [.transitionCrossDissolve],
                          animations: {self.complimentLabel.text = self.compliment},
                          completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

