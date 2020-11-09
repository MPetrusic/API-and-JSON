//
//  ViewController.swift
//  Quotes
//
//  Created by Milos Petrusic on 05/11/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let networker = Networking.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networker.getImage { (data, error) -> (Void) in
            if let error = error {
                print(error)
                return
            }
            self.imageView.image = UIImage(data: data!)
        }
    }

    @IBAction func randomQuote(_ sender: Any) {
        networker.getQuote { (kanye, error) -> (Void) in
            if let _ = error {
                self.label.text = "Error"
                return
            }
            self.label.text = kanye?.quote
        }
    }
}

