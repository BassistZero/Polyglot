//
//  BrainfuckInterpreter.swift
//  Polyglot
//
//  Created by Bassist_Zero on 2/5/24.
//

class BrainfuckInterpreter {
    private var data = Array(repeating: 0, count: 30000)
    private var dataPointer = 0
    private var instructionPointer = 0
    private var commands = [Command]()
    var result = ""

    init(code: String) {
        // Parse the Brainfuck code into commands here
        self.commands = parse(code)
        run()
    }

    private func run() {
        while instructionPointer < commands.count {
            switch commands[instructionPointer] {
            case .incrementData:
                data[dataPointer] = (data[dataPointer] + 1) % 256
            case .decrementData:
                data[dataPointer] = (data[dataPointer] - 1 + 256) % 256
            case .incrementDataPointer:
                dataPointer = (dataPointer + 1) % data.count
            case .decrementDataPointer:
                dataPointer = (dataPointer - 1 + data.count) % data.count
            case .outputData:
                let rawData = data[dataPointer]
                let unicodeData = UnicodeScalar(rawData)!
                let character = Character(unicodeData)
                result.append(character)
            case .jumpForward(let index):
                if data[dataPointer] == 0 {
                    instructionPointer = index
                }
            case .jumpBackward(let index):
                if data[dataPointer] != 0 {
                    instructionPointer = index
                }
            }

            instructionPointer += 1
        }
    }


    private func parse(_ code: String) -> [Command] {
        var commands: [Command] = []
        var stack: [(index: Int, depth: Int)] = []
        var depth = 0

        for (index, character) in code.enumerated() {
            switch character {
            case "+":
                commands.append(.incrementData)
            case "-":
                commands.append(.decrementData)
            case ">":
                commands.append(.incrementDataPointer)
            case "<":
                commands.append(.decrementDataPointer)
            case ".":
                commands.append(.outputData)
            case "[":
                stack.append((index, depth))
                depth += 1
                commands.append(.jumpForward(0)) // Placeholder index, filled later
            case "]":
                guard let pairIndex = stack.lastIndex(where: { $0.depth == depth - 1 }) else {
                    fatalError("Mismatched brackets")
                }
                let startIndex = stack[pairIndex].index
                commands[startIndex] = .jumpForward(commands.count)
                commands.append(.jumpBackward(startIndex))
                stack.removeLast()
                depth -= 1
            default:
                break
            }
        }

        if !stack.isEmpty {
            fatalError("Mismatched brackets")
        }

        return commands
    }
}

enum Command {
    case incrementData
    case decrementData
    case incrementDataPointer
    case decrementDataPointer
    case outputData
    case jumpForward(Int)
    case jumpBackward(Int)
}
