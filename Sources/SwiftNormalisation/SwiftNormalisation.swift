
import Foundation

/// Sometimes data needs to be normalised. Use those functions for that.
public enum Normalisation {

    /// Scales value in `measure range` to a value in `scale range`.
    ///
    /// Linear transformation of a random variable:
    /// ```
    ///                                x - minMeasure
    ///  (maxScale - minScale) * ----------------------- + minScale
    ///                          maxMeasure - minMeasure
    ///  ```
    ///
    /// - Parameters:
    ///   - number: Value that should be scaled.
    ///   - minMeasure: Minimum possible value.
    ///   - maxMeasure: Maximum possible value.
    ///   - minScale: Minimum for the new range.
    ///   - maxScale: Maximum for the new range.
    /// - Returns: Normalised/scaled value in range `minScale...maxScale`.
    public static func scale(
        number: Double,
        minMeasure: Double,
        maxMeasure: Double,
        minScale: Double,
        maxScale: Double
    ) -> Double {
       (maxScale - minScale) * ( (number - minMeasure) / (maxMeasure - minMeasure) ) + minScale
    }

    /// Scales `number` between 0 and 1.
    /// - Parameters:
    ///   - number: Value that is scaled.
    ///   - min: Minimum possible value
    ///   - max: Maximum possible value.
    /// - Returns: Scaled value.
    public static func scaleFrom0To1(
        number: Double,
        from min: Double,
        to max: Double
    ) -> Double {
       scale(number: number, minMeasure: min, maxMeasure: max, minScale: 0, maxScale: 1)
    }

    /// Scales `number` between 0 and 100.
    /// - Parameters:
    ///   - number: Value that is scaled.
    ///   - measureRange: `ClosedRange` of possible values that the number must be in.
    /// - Returns: Scaled value.
    public static func scaleFrom0To100(
        number: Double,
        measureRange: ClosedRange<Double>
    ) -> Double {
        scale(
            number: number,
            minMeasure: measureRange.lowerBound,
            maxMeasure: measureRange.upperBound,
            minScale: 0,
            maxScale: 100
        )
    }
}
