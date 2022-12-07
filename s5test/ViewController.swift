//
//  ViewController.swift
//  s5test
//
//  Created by Nestor Alorro on 12/7/22.
//

import UIKit
import DLRadioButton

class ViewController: UIViewController {
    
    struct Menu: Codable {
        let id: Int
        let value: String
        
        public init(id: Int, value: String) {
            self.id = id;
            self.value = value;
        }
    }
    
    var firstSet:DLRadioButton = DLRadioButton.init();
    var secondSet:DLRadioButton = DLRadioButton.init();
    var thirdSet:DLRadioButton = DLRadioButton.init();
    
    var frame1:CGRect = CGRect(x:0,y:0,width:0,height:0);
    var frame2:CGRect = CGRect(x:0,y:0,width:0,height:0);
    var frameSub2:CGRect = CGRect(x:0,y:0,width:0,height:0);
    var frame3:CGRect = CGRect(x:0,y:0,width:0,height:0);
    var frameSub3:CGRect = CGRect(x:0,y:0,width:0,height:0);
    
    
    private func addMainMenu()->[Menu]{
        var newMenu:[Menu] = [];
        newMenu.append(Menu.init(id: 101, value: "Vegetarian"));
        newMenu.append(Menu.init(id: 102, value: "Nut Allergy"));
        newMenu.append(Menu.init(id: 103, value: "Halal"));
        return newMenu;
    }
    
    private func addSubMenu()->[Menu]{
        var newMenu:[Menu] = [];
        newMenu.append(Menu.init( id:201, value: "Cashew chicken"));
        newMenu.append(Menu.init( id:202, value: "Sweet and sour pork"));
        newMenu.append(Menu.init( id:203, value: "Stir fried Tofu"));
        newMenu.append(Menu.init( id:204, value: "Vegetable fried rice"));
        newMenu.append(Menu.init( id:205, value: "Pad Thai"));
        newMenu.append(Menu.init( id:206, value: "Massaman beef"));
        return newMenu;
    }
    
    private func addThirdMenu()->[Menu]{
        var newMenu:[Menu] = [];
        newMenu.append(Menu.init( id:301, value: "Peanut sauce"));
        newMenu.append(Menu.init( id:302, value: "Oyster sauce"));
        newMenu.append(Menu.init( id:303, value: "Vegetable spring rolls"));
        newMenu.append(Menu.init( id:304, value: "Steamed rice"));
        return newMenu;
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createMenus();
        
    }
    
    private func createMenus(){
        let mainMenu = addMainMenu();
        frame1 = CGRect(x: self.view.frame.size.width/2 - 131, y: 50, width: 262, height: 17);
        firstSet = createRadioButton(frame: frame1, title: mainMenu[0].value, tag: mainMenu[0].id);
        
        var i = 0;
        var otherButtons : [DLRadioButton] = [];
        for menuName in mainMenu where menuName.id > 101 {
            let frame = CGRect(x: self.view.frame.size.width / 2 - 131, y:80 + 30 * CGFloat(i), width: 262, height: 17);
            let radioButton = createRadioButton(frame: frame, title: menuName.value, tag: menuName.id);
            otherButtons.append(radioButton);
            i += 1;
        }
        
        firstSet.otherButtons = otherButtons;
        
        // sub Menu
        
        let subMenu = addSubMenu();
        frame2 = CGRect(x: self.view.frame.size.width/2 - 131, y: frame1.maxY+100, width: 262, height: 17);
        secondSet = create2ndSet(frame: frame2, title: subMenu[0].value, tag: subMenu[0].id);
        
        i = 0;
        otherButtons = [];
        for menuName in subMenu where menuName.id > 201 {
            frameSub2 = CGRect(x: self.view.frame.size.width / 2 - 131, y:(frame1.maxY+130) + 30 * CGFloat(i), width: 262, height: 17);
            let radioButton = create2ndSet(frame: frameSub2, title: menuName.value, tag: menuName.id );
            otherButtons.append(radioButton);
            i += 1;
        }
        
        secondSet.otherButtons = otherButtons;
        
        // third menu
        
        let thirdMenu = addThirdMenu();
        
        frame3 = CGRect(x: self.view.frame.size.width/2 - 131, y: (frameSub2.origin.y + frameSub2.size.height) + 50, width: 262, height: 17);
        thirdSet = create3rdSet(frame: frame3, title: thirdMenu[0].value, tag: thirdMenu[0].id);
        
        i = 0;
        otherButtons = [];
        for menuName in thirdMenu where menuName.id > 301 {
            frameSub3 = CGRect(x: self.view.frame.size.width / 2 - 131, y:(thirdSet.frame.origin.y + 30) + 30 * CGFloat(i), width: 262, height: 17);
            let radioButton = create3rdSet(frame: frameSub3, title: menuName.value, tag: menuName.id );
            otherButtons.append(radioButton);
            i += 1;
        }
        
        thirdSet.otherButtons = otherButtons;
        
        //clear selections
        secondSet.isEnabled = false;
        for otherButton in secondSet.otherButtons {
            otherButton.isEnabled = false;
        }
        
        thirdSet.isEnabled = false;
        for otherButton in thirdSet.otherButtons {
            otherButton.isEnabled = false;
        }
        
    }

    private func createRadioButton(frame : CGRect, title : String, tag : Int) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 14);
        radioButton.setTitle(title, for: []);
        radioButton.setTitleColor(UIColor.black, for: []);
        radioButton.iconColor = UIColor.black;
        radioButton.indicatorColor = UIColor.black;
        radioButton.tag = tag;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(ViewController.logSelectedButton), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    private func create2ndSet(frame : CGRect, title : String, tag : Int) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 14);
        radioButton.setTitle(title, for: []);
        radioButton.setTitleColor(UIColor.black, for: []);
        radioButton.iconColor = UIColor.black;
        radioButton.indicatorColor = UIColor.black;
        radioButton.tag = tag;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(ViewController.show3rdSet), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    private func create3rdSet(frame : CGRect, title : String, tag : Int) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 14);
        radioButton.setTitle(title, for: []);
        radioButton.setTitleColor(UIColor.black, for: []);
        radioButton.iconColor = UIColor.black;
        radioButton.indicatorColor = UIColor.black;
        radioButton.tag = tag;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(ViewController.select3rdMenu), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        
        var ids:[Int] = [];
        
        switch radioButton.tag{
        case 101:
            ids = [201, 202, 206, 302];
            break;
        case 102:
            ids = [201, 301];
            break;
        case 103:
            ids = [202];
            break;
        case 204:
            ids = [304];
            break;
        case 205:
            ids = [304];
            break;
        default:
            ids = [];
        }
        
        //clear selections
        secondSet.isEnabled = true;
        secondSet.isSelected = false;
        for otherButton in secondSet.otherButtons {
            otherButton.isEnabled = true;
            otherButton.isSelected = false;
        }
        
        thirdSet.isEnabled = false;
        for otherButton in thirdSet.otherButtons {
            otherButton.isEnabled = false;
        }
        
        //filtering
        for index1 in ids {
            
            if(index1 == secondSet.tag){
                secondSet.isEnabled = false;
            }
            for radio1 in secondSet.otherButtons{
                if(index1 == radio1.tag){
                    radio1.isEnabled = false;
                }
            }
        
        }
    }
    
    @objc @IBAction private func show3rdSet(radioButton : DLRadioButton) {

        var ids:[Int] = [];

        switch radioButton.tag{
        
        case 204:
            ids = [304];
            break;
        case 205:
            ids = [304];
            break;
        default:
            ids = [];
        }
        
        if(firstSet.isSelected == true){
            ids.append(302);
        }
        
        for otherButton in firstSet.otherButtons {
            if(otherButton.tag == 202){
                if (otherButton.isSelected){
                    ids.append(301);
                }
            }
        }
        
        //clear selections
        thirdSet.isEnabled = true;
        thirdSet.isSelected = false;
        for otherButton in thirdSet.otherButtons {
            otherButton.isEnabled = true;
            otherButton.isSelected = false;
        }
        
        //filtering
        for index1 in ids {
            
            if(index1 == thirdSet.tag){
                thirdSet.isEnabled = false;
            }
            for radio2 in thirdSet.otherButtons{
                if(index1 == radio2.tag){
                    radio2.isEnabled = false;
                }
            }
            
        }
        
    }
    
    @objc @IBAction private func select3rdMenu(radioButton : DLRadioButton) {
        NSLog("%i", radioButton.tag);
    }
}

