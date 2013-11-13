package ndatas.samples {
	import starling.display.Sprite;
	import starling.events.Event;
	
	public final class SimpleGraph extends Sprite {
		
		public function SimpleGraph() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
		};
		
		private function addedToStageEventHandler(pEvent:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
		};
	};
}