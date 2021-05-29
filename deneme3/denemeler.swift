//
//  denemeler.swift
//  deneme3
//
//  Created by erdem öden on 24.02.2021.
//  Copyright © 2021 erdem öden. All rights reserved.
//

import UIKit
class denemeler: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var timeyaz: UILabel!
    var Gelecekyazi = ""
     var t = 0
     var timer :Timer?
    @IBOutlet weak var resim: UIImageView!
    @IBOutlet weak var baslatbut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        resim.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    yazilbl.text = Gelecekyazi
    }
    
    @IBOutlet weak var yazilbl: UILabel!
    @IBAction func secresim(_ sender: Any) {
        let sec = UIImagePickerController()
        sec.delegate = self
        sec.sourceType = .photoLibrary
        self.present(sec, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        resim.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func hareket(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: resim)
        sender.view!.center = CGPoint(x:sender.view!.center.x + translation.x , y:sender.view!.center.y + translation.y)
        sender.setTranslation(CGPoint(x:0, y:0), in: self.view)
    }
    @IBAction func baslattimer(_ sender: Any) {
        if(baslatbut.title(for: .normal) == "Timer Başlat"){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(zaman), userInfo: nil, repeats: true)
            baslatbut.setTitle("Timer Durdur", for: .normal)
            
        }
        else if (baslatbut.title(for: .normal) == "Timer Durdur"){
            timer?.invalidate()
            baslatbut.setTitle("Timer Başlat", for: .normal)
        }
        
    }
    @objc func zaman(){
        timeyaz.text = "TIME : \(t)"
            t+=1
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
