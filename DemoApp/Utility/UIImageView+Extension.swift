//
//  UIImageView+Extension.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL?) {
        if let imageUrl = url {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        } else {
            self.image = UIImage(systemName: "person.circle.fill")
        }
    }
}
