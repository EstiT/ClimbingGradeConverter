//
//  SettingsViewController.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2018-05-17.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var infoView: UIView!
  
    
    var schemes: [String] = ["Ewbank", "YDS",  "French", "UK", "UIAA", "Hueco", "Font"]
    var selectedScheme: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        if selectedScheme != nil{
            let indexPath = IndexPath(row: selectedScheme, section: 0)
            tableView.selectRow(at: indexPath, animated:false, scrollPosition:UITableView.ScrollPosition(rawValue: 0)!)
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: indexPath)?.tintColor = UIColor(red: 102/255, green: 11/255, blue: 19/255, alpha: 1.0)
        }
        
        infoButton.titleLabel?.textColor = UIColor(displayP3Red: 102/255, green: 11/255, blue: 19/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedScheme != nil{
            let indexPath = IndexPath(row: selectedScheme, section: 0)
            tableView.selectRow(at: indexPath, animated:false, scrollPosition:UITableView.ScrollPosition(rawValue: 0)!)
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: indexPath)?.tintColor = UIColor(red: 215/255, green: 20/255, blue: 20/255, alpha: 1.0)
        }
    }
    
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }

    @IBAction func closeSettings(_ sender: Any) {
        if let presenter = presentingViewController as? RoutesViewController {
            presenter.selectedScheme = self.selectedScheme
            presenter.selectedGrade = 0
        }
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func viewInfo(_ sender: Any) {
//        let infoView = UINib(nibName: "InfoView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
//        print("width: \(self.view.frame.width-40), height: \(self.view.frame.height-120)")
//        infoView.frame = CGRect(x: 40, y: 20, width: self.view.frame.width-40, height: self.view.frame.height-120)
//        self.view.addSubview(infoView)

        infoView.isHidden = false
    }
    
    @IBAction func closeInfo(_ sender: Any) {
       infoView.isHidden = true
    }
    
    
    
    // MARK: TABLE VIEW
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return schemes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        if UIDevice.current.userInterfaceIdiom == .pad {
            cell.label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }
        cell.selectionStyle = .none
        cell.label.text = schemes[indexPath.row]
        cell.accessoryType = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        selectedScheme = indexPath.row
        UserDefaults.standard.set(selectedScheme, forKey: "selectedScheme")
        tableView.selectRow(at: indexPath as IndexPath, animated:false, scrollPosition:UITableView.ScrollPosition(rawValue: 0)!)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.cellForRow(at: indexPath)?.tintColor = UIColor(red: 215/255, green: 20/255, blue: 20/255, alpha: 1.0)
        tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .clear
        tableView.cellForRow(at: indexPath)?.backgroundColor = .clear
    }


}
