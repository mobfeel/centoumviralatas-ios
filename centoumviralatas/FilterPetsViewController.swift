//
//  FilterViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 03/01/18.
//

import UIKit
import Eureka

enum Porte: String {
    case Todos = "Todos"
    case P = "P"
    case PM = "P/M"
    case M = "M"
    case MG = "M/G"
    case G = "G"
}

enum Sexo: String {
    case Todos = "Todos"
    case Femea = "Fêmea"
    case Macho = "Macho"
}

enum Idade: String {
    case Todos = "Todos"
    case Filhote = "Filhote"
    case Adulto = "Adulto"
    case Idoso = "Idoso"
}

enum Especie: String {
    case Todos = "Todos"
    case Canino = "Canino"
    case Felino = "Felino"
}

class FilterPetsViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form +++ Section("")
            <<< ActionSheetRow<String>("porte") {
                $0.title = "Porte"
                $0.selectorTitle = "Escolha uma opção"
                $0.options = ["Todos","P", "P/M", "M", "M/G", "G"]
                $0.value = Filter.shared.porte.rawValue
                // $0.add(rule: RuleRequired())
                }.cellUpdate({ (cell, row) in
                    cell.accessoryType = .disclosureIndicator
                })
            <<< ActionSheetRow<String>("especie") {
                $0.title = "Espécie"
                $0.selectorTitle = "Escolha uma opção"
                $0.options = [Especie.Todos.rawValue, Especie.Canino.rawValue, Especie.Felino.rawValue]
                $0.value = Filter.shared.especie.rawValue
                // $0.add(rule: RuleRequired())
                }.cellUpdate({ (cell, row) in
                    cell.accessoryType = .disclosureIndicator
                })
            <<< ActionSheetRow<String>("sexo") {
                $0.title = "Sexo"
                $0.selectorTitle = "Escolha uma opção"
                $0.options = ["Todos","Macho", "Fêmea"]
                $0.value = Filter.shared.sexo.rawValue
                // $0.add(rule: RuleRequired())
                }.cellUpdate({ (cell, row) in
                    cell.accessoryType = .disclosureIndicator
                })
            <<< ActionSheetRow<String>("idade") {
                $0.title = "Idade"
                $0.selectorTitle = "Escolha uma opção"
                $0.options = ["Todos","Filhote", "Adulto", "Idoso"]
                $0.value = Filter.shared.idade.rawValue
                // $0.add(rule: RuleRequired())
                }.cellUpdate({ (cell, row) in
                    cell.accessoryType = .disclosureIndicator
                })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            Filter.shared.porte = Porte(rawValue: self.form.rowBy(tag: "porte")?.baseValue as! String)!
            Filter.shared.especie = Especie(rawValue: self.form.rowBy(tag: "especie")?.baseValue as! String)!
            Filter.shared.sexo = Sexo(rawValue: self.form.rowBy(tag: "sexo")?.baseValue as! String)!
            Filter.shared.idade = Idade(rawValue: self.form.rowBy(tag: "idade")?.baseValue as! String)!
            return
        }
    }

   
    @IBAction func clickOnClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickOnClear(_ sender: UIBarButtonItem) {
        Filter.shared.makeDefault()
        self.performSegue(withIdentifier: "backToPets", sender: true)
    }
    
}


struct Filter {
    static var shared = Filter()
    var porte = Porte.Todos
    var especie = Especie.Todos
    var sexo = Sexo.Todos
    var idade = Idade.Todos
    func makeDefault(){
        Filter.shared.porte = .Todos
        Filter.shared.especie = .Todos
        Filter.shared.sexo = .Todos
        Filter.shared.idade = .Todos
    }
    
}
