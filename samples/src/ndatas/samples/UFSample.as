package ndatas.samples {
	import flash.geom.Point;
	
	import ndatas.uf.QuickFindUF;
	
	import ngine.math.Random;
	
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public final class UFSample extends Sprite {
		
		public function UFSample() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
		};
		
		private function addedToStageEventHandler(pEvent:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
			
			var data:QuickFindUF = QuickFindUF.EMPTY;
				data.create(10);
				
			//connect random dots
			for (var i:int = 0; i < data.count; i += 2) {
				var a:int = i;
				var b:int = i + 1;
				
				if (Random.probability(50)) {
					if (!data.connected(a, b)) {
						trace("UFSample.addedToStageEventHandler(pEvent) unite", a, b);
						data.union(a, b);
					}
				}
			}
			
			for (i = 0; i < data.count; i += 2) {
				trace("UFSample.addedToStageEventHandler(pEvent)", i, i + 1, data.connected(i, i + 1));
			}
		};
	};
}