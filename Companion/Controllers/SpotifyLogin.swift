//
//  SpotifyLogin.swift
//
//  @author Tyler Davis
//

import UIKit
import SwiftUI

struct SpotifyLogin: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        let vc = ViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
