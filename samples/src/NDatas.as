package {
	import ncollections.samples.IteratorSample;
	import ncollections.samples.SetSample;
	import ncollections.samples.TDictionarySample;
	
	import ngine.display.DocumentClass;
	
	public class NDatas extends DocumentClass {
		
		public function NDatas() {
			//super(TDictionarySample);
			//super(SetSample);
			super(IteratorSample);
		};
	};
}