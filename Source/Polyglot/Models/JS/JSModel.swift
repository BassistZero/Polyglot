//
//  JSModel.swift
//  Polyglot
//
//  Created by Bassist_Zero on 2/4/24.
//

import JavaScriptCore
import Foundation

final class JSModel {

    // MARK: - Private Properties

    private var context = JSContext()

    // MARK: - Public Methods

    func getText() -> String {
        let currentFilePath = #file
        let jsSource = currentFilePath
            .split(separator: "/")
            .dropLast()
            .joined(separator: "/")
            .appending("/jsGreeting.js")

        let contentsOfFile = try! String(String(contentsOfFile: "\(jsSource)").dropLast())

        context?.evaluateScript("\(contentsOfFile)")

        let testFunction = context?.objectForKeyedSubscript("helloFunc")
        let result = testFunction?.call(withArguments: nil)
        return String(result!.description)
    }

}
