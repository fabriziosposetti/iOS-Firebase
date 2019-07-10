//
//  PrincipalViewController.swift
//  intercorpApp
//
//  Created by Fabrizio Sposetti on 04/07/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import UIKit
import Firebase

class AltaClienteViewController: UIViewController {

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtFechaNacimiento: UITextField!
    @IBOutlet weak var txtEdad: UITextField!
    
    private var botonEnviar: UIBarButtonItem?
    private var datePicker: UIDatePicker?
    
    var ref: DatabaseReference?
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Textos.CreacionCliente.description
        ref = Database.database().reference().child("user")
        agregarBotonEnviar()
        configurarDatePicker()
        setupTextFields()
    }
    
    private func agregarBotonEnviar() {
        botonEnviar = UIBarButtonItem(title: Textos.Enviar.description,
                                      style: .plain,
                                      target: self,
                                      action: #selector(enviar))
        self.navigationItem.rightBarButtonItem = botonEnviar
    }
    
    @objc private func enviar() {
        if validarFormulario() {
            self.showActivityIndicator(activityIndicator: activityIndicator)
            let user = obtenerUsuarioAGuardar()
            ref?.setValue(user, withCompletionBlock: { [weak self] error, ref in
                guard let self = self else { return }
                self.stopActivityIndicator(activityIndicator: self.activityIndicator)
                if error == nil {
                    self.showToast(message: Textos.UsuarioGuardadoCorrectamente.description, width: CONSTANTS.TOAST_SIZE)
                } else {
                    self.showToast(message: Textos.ErrorAlGuardarUsuario.description, width: CONSTANTS.TOAST_SIZE)
                    
                }
            })
        } else {
            self.showToast(message: Textos.CamposVacios.description, width: CONSTANTS.TOAST_SIZE)
        }
    }
    
    private func validarFormulario() -> Bool {
        return !(txtApellido.text!.isEmpty || txtEdad.text!.isEmpty ||
            txtNombre.text!.isEmpty || txtFechaNacimiento.text!.isEmpty)
    }
    
    private func obtenerUsuarioAGuardar() -> [String : Any] {
        let nombre = txtNombre.text
        let apellido = txtApellido.text
        let edad = txtEdad.text
        let fechaNacimiento = txtFechaNacimiento.text
        
        let user = [Textos.Nombre.description : nombre ?? "",
                    Textos.Apellido.description: apellido ?? "",
                    Textos.Edad.description: edad ?? "",
                    Textos.FechaNacimiento.description: fechaNacimiento ?? ""] as [String : Any]
        return user
    }
    
    private func configurarDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        txtFechaNacimiento.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(AltaClienteViewController.dateChange(datePicker:)),
                              for: .valueChanged)
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(AltaClienteViewController.dismissPicker))
        txtFechaNacimiento.inputAccessoryView = toolBar
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "MM/dd/yyyy"
        txtFechaNacimiento.text = dateFormmater.string(from: datePicker.date)
        txtEdad.text = calcularEdad(birthday:  txtFechaNacimiento.text!)
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    private func setupTextFields() {
        self.txtApellido.delegate = self
        self.txtNombre.delegate = self
        self.txtFechaNacimiento.layer.cornerRadius = 8
        self.txtNombre.layer.cornerRadius = 8
        self.txtApellido.layer.cornerRadius = 8
        self.txtEdad.isUserInteractionEnabled = false
    }
    
    func calcularEdad(birthday: String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return String(age!)
    }
    
}

extension AltaClienteViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        let regex = "[a-z]{1,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: string)
    }
    
}
