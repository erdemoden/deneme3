//
//  ViewController.swift
//  deneme3
//
//  Created by erdem öden on 22.02.2021.
//  Copyright © 2021 erdem öden. All rights reserved.
//

import UIKit
import CoreData

var gonder = "sd"
class ViewController: UIViewController , UIApplicationDelegate {
    @IBOutlet weak var isimlbl: UILabel!
    
    @IBOutlet weak var isimtxt: UITextField!
    
   
    @IBOutlet weak var soyisimlbl: UILabel!
    
    @IBOutlet weak var soyisimtxt: UITextField!
    
    @IBOutlet weak var yaslbl: UILabel!
    
    @IBOutlet weak var yastxt: UITextField!
    
    @IBOutlet weak var seguebut: UIButton!
    @IBOutlet weak var kayıtbut: UIButton!
    
    @IBOutlet weak var alertbut: UIButton!
    @IBAction func kayit(_ sender: Any) {
        
        if(!isimtxt.text!.isEmpty && !soyisimtxt.text!.isEmpty && !yastxt.text!.isEmpty){
                        do{
                            let  appdelegete = UIApplication.shared.delegate as! AppDelegate
                                  let context = appdelegete.persistentContainer.viewContext
                                  let entity = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                            entity.setValue(isimtxt.text, forKey: "isim")
                            entity.setValue(soyisimtxt.text, forKey: "soyisim")
                            entity.setValue(Int(yastxt.text!), forKey: "yas")
                            entity.setValue(UUID(), forKey: "id")

                            try context.save()
                            let alert = UIAlertController(title: "Kayıt Tamamlandı!", message: "Kayıt Ettiğiniz Kullanıcı Başarı İle Kaydedildi", preferredStyle: .alert)
                            let button = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                alert.addAction(button)
                print("Oldu")
                self.present(alert, animated: true, completion: nil)
            }
            catch{
                print("Error")
            }
        }
        else{
            print("Olmadı")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(kapat));
        view.isUserInteractionEnabled = true;
        view.addGestureRecognizer(gesture);
        let height = view.frame.size.height
        let width = view.frame.size.width
        isimlbl.frame = CGRect(x: (width/2)-50 , y: (height*20)/100-30, width: 100, height: 30)
        isimtxt.frame =  CGRect(x: (width/2)-150 , y: (height*30)/100-34, width: 300, height: 34)
        soyisimlbl.frame =  CGRect(x: (width/2)-50 , y: (height*40)/100-30, width: 100, height: 30)
        soyisimtxt.frame = CGRect(x: (width/2)-150 , y: (height*50)/100-34, width: 300, height: 34)
        yaslbl.frame =  CGRect(x: (width/2)-50 , y: (height*60)/100-30, width: 100, height: 30)
        yastxt.frame =  CGRect(x: (width/2)-150 , y: (height*70)/100-34, width: 300, height: 34)
        seguebut.frame =  CGRect(x: 5, y: (height*80)/100-35, width: 100, height: 35)
        kayıtbut.frame =  CGRect(x:width-105 , y: (height*80)/100-35, width: 100, height: 35)
        alertbut.frame =  CGRect(x:0, y: (height*90)/100-35, width: width, height: 35)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addbuttonclicked))
        // Do any additional setup after loading the view.
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let height = size.height
        let width = size.width
            isimlbl.frame = CGRect(x: (width/2)-50 , y: (height*20)/100-30, width: 100, height: 30)
                   isimtxt.frame =  CGRect(x: (width/2)-150 , y: (height*30)/100-34, width: 300, height: 34)
                   soyisimlbl.frame =  CGRect(x: (width/2)-50 , y: (height*40)/100-30, width: 100, height: 30)
                   soyisimtxt.frame = CGRect(x: (width/2)-150 , y: (height*50)/100-34, width: 300, height: 34)
                   yaslbl.frame =  CGRect(x: (width/2)-50 , y: (height*60)/100-30, width: 100, height: 30)
                   yastxt.frame =  CGRect(x: (width/2)-150 , y: (height*70)/100-34, width: 300, height: 34)
                   seguebut.frame =  CGRect(x: 5, y: (height*80)/100-35, width: 100, height: 35)
                   kayıtbut.frame =  CGRect(x:width-105 , y: (height*80)/100-35, width: 100, height: 35)
                   alertbut.frame =  CGRect(x:0, y: (height*90)/100-35, width: width, height: 35)
    }
    @objc func addbuttonclicked(){
        
    }
    @IBAction func alertcalis(_ sender: Any) {
        let alert = UIAlertController(title: "Değer Gir", message: "Lütfen Öbür sayfada görünmesini istediğiniz değeri giriniz!", preferredStyle: .alert)
        let but1 = UIAlertAction(title: "Diğer Sayfa", style: .default) { (UIAlertAction) in
            gonder = alert.textFields![0].text ?? "dsd"
             //print(gonder!)
            self.performSegue(withIdentifier: "denemeler", sender:nil)
           
        }
            alert.addTextField()
            alert.textFields![0].placeholder = "Değeri Giriniz"
            alert.addAction(but1)
        self.present(alert, animated: true, completion: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "denemeler"{
            let gidis = segue.destination as! denemeler
            gidis.Gelecekyazi = gonder
        }
    }
    
    @objc func kapat(){
        self.view.endEditing(true);
    }
    
}

