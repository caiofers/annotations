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
    
    @IBAction func deleteAnnotationButton(_ sender: UIButton) {
        present(makeAlertController(of: "delete"), animated: true, completion: nil)
        view.endEditing(true)
    }
    
    func makeAlertController(of type: String?) -> UIAlertController {
        
        var alertTitle: String
        var alertMessage: String
        
        var primaryActionTitle: String
        var primaryActionHander: ((UIAlertAction) -> Void)?
        var isPrimaryActionDestructive: Bool
        
        var secondaryActionTitle: String
        var secondaryActionHander: ((UIAlertAction) -> Void)?
        var isSecondaryActionDestructive: Bool
        
        var isPrimaryPreferredAction: Bool
        
        if(type == "save"){
            alertTitle = self.saveAlertTitle
            alertMessage = self.saveAlertMessage
            
            primaryActionTitle = self.confirmAlertActionTitle
            primaryActionHander = saveAnnotation
            isPrimaryActionDestructive = false
            
            secondaryActionTitle = self.cancelAlertActionTitle
            secondaryActionHander = nil
            isSecondaryActionDestructive = false
            
            isPrimaryPreferredAction = true
            
        } else {
            alertTitle = self.deleteAlertTitle
            alertMessage = self.deleteAlertMessage
            
            primaryActionTitle = self.deleteAlertActionTitle
            primaryActionHander = deleteAnnotation
            isPrimaryActionDestructive = true
            
            secondaryActionTitle = self.cancelAlertActionTitle
            secondaryActionHander = nil
            isSecondaryActionDestructive = false
            
            isPrimaryPreferredAction = false
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let primaryAction = UIAlertAction(title: primaryActionTitle, style: isPrimaryActionDestructive ? .destructive : .default, handler: primaryActionHander)
        let secondaryAction = UIAlertAction(title: secondaryActionTitle, style: isSecondaryActionDestructive ? .destructive : .cancel, handler: secondaryActionHander)
        alert.addAction(primaryAction)
        alert.addAction(secondaryAction)
        alert.preferredAction = isPrimaryPreferredAction ? primaryAction : secondaryAction
        return alert
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

