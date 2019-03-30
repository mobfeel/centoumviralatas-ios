//
//  DonationViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 02/01/18.
//

import UIKit
import PagingMenuController

class DonationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.setup(PagingMenuDonations())
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .didMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case .didScrollStart:
                print("Scroll start")
            case .didScrollEnd:
                print("Scroll end")
            }
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

struct MenuItemUsers: MenuItemViewCustomizable {
    var text: String!
    init(_ text: String) {
        self.text = text
    }
    var displayMode: MenuItemDisplayMode {
        return .text(title: MenuItemText(text: self.text, color: UIColor.black))
    }
}

struct PagingMenuDonations: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let MensalViewController = mainStoryboard.instantiateViewController(withIdentifier: "MensalViewController")
        let DinheiroViewController = mainStoryboard.instantiateViewController(withIdentifier: "DinheiroViewController")
        let ProdutoViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProdutoViewController")
        
        return .all(menuOptions: MenuOptions(), pagingControllers: [MensalViewController, DinheiroViewController, ProdutoViewController])
    }
    
    var menuControllerSet: MenuControllerSet {
        return .single
    }
    
    
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemUsers("Mensal"), MenuItemUsers("Dinheiro"), MenuItemUsers("Prod./Itens")]
        }
        
        var focusMode: MenuFocusMode {
            return .underline(height: 3, color: UIColor.orange, horizontalPadding: 0, verticalPadding: 0)
        }
        
    }
}

