package {
    import ncollections.MatrixMxN;

    import org.flexunit.asserts.assertEquals;

    public class MatrixMxNTest {
        public function MatrixMxNTest() {
        }

        [Test]
        public function fromArray2x2():void {
            var array:Array =
                    [
                            [ 0, 1, 0, 1, 0, 1, 0],
                            [ 1, 0, 1, 0, 1, 0, 1],
                            [ 0, 1, 0, 1, 0, 1, 0],
                            [ 1, 0, 1, 0, 1, 0, 1],
                     ];

            var matrix:MatrixMxN = MatrixMxN.fromArray(array);

            assertEquals(0, matrix.minX);
            assertEquals(0, matrix.minY);

            assertEquals(array[0].length, matrix.maxX);
            assertEquals(array.length,    matrix.maxY);

            for (var i:int = matrix.minX; i < matrix.maxX; i++) {
                for (var j:int = matrix.minY; j < matrix.maxY; j++) {
                    assertEquals(array[j][i], matrix.take(i, j));
                }
            }
        };

        [Test]
        public function takeByPattern():void {
            var array:Array =
                    [
                        [ 2, 0, 2, 0, 2, 0, 1],
                        [ 0, 3, 0, 3, 0, 3, 0],
                        [ 4, 0, 4, 0, 4, 0, 4],
                        [ 0, 5, 0, 5, 0, 5, 0],
                    ];

            var pattern:Array =
                    [
                        [ 0, 1, 0, 1, 0 ],
                        [ 1, 0, 1, 0, 1 ],
                        [ 0, 1, 0, 1, 0 ],
                    ];

            var expected:Array = [ 2, 2, 3, 3, 4, 4 ];

            var matrix:MatrixMxN = MatrixMxN.fromArray(array);
            var result:Array     = matrix.takeByPattern(1, 1, pattern);

            assertEquals(expected.length, result.length);

            for (var i:int = 0; i < expected.length; i++) {
                assertEquals(expected[i], result[i]);
            }
        };
    }
}

