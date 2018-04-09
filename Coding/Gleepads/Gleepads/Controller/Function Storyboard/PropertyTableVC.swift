//
//  PropertyTableVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 09/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class PropertyTableVC: UITableViewController,ZGCarouselDelegate {
    
    var IMAGE = [#imageLiteral(resourceName: "dundee1"),#imageLiteral(resourceName: "dundee2"),#imageLiteral(resourceName: "dundee3"),#imageLiteral(resourceName: "dundee4")]

    @IBOutlet weak var scroll_image: ZGCarousel!
    
    @IBOutlet var propertyTable: UITableView!
    
    
    var timer:Timer!
    var count = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        scroll_image.zgDelegate = self
        
        propertyTable.delegate = self
        propertyTable.dataSource = self
        
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateImage), userInfo: nil, repeats: true)
        
        
        let bottomViewNib = Bundle.main.loadNibNamed("PropertyBottomView", owner: nil, options: nil)?.first as! PropertyBottomView
        bottomViewNib.frame.origin.y = self.view.frame.size.height - bottomViewNib.frame.size.height
        bottomViewNib.frame.size.width = self.view.frame.size.width
//        bottomViewNib.frame.size.height = 90
         UIApplication.shared.keyWindow?.addSubview(bottomViewNib)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    
    @objc func updateImage(){
        count+=1
        if count >= IMAGE.count{
            count = 0
        }
        scroll_image.moveTo(index: count)
        
    }
    
    func ZGitemData() -> [UIViewController] {
        
        
        var totalController = [UIViewController]()
        
        
        for totalImage in IMAGE{
            
            let cont = UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "image") as! ImageScrollVC
            cont.loadView()
            
            cont.displayImage.image = totalImage
            
            totalController.append(cont)
            
        }
        
        
        return totalController
    }
    
    
    
    
    
    
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
