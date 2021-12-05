//
//  ComposeViewController.swift
//  ChessMasterApp
//
//  Created by Linhao Hu on 2021/12/3.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class ComposeViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    var ref: DatabaseReference?

        
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addPost(_ sender: Any) {
        if Auth.auth().currentUser != nil {
        
            let user = Auth.auth().currentUser

            ref?.child("Posts").childByAutoId().setValue(["author": user?.displayName, "body":textField.text])
        } 
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelPost(_ sender: Any) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
