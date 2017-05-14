//
//  DetailViewController.swift
//  GG1L3Parse
//
//  Created by Ivan Vasilevich on 5/11/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageBox: PFImageView!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = (detail["text"] as! String)
                if let imageFile = detail["photo"] as? PFFile {
                    imageBox.file = imageFile
                    imageBox.loadInBackground()
//                    imageFile.getDataInBackground(block: { (data, error) in
//                        self.imageBox.image = UIImage(data: data!)
//                    })
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: PFObject? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

