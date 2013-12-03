package ncollections.samples {
	import ncollections.TDictionary;
	
	import starling.display.Sprite;
	
	public final class TDictionarySample extends Sprite {
		
		public function TDictionarySample() {
			super();
			zipSample();
		};
		
		private function zipSample():void {
			var dict:TDictionary = TDictionary.zip( [ 'a', 'b', 'c' ], 
													[ 1, 2, 3 ] );
			
			trace("TDictionarySample.zipSample() keys",   dict.keys.list);
			trace("TDictionarySample.zipSample() values", dict.values.list);
			
			var dict2:TDictionary = TDictionary.zip( [ 1, 2, 3 ], 
													 [ 'a', 'b', 'c' ] );
			
			trace("TDictionarySample.zipSample() keys",   dict2.keys.list);
			trace("TDictionarySample.zipSample() values", dict2.values.list);
		};
	};
}