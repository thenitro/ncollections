package ndatas.grid {
	import flash.utils.Dictionary;
	
	import ndatas.MatrixMxN;
	
	import ngine.pool.Pool;
	
	public class Grid extends MatrixMxN {
		protected static var _pool:Pool = Pool.getInstance();
		
		private var _rows:Dictionary;
		
		private var _sizeX:uint;
		private var _sizeY:uint;
		
		private var _count:uint;
		
		public function Grid() {
			_count = 0;
			_rows  = new Dictionary();
		};
		
		public function get sizeX():uint {
			return _sizeX;
		};
		
		public function get sizeY():uint {
			return _sizeY;
		};
		
		public function get count():uint {
			return _count;
		};
		
		public function get reflection():Class {
			return Grid;
		};
		
		public function add(pX:uint, pY:uint, pObject:IGridObject):IGridObject {
			var cols:Dictionary = takeCols(pX);
				cols[pY] = pObject;
			
			if (pY >= _sizeY) {
				_sizeY = pY + 1;
			}
			
			if (pObject) {
				pObject.updateIndex(pX, pY);
			}
			
			_count++;
			
			return pObject;
		};
		
		public function take(pX:uint, pY:uint):IGridObject {
			var cols:Dictionary = _rows[pX];
			
			if (!cols) {
				return null;
			}
			
			return cols[pY];
		};
		
		public function remove(pX:uint, pY:uint):void {
			var  cols:Dictionary = _rows[pX];
			if (!cols) {
				return;
			}
			
			_count--;
			
			delete cols[pY];
		};
		
		public function takeCols(pX:uint):Dictionary {
			var cols:Dictionary = _rows[pX];
			
			if (!cols) {
				cols = new Dictionary();
				_rows[pX] = cols;
			}
			
			if (pX >= _sizeX) {
				_sizeX = pX + 1;
			}
			
			return cols;
		};
		
		public function swap(pObjectAX:uint, pObjectAY:uint, 
							 pObjectBX:uint, pObjectBY:uint):void {
			var objectA:IGridObject = take(pObjectAX, pObjectAY);
			var objectB:IGridObject = take(pObjectBX, pObjectBY);
			
			add(pObjectAX, pObjectAY, objectB);
			add(pObjectBX, pObjectBY, objectA);
		};
		
		public function clean():void {
			_sizeX = 0;
			_sizeY = 0;
			
			_count = 0;
		};
		
		public function clone():Grid {
			var grid:Grid = _pool.get(Grid) as Grid;
			
			if (!grid) {
				grid = new Grid();
			}
			
			for (var i:uint = 0; i < sizeX; i++) {
				for (var j:uint = 0; j < sizeY; j++) {
					if (take(i, j)) {
						grid.add(i, j, take(i, j).clone());
					}
				}
			}
			
			return grid;
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();
		};
	}
}