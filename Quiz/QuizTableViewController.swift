//
//  QuizTableViewController.swift
//  Quiz
//
//  Created by g891 DIT UPM on 20/11/18.
//  Cristina López Alonso
//  Julio Langtry Yañez
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit


struct Quiz: Codable {
    
    var id = 0
    var question = String()
    var author = [String:Any]()
    var attachment = [String:Any]()
    var favourite = false
    var tips = [String]()
    
}
struct Author: Codable {
    var id = Int
    var isAdmin = Boolean
    var username = String()
}

class QuizTableViewController: UITableViewController{
    
    let URLBASE = "https://quiz2019.herokuapp.com/api/quizzes?token=2cfb2e55ca0145003c1d"
    
    var quizzes = [Quiz]()
    
    var imagesCache = [String:UIImage]()
    
    var author = [Author]()
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        downloadQuizzes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return quizzes.count
        }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Type Cell", for: indexPath) as! QuizTableViewCell
        
        // Configure the cell...
        
        let imgurl = quizzes[indexPath.row]
        let authorurl = author[indexPath.row]
        cell.nameQuestion?.text = imgurl.question
        cell.nameAuthor?.text = imgurl.author[authorurl.username]
        if let img = imagesCache[imgurl] {
            cell.imageView?.image = img
        }else{
            cell.imageView?.image = UIImage(named: "none")
        }
        return cell
    }

        func downloadQuizzes() {
        
        title = "Descargando... "
        refreshButton.isEnabled = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let queue = DispatchQueue(label: "download queue")
        queue.async{
            let url = URL(string: self.URLBASE)!
            if let jsonData = try? Data(contentsOf: url){
                if let newQuizzes = JSONDecoder().decode([Quiz].self, from: jsonData) {
                    //(try? JSONSerialization.jsonObject(with: jsonData)) as? [String:Any]{
                    DispatchQueue.main.async{
                        self.quizzes = newQuizzes
                        self.tableView.reloadData()
                        self.title = "All Quizzes"
                    }
                }else{
                    DispatchQueue.main.async {
                        self.title = "Desactualizado"
                    }
                }
                DispatchQueue.main.async {
                    self.refreshButton.isEnabled = true
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    

    
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

    
        override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Show Quiz" {
            let avc = segue.destination as! AnswerViewController
            
           /* if let ip = tableView.indexPathForSelectedRow {
                rtvc.type = model.types[ip.row]
 
            } */
        }
    }
    
}
