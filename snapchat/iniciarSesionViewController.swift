//
//  iniciarSesionViewController.swift
//  snapchat
//
//  Created by Rodrigo Salas J on 24/10/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class iniciarSesionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
            print("Intentamos iniciar sesion")
            if error != nil {
                print("Tenemos el siguiente error:\(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {(user, error) in
                    print("Intentamos crear un usuario")
                    if error != nil{
                        print("Tenemos el siguiente error:\(error)")
                    }
                    else{
                        print("El usuario fue creado exitosamente")
                       
                        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("email").setValue(Auth.auth().currentUser?.email)
                        
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                })
            }else{
                print("Inicio de sesion exitosa")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        })
    }


}

