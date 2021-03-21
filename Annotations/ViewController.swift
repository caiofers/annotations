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
        saveAnnotation()
        view.endEditing(true)
    }
    @IBAction func deleteAnnotationButton(_ sender: UIButton) {
        deleteAnnotation()
        view.endEditing(true)
    }
    
    func saveAnnotation() {
        UserDefaults.standard.set(annotationTextView.text, forKey: keyAnnotationText)
    }
    
    func getAnnotation() -> String {
        if let text = UserDefaults.standard.object(forKey: keyAnnotationText){
            return text as! String
        }
        return ""
    }
    
    func deleteAnnotation() {
        UserDefaults.standard.removeObject(forKey: keyAnnotationText)
        updateAnnotationTextView()
    }
    
    func updateAnnotationTextView(){
        annotationTextView.text = getAnnotation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAnnotationTextView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

