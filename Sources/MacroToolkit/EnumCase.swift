import SwiftSyntax

/// An enum case from an enum declaration.
public struct EnumCase {
    public var _syntax: EnumCaseElementSyntax
    public var _decl: EnumCaseDeclSyntax

    public init(_ syntax: EnumCaseElementSyntax, _ decl: EnumCaseDeclSyntax) {
        _syntax = syntax
        _decl = decl
    }

    /// The case's name
    public var identifier: String {
        _syntax.name.withoutTrivia().description
    }

    /// The value associated with the enum case (either associated or raw).
    public var value: EnumCaseValue? {
        if let rawValue = _syntax.rawValue {
            return .rawValue(rawValue)
        } else if let associatedValue = _syntax.parameterClause {
            let parameters = Array(associatedValue.parameters)
                .map(EnumCaseAssociatedValueParameter.init)
            return .associatedValue(parameters)
        } else {
            return nil
        }
    }

    public func withoutValue() -> Self {
        EnumCase(_syntax.with(\.rawValue, nil).with(\.parameterClause, nil), _decl)
    }
    
    public var attributes: [AttributeListElement] {
        _decl.attributes.map { attribute in
            switch attribute {
                case .attribute(let attributeSyntax):
                    return .attribute(Attribute(attributeSyntax))
                case .ifConfigDecl(let ifConfigDeclSyntax):
                    return .conditionalCompilationBlock(
                        ConditionalCompilationBlock(ifConfigDeclSyntax))
            }
        }
    }
}
