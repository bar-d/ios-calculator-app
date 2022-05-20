//
//  Formula.swift
//  Calculator
//
//  Created by 김동용 on 2022/05/18.
//

struct Formula {
    var operands =  CalculatorItemQueue<Double>()
    var operators =  CalculatorItemQueue<Operator>()
    
    mutating func result() throws -> Double {
        guard var lastResult = try? operands.deQueue() else { throw QueueError.operands }
        
        while operands.joinedQueue.isEmpty != true {
            guard let inputNumber = try? operands.deQueue() else
            { throw QueueError.operands }
            
            guard let inputOperator = try? operators.deQueue() else
            { throw QueueError.operators }
            
            lastResult = try inputOperator.calculate(lhs: lastResult,
                                                     rhs: inputNumber)
        }
        return lastResult
    }
}