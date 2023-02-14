
import Foundation
import XCTest
import SnapshotTesting
import SwiftNormalisation

final class NormalisationScaleNumberTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        isRecording = false
    }

    override func tearDownWithError() throws {
        isRecording = false
        try super.tearDownWithError()
    }

    func test_scale_form80_100_to_0_100() {

        // Arrange
        let inputs: [Double] = Array(80...100).map( Double.init )

        // Act
        let normalised = inputs
            .map { number in
                Normalisation
                    .scale(
                        number: number,
                        minMeasure: 80,
                        maxMeasure: 100,
                        minScale: 0,
                        maxScale: 100
                    )
            }

        // Assert
        assertSnapshot(
            matching: Array(zip(inputs, normalised)).map { "\(max2Trailing: $0) was scaled to: \(max2Trailing: $1)" },
            as: .dump
        )
    }

    func test_scale_form0_100_to_0_100() {

        // Arrange
        let measureRange = 0...100
        let inputs: [Double] = Array(measureRange).map( Double.init )

        // Act
        let normalised = inputs
            .map { number in
                Normalisation
                    .scale(
                        number: number,
                        minMeasure: Double(measureRange.min()!),
                        maxMeasure: Double(measureRange.max()!),
                        minScale: 0,
                        maxScale: 100
                    )
            }

        // Assert
        assertSnapshot(
            matching: Array(zip(inputs, normalised)).map { "\(max2Trailing: $0) was scaled to: \(max2Trailing: $1)" },
            as: .dump
        )
    }

    func test_scale_formMinus100_100_to_minus100_100() {
        // Arrange
        let measureRange = -100...100
        let inputs: [Double] = Array(measureRange).map( Double.init )

        // Act
        let normalised = inputs
            .map { number in
                Normalisation
                    .scale(
                        number: number,
                        minMeasure: Double(measureRange.min()!),
                        maxMeasure: Double(measureRange.max()!),
                        minScale: -100,
                        maxScale: 100
                    )
            }

        // Assert
        assertSnapshot(
            matching: Array(zip(inputs, normalised)).map { "\(max2Trailing: $0) was scaled to: \(max2Trailing: $1)" },
            as: .dump
        )
    }

    func test_scale_formMinus100_100_to_0_200() {
        // Arrange
        let measureRange = -100...100
        let inputs: [Double] = Array(measureRange).map( Double.init )

        // Act
        let normalised = inputs
            .map { number in
                Normalisation
                    .scale(
                        number: number,
                        minMeasure: Double(measureRange.min()!),
                        maxMeasure: Double(measureRange.max()!),
                        minScale: 0,
                        maxScale: 200
                    )
            }

        // Assert
        assertSnapshot(
            matching: Array(zip(inputs, normalised)).map { "\(max2Trailing: $0) was scaled to: \(max2Trailing: $1)" },
            as: .dump
        )
    }
}

fileprivate let formatter: NumberFormatter = {
    let form = NumberFormatter()

    form.numberStyle = .decimal
    form.usesSignificantDigits = false
    form.roundingMode = .down
    form.minimumFractionDigits = 2
    form.maximumFractionDigits = 2
    form.decimalSeparator = "."

    return form
}()

fileprivate extension String.StringInterpolation {

    mutating func appendInterpolation(max2Trailing number: Double) {

       formatter
            .string(from: .init(value: number) )
            .map { formattedNumber in
                self.appendLiteral( formattedNumber )
            }
    }
}
