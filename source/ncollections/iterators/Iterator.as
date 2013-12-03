package ncollections.iterators {
	import flash.errors.IllegalOperationError;
	
	public final class Iterator {
		
		public function Iterator() {
			throw new IllegalOperationError('Iterator is static');
		};
		
		public static function range(pTO:Number, 
									 pFrom:Number = 0, pSeed:Number = 1):Array {
			var result:Array = [];
			
			for (var i:Number = pFrom; i < pTO; i += pSeed) {
				result.push(i);
			}
			
			return result;
		};
	}
}