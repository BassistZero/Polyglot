//
//  BrainfuckModel.swift
//  Polyglot
//
//  Created by Bassist_Zero on 2/5/24.
//

final class BrainfuckModel {
    private let program = "-[------->+<]>-.--[-->+++<]>.[--->+<]>---.++[->+++<]>.++++++++++++.---.--.[->+++++<]>-.+[->++<]>.---[----->+<]>-.+++[->+++<]>++.++++++++.+++++.--------.-[--->+<]>--.+[->+++<]>+.++++++++.+[++>---<]>-."

    func getText() -> String {
        let interpreter = BrainfuckInterpreter(code: program)
        let result = interpreter.result
        return result
    }

}
