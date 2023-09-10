extension Dictionary {
    func merged(with dict: [Key: Value]) -> [Key: Value] {
        var copy = self
        for (key, value) in dict {
            copy.updateValue(value, forKey: key)
        }

        return copy
    }
}
