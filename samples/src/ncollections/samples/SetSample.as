package ncollections.samples {
	import ncollections.Set;
	
	import starling.display.Sprite;
	
	public final class SetSample extends Sprite {
		
		public function SetSample() {
			super();
			intersectsSample();
			diffSample();
			unionSample();
		};
		
		private function intersectsSample():void {
			var setA:Set = Set.fromList( [ 'a', 'b', 'c' ] );
			var setB:Set = Set.fromList( [ 'c', 'd', 'e' ] );
			
			var result:Set = Set.insersection(setA, setB);
			
			trace("TSet.intersectsSample()", result.list);
		};
		
		private function diffSample():void {
			var setA:Set = Set.fromList( [ 'a', 'b', 'c' ] );
			var setB:Set = Set.fromList( [ 'c', 'd', 'e' ] );
			
			var result:Set = Set.diff(setA, setB);
			
			trace("TSet.diffSample()", result.list);
		};
		
		private function unionSample():void {
			var setA:Set = Set.fromList( [ 'a', 'b', 'c' ] );
			var setB:Set = Set.fromList( [ 'c', 'd', 'e' ] );
			
			var result:Set = Set.union(setA, setB);
			
			trace("TSet.unionSample()", result.list);
		};
	};
}