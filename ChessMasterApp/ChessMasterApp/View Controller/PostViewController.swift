//
//  PostViewController.swift
//  ChessMasterApp
//
//  Created by Linhao Hu on 2021/12/3.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func logoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        let startingVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.startingViewController) as? ViewController
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

        self.view.window?.rootViewController = startingVC
        self.view.window?.makeKeyAndVisible()
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var postData:[Post] = []
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        databaseHandle =  ref?.child("Posts").observe(.childAdded, with: {
            (snapshot) in
            let post = snapshot.value as? [String: Any]
            let author = post?["author"]
            let body = post?["body"]
            
            if body != nil{
                let newPost = Post()
                newPost.body = body as! String
                newPost.author = author as! String
                
                self.postData.append(newPost)
                self.tableView.reloadData()
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row].body
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailedPostViewController()
        detailedVC.content = postData[indexPath.row].body
        detailedVC.author = postData[indexPath.row].author
        
        navigationController?.pushViewController(detailedVC, animated: true)
        
    }
}
