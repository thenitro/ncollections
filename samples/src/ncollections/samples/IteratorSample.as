package ncollections.samples {
	import ncollections.iterators.Iterator;
	
	import starling.display.Sprite;
	
	public final class IteratorSample extends Sprite {
		
		public function IteratorSample() {
			super();
			simpleIterator();
			customIterator();
		};
		
		private function simpleIterator():void {
			for each (var i:Number in Iterator.range(10)) {
				trace("IteratorSample.simpleIterator()", i);
			}
		};
		
		private function customIterator():void {
			for each (var i:Number in Iterator.range(10, -10, 0.5)) {
				trace("IteratorSample.customIterator()", i);
			}
		};
	};
}