//
//  ViewController.swift
//  Annotations
//
//  Created by Caio Fernandes on 20/03/21.
//

import UIKit

class ViewController: UIViewController {

    var keyAnnotationText: String = "annotation"
    @IBOutlet weak var annotationTextView: UITextView!
    @IBAction func saveAnnotationButton(_ sender: UIButton) {
        UserDefaults.standard.set(annotationTextView.text, forKey: keyAnnotationText)
        view.endEditing(true)
    }
    
    func getAnnotation() -> String{
        if let text = UserDefaults.standard.object(forKey: keyAnnotationText){
            return text as! String
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        annotationTextView.text = getAnnotation()
        //UserDefaults.standard.removeObject(forKey: "teste")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

