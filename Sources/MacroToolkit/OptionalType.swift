import SwiftSyntax

/// Wraps an optional type (e.g. `Int?`).
public struct OptionalType: TypeProtocol {
    public var _baseSyntax: OptionalTypeSyntax
    public var _attributedSyntax: AttributedTypeSyntax?

    public init(_ syntax: OptionalTypeSyntax, attributedSyntax: AttributedTypeSyntax? = nil) {
        _baseSyntax = syntax
        _attributedSyntax = attributedSyntax
    }
    
    public var wrappedType: Type {
        return Type(_baseSyntax.wrappedType)
    }
}
