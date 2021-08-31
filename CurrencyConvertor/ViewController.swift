//
//  ViewController.swift
//  CurrencyConvertor
//
//  Created by owaish on 30/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inrLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var aedLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        let url  = URL(string: "http://data.fixer.io/api/latest?access_key=4c53547f8fe5b2d6e589330da8484b46")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //Async
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let inr = rates["INR"] as? Double {
                                    self.inrLabel.text = "INR : \(inr)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                
                                if let aed = rates["AED"] as? Double {
                                    self.aedLabel.text = "AED : \(aed)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                            }
                        }
                        
                    } catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
        
    }
    
}

