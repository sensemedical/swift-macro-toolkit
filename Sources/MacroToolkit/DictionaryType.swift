import SwiftSyntax

/// Wraps a dictionary type (e.g. `[Int: String]`).
public struct DictionaryType: TypeProtocol {
    public var _baseSyntax: DictionaryTypeSyntax
    public var _attributedSyntax: AttributedTypeSyntax?

    public init(_ syntax: DictionaryTypeSyntax, attributedSyntax: AttributedTypeSyntax? = nil) {
        _baseSyntax = syntax
        _attributedSyntax = attributedSyntax
    }
    
    public var key: Type {
        return Type(_baseSyntax.key)
    }
    
    public var value: Type {
        return Type(_baseSyntax.value)
    }
}
