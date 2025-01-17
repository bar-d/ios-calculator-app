//
//  Formula.swift
//  Calculator
//
//  Created by bard on 2022/05/18.
//

struct Formula {
    var operands =  CalculatorItemQueue<Double>()
    var operators =  CalculatorItemQueue<Operator>()
    
    mutating func result() throws -> Double {
        guard var lastResult = try? operands.deQueue() else {
            throw QueueError.wrongOperands
        }
        
        while !operands.deQueueStack.isEmpty {
            guard let inputNumber = try? operands.deQueue() else {
                throw QueueError.wrongOperands
            }
            
            guard let inputOperator = try? operators.deQueue() else {
                throw QueueError.wrongOperators
            }
            
            do {
                lastResult = try  inputOperator.calculate(lhs: lastResult,
                                                          rhs: inputNumber)
            } catch {
                throw OperatorError.devideFail
            }
        }
        return lastResult
    }
}
