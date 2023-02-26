//
//  Launcher.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import UIKit

class Launcher: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let startScreen = StartFactory.default()
        let storyboard = UIStoryboard(name: "StartScreen", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartScreen") as! StartScreen
        vc.presenter = startScreen.presenter
        storyboard.instantiateViewController(withIdentifier: "StartScreen")
//        present(vc, animated: true, completion: nil)
    }
}
