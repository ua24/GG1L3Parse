//https://github.com/parse-community
//http://docs.parseplatform.org/ios/guide/
//  MasterViewController.swift
//  GG1L3Parse
//
//  Created by Ivan Vasilevich on 5/11/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [PFObject]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if PFUser.current() == nil {
            showLoginForm(UIBarButtonItem())
        }
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
//        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        fetchPosts()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! DetailViewController)
                controller.post = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func fetchPosts() {
        let query = PFQuery(className: "Post")
//        query.whereKey("text", hasSuffix: "t2")
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                self.objects = objects
                
                print(objects)
                self.tableView.reloadData()
            }
        }
//        if let objects = try? query.findObjects() {
//            print(objects)
//        }
    }

    @IBAction func showLoginForm(_ sender: UIBarButtonItem) {
        let loginVC = PFLogInViewController()
        present(loginVC, animated: true) { 
            
        }
    }
    

}

