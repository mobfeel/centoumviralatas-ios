//
//  ContactViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 31/12/17.
//

import UIKit
import Eureka
import SwiftDate
import MessageUI
import CRNotifications

class ContactViewController: FormViewController, MFMailComposeViewControllerDelegate {

    var infoMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !UserDefaults.standard.bool(forKey: "showEmail") {
            self.form.removeAll()
            
            if AppManager.shared.show {
                AppManager.shared.show = false
                
                if let pet = AppManager.shared.petSelected {
                    self.form.append(Section("Pet"))
                    self.form.allSections.first?.append(LabelRow("pet_name"){
                        $0.title = "Nome"
                        $0.value = pet.name
                    })
                    
                    self.form.allSections.first?.append(LabelRow("idade"){
                        $0.title = "Idade"
                        $0.value = pet.yearsOld
                    })
                    
                    self.form.allSections.first?.append(LabelRow("sexo"){
                        $0.title = "Sexo"
                        $0.value = pet.sex
                    })
                    
                    self.form.allSections.first?.append(LabelRow("porte"){
                        $0.title = "Porte"
                        $0.value = pet.postage
                    })
                    
                    self.infoMessage = "---Pet--<br> Nome: \(pet.name!)<br> Idade: \(pet.yearsOld)<br>"
                    self.infoMessage += " Sexo: \(pet.sex!)<br> Porte: \(pet.postage!)<br>----"
                    
                }
                
                if let event = AppManager.shared.eventSelected {
                    let date = event.eventDate.string(dateStyle: .long, timeStyle: .short)
                    
                    self.form.append(Section("Evento"))
                    self.form.allSections.first?.append(LabelRow("title"){
                        $0.title = "Título"
                        $0.value = event.title
                    })
                    
                    self.form.allSections.first?.append(LabelRow("type"){
                        $0.title = "Tipo"
                        $0.value = event.type
                    })
                    
                    self.form.allSections.first?.append(LabelRow("when"){
                        $0.title = "Quando"
                        $0.value = date
                    })
                    
                    self.infoMessage = "---Evento--<br> Título: \(event.title!)<br> Evento: \(event.description!)<br>"
                    self.infoMessage += " Local: \(event.local!)<br> Data: \(date)<br> Tipo: \(event.title!)<br>----"
                    
                }
            }
            
            self.form +++ Section("Formulário de Contato")
                <<< TextRow("name"){ row in
                    row.title = "Seu Nome"
                    row.placeholder = "Zé"
                    row.add(rule: RuleRequired())
                    }.cellUpdate { cell, row in
                        if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                        if UserDefaults.standard.object(forKey: "name") == nil {
                            row.baseValue = ""
                        }
                    }.cellSetup({ (cell, row) in
                        if let name = UserDefaults.standard.object(forKey: "name") as? String {
                            row.baseValue = name
                        }
                        
                    })
                <<< EmailRow("mail"){
                    $0.title = "E-mail"
                    $0.placeholder = "Seu E-mail"
                    $0.add(rule: RuleRequired())
                    }.cellUpdate{ (cell, row) in
                        if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                        if let mail = UserDefaults.standard.object(forKey: "email") as? String {
                            row.baseValue = mail
                        }
                    }.cellSetup({ (cell, row) in
                        if let mail = UserDefaults.standard.object(forKey: "email") as? String {
                            row.baseValue = mail
                        }
                    })
                <<< PhoneRow("tel_number"){
                    $0.title = "Telefone"
                    $0.placeholder = "(51) 99999-9999"
                    $0.add(rule: RuleRequired())
                    }.cellUpdate{ (cell, row) in
                        if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                        if let tel = UserDefaults.standard.object(forKey: "tel") as? String {
                            row.baseValue = tel
                        }
                        
                    }.cellSetup({ (cell, row) in
                        if let tel = UserDefaults.standard.object(forKey: "tel") as? String {
                            row.baseValue = tel
                        }
                    })
                <<< ActionSheetRow<String>("assunto") {
                    $0.title = "Assunto"
                    $0.selectorTitle = "Escolha um Assunto"
                    $0.options = ["Selecione","Agendamento de visita", "Coleta de doações", "Adoção", "Doação mensal", "Encomenda de Produto", "Padrinhos", "Patrocínio no site, App ou Facebook", "Produtos para brechó", "Voluntário", "Lar temporário", "Outro Assunto"]
                    $0.value = AppManager.shared.optionSelected == nil ? $0.options?.first : $0.options![AppManager.shared.optionSelected!]
                    
                    }.cellUpdate({ (cell, row) in
                        cell.accessoryType = .disclosureIndicator
                    })
            
            self.form.allSections.last?.append(
                TextAreaRow("msg") {
                    $0.title = "Mensagem"
                    $0.placeholder = "Escreva sua mensagem..."
                    $0.textAreaHeight = .dynamic(initialTextViewHeight: 300)
                    $0.add(rule: RuleRequired())
                }
            )
        }
        UserDefaults.standard.set(false, forKey: "showEmail")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AppManager.shared.petSelected = nil
        AppManager.shared.optionSelected = nil
        AppManager.shared.eventSelected = nil
    }
    
    @IBAction func clickOnClearContact(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "tel")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "name")
        self.form.rowBy(tag: "name")?.updateCell()
        self.form.rowBy(tag: "email")?.updateCell()
        self.form.rowBy(tag: "tel")?.updateCell()
        
    }
    
    @IBAction func clickOnSend(_ sender: UIBarButtonItem) {
        //let rowName = self.form.rowBy(tag: "name")?.baseValue as! String
        let errors = self.form.validate()
        if errors.isEmpty {
            var fullMessage = ""
            let rowName = self.form.rowBy(tag: "name")?.baseValue as! String
            let rowMail = self.form.rowBy(tag: "mail")?.baseValue as! String
            let rowTel = self.form.rowBy(tag: "tel_number")?.baseValue as! String
            let rowSubject = self.form.rowBy(tag: "assunto")?.baseValue as! String
            if let rowMessage = self.form.rowBy(tag: "msg")?.baseValue as? String {
                fullMessage = rowMessage + "<br><br><br>" + self.infoMessage
            }else{
                fullMessage = "<br><br><br> \(self.infoMessage)"
            }
            
            var emailMessage = ""
            emailMessage += "Nome: \(rowName)<br>"
            emailMessage += "E-mail: \(rowMail)<br>"
            emailMessage += "Telefone: \(rowTel)<br>"
            emailMessage += "Assunto: \(rowSubject)<br>"
            emailMessage += "Mensagem: <br>"
            emailMessage += fullMessage
            
            
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["101viralatas@gmail.com"])
                mail.setSubject("Contato Via App-IOS ")
                mail.setMessageBody("<p>\(emailMessage)!</p>", isHTML: true)
                
                present(mail, animated: true)
                UserDefaults.standard.set(rowName, forKey: "name")
                UserDefaults.standard.set(rowMail, forKey: "email")
                UserDefaults.standard.set(rowTel, forKey: "tel")
                UserDefaults.standard.set(true, forKey: "showEmail")
                
            }else{
                CRNotifications.showNotification(type: .error, title: "Ops!", message: "Verifique suas configurações de e-mail. O e-mail não foi enviado!", dismissDelay: 3)
            }
            
        }

        
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if error != nil {
             CRNotifications.showNotification(type: .error, title: "Ops!", message: "Verifique suas configurações de e-mail. O e-mail não foi enviado!", dismissDelay: 3)
        }else if result == .sent {
            CRNotifications.showNotification(type: .success, title: "Sucesso", message: "E-mail enviado com sucesso!", dismissDelay: 3)
        }else if result == .cancelled {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
}
