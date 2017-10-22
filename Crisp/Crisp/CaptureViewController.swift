//
//  CaptureViewController.swift
//  Crisp
//
//  Created by Jayesh Kaushik on 10/22/17.
//  Copyright © 2017 Crisp. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController {
    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let loadedImage = self.image {
            self.imageView.image = loadedImage
        }
    }
    
    @IBOutlet weak var buttonTapped: UIButton!
    @IBAction func buttonPressed(_ sender: Any) {
        AWSRequest.cognito()
        AWSRequest.tester()
        
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
