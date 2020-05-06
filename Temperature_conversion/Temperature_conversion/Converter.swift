import Foundation

struct Converter {
    func conversion(from first: Measurement<Dimension>, to second: Dimension, numberOfDecimals: Int = 2) -> String {
        let result = first.converted(to: second)
        return String(format: "%.\(numberOfDecimals)f [%@]", result.value, result.unit.symbol)
    }
    
    static func dimension(for type: String) -> Dimension? {
        switch type {
        case "celsius":
            return UnitTemperature.celsius
        case "fahrenheit":
            return UnitTemperature.fahrenheit
        case "kelvin":
            return UnitTemperature.kelvin
        default:
            return nil
        }
    }
}
