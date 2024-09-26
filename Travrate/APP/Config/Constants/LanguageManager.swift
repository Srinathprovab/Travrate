//
//  LanguageManager.swift
//  Travrate
//
//  Created by Admin on 25/09/24.
//

import Foundation
import UIKit


class LanguageManager {

    static let shared = LanguageManager()

    private init() {}

    func setLanguage(_ lang: String) {
        defaults.set([lang], forKey: "AppleLanguages")
        defaults.synchronize()

        // Reload app to apply the new language
        guard let window = UIApplication.shared.keyWindow else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateInitialViewController()
        window.rootViewController = rootViewController

        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: {}, completion: nil)
    }

    func currentLanguage() -> String {
        return defaults.stringArray(forKey: "AppleLanguages")?.first ?? "en"
    }
}
