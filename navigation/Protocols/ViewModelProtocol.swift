//
//  ViewModelProtocol.swift
//  navigation
//
//  Created by Max Egorov on 2/28/22.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
