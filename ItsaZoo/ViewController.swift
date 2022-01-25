//
//  ViewController1.swift
//  ItsaZoo
//
//  Created by Ian Yuen on 25/01/2022.
//

import UIKit
import AVFoundation

let WIDTH: Int = 414;

//class Animal: CustomStringConvertible {
//    let name: String
//    let species: String
//    let age: Int
//    let image: UIImage
//    let soundPath: String
//
//    var description: String {
//        return "Animal: name = \(name), species = \(species), age = \(age)"
//    }
//
//    init(_ name: String, _ species: String, _ age: Int,  _ image: UIImage, _ soundPath: String) {
//        self.name = name
//        self.species = species
//        self.age = age
//        self.image = image
//        self.soundPath = soundPath
//    }
//}

class ViewController: UIViewController {
    var animals: Array<Animal> = Array()
    var soundPlay: AVAudioPlayer!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let kitty = Animal("Tuna", "Cat", 1, UIImage(named: "Kitty")!, "meowed")
        let gerbil = Animal("Cheesy", "Hamster", 3, UIImage(named: "Hamster")!, "hungry")
        let doggo = Animal("Woofy", "Dog", 2, UIImage(named: "Puppy")!, "woof")
        
        animals.append(kitty)
        animals.append(doggo)
        animals.append(gerbil)
        animals.shuffle()
        
        
        self.scrollView.delegate = self
        label.text = animals[0].species
        label.sizeThatFits(CGSize(width: 414, height:130))
        
        scrollView.contentSize = CGSize(width: 1242, height:600)
        

        for i in 0...2 {
            let button = UIButton(type: .system)
            
            button.setTitle(animals[i].name, for: .normal)
            
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.frame = CGRect(x: i * WIDTH, y: 30, width: WIDTH, height: 100)
            button.titleLabel?.font =  .systemFont(ofSize: 33)
            scrollView.addSubview(button)
            
            let imageView = UIImageView(image: animals[i].image)
            let imgXPos: Int = WIDTH * i
            imageView.frame = CGRect(x: imgXPos, y: 145, width: WIDTH, height: WIDTH)
            scrollView.addSubview(imageView)
            
        }
        

        
    }
    
    @objc func buttonTapped(_ button: UIButton){
        let animalIndex = button.tag
        let animal: Animal = animals[animalIndex]
    
        //for alerts
        //        https://developer.apple.com/documentation/uikit/uialertcontroller
        let info = UIAlertController(title: animal.name, message: "This \(animal.species) is \(animal.age) year(s) old.", preferredStyle: .alert)
        //buttons
        //     http://swiftdeveloperblog.com/code-examples/create-uialertcontroller-with-ok-and-cancel-buttons-in-swift/
        info.addAction(UIAlertAction(title: NSLocalizedString("Play Sound", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Play Sound")
            
            //playing sounds
            //        https://www.hackingwithswift.com/example-code/media/how-to-play-sounds-using-avaudioplayer
            let url = Bundle.main.url(forResource: animal.soundPath, withExtension: "mp3")
            do {
                self.soundPlay = try AVAudioPlayer(contentsOf: url!)
                
            } catch  {
                print(error)
            }
            self.soundPlay.play()
            print(animal.soundPath)
            print(animal.description)
        }))
        info.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Cancel")
        }))
        self.present(info, animated: true, completion: nil)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / view.frame.width)
        let animal : Animal = animals[Int(page)]
        label.text = animal.species
        
        //fade in fade out
        //   https://developer.apple.com/documentation/swift/double/2885641-truncatingremainder
        label.alpha = abs((scrollView.contentOffset.x / view.frame.width).truncatingRemainder(dividingBy: 1) - 0.5) * 2
        print(label.alpha)
    }
}


