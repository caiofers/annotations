//
//  ViewController.swift
//  Annotations
//
//  Created by Caio Fernandes on 20/03/21.
//

import UIKit

class ViewController: UIViewController {

    let keyAnnotationText: String = "annotation"
    let saveAlertTitle: String = "Salvar"
    let saveAlertMessage: String = "Você realmente deseja salvar a anotação?"
    let deleteAlertTitle: String = "Excluir"
    let deleteAlertMessage: String = "Você realmente deseja excluir a anotação?"
    let confirmAlertActionTitle: String = "Confirmar"
    let deleteAlertActionTitle: String = "Excluir"
    let cancelAlertActionTitle: String = "Cancelar"
    
    
    @IBOutlet weak var annotationTextView: UITextView!
    @IBAction func saveAnnotationButton(_ sender: UIButton) {
        
        present(makeAlertController(of: "save"), animated: true, completion: nil)
        view.endEditing(true)
    }
    
    func makeAlertController(of type: String?) -> UIAlertController {
        if(type == "save"){
            let alert = UIAlertController(title: saveAlertTitle, message: saveAlertMessage, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: confirmAlertActionTitle, style: .default, handler: saveAnnotation(_:))
            let cancelAction = UIAlertAction(title: cancelAlertActionTitle, style: .cancel, handler: nil)
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            return alert
        } else {
            let alert = UIAlertController(title: deleteAlertTitle, message: deleteAlertMessage, preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: deleteAlertActionTitle, style: .destructive, handler: deleteAnnotation(_:))
            let cancelAction = UIAlertAction(title: cancelAlertActionTitle, style: .cancel, handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            return alert
        }
    }
    
    @IBAction func deleteAnnotationButton(_ sender: UIButton) {
        present(makeAlertController(of: "delete"), animated: true, completion: nil)
        view.endEditing(true)
    }
    
    func saveAnnotation(_ alertAction: UIAlertAction) {
        UserDefaults.standard.set(annotationTextView.text, forKey: keyAnnotationText)
    }
    
    func getAnnotation() -> String {
        if let text = UserDefaults.standard.object(forKey: keyAnnotationText){
            return text as! String
        }
        return ""
    }
    
    func deleteAnnotation(_ alertAction: UIAlertAction) {
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

