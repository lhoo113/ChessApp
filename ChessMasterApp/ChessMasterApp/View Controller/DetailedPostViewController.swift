//
//  DetailedPostViewController.swift
//  ChessMasterApp
//
//  Created by Linhao Hu on 2021/12/3.
//

import UIKit

class DetailedPostViewController: UIViewController {
    var content: String?
    var author: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let textFrame = CGRect(x: view.frame.midX - 200, y: 130, width: 400, height: 700)
        let authorFrame = CGRect(x: view.frame.midX - 200, y: 100, width: 400, height: 30)
        let contentView = UITextView(frame: textFrame)
        let authorView = UITextView(frame: authorFrame)
        contentView.text = content
        authorView.text = "\(author ?? "Anonymous") shared"
        
        authorView.isEditable = false
        contentView.isEditable = false
        contentView.font = contentView.font?.withSize(14)
        authorView.font = authorView.font?.withSize(20)
        
        view.addSubview(authorView)
        view.addSubview(contentView)
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
