package {
    import flash.display.Sprite;

    import org.flexunit.internals.TraceListener;

    import org.flexunit.runner.FlexUnitCore;

    public class Main extends Sprite {
        private var _testCore:FlexUnitCore;

        public function Main() {
            _testCore = new FlexUnitCore();
            _testCore.addListener(new TraceListener());
            _testCore.run(MatrixMxNTest);
        };
    }
}
