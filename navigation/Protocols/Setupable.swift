//
//  Setupable.swift
//  navigation
//
//  Created by Max Egorov on 3/26/22.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
