
#warning("This is temp, if all types in this folder no longer use Never as a response we can delete it")
extension Never: Codable {
    public init(from decoder: Decoder) throws { fatalError() }
    public func encode(to encoder: Encoder) throws { fatalError() }
}
