//
//  Binder.swift
//  Core
//
//  Created by Paulo Correa on 13/11/2564 BE.
//


final public class Binder<Element> {
    public var listener: ((Element) -> Void)?

    public var value: Element {
        didSet { listener?(value) }
    }

    public init(_ value: Element) {
        self.value = value
    }

    public func bind(listener: ((Element) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
