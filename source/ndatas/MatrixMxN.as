package ndatas {
	import flash.utils.Dictionary;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public class MatrixMxN implements IReusable {
		protected static var _pool:Pool = Pool.getInstance();
		
		private var _rows:Dictionary;
		
		private var _sizeX:uint;
		private var _sizeY:uint;
		
		private var _count:uint;
		
		public function MatrixMxN() {
			_count = 0;
			_rows  = new Dictionary();
		};
		
		public static function get EMPTY():MatrixMxN {
			var result:MatrixMxN = _pool.get(MatrixMxN) as MatrixMxN;
			
			if (!result) {
				_pool.allocate(MatrixMxN, 1);
				result = new MatrixMxN();
			}
			
			return result;
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
			return MatrixMxN;
		};
		
		public function add(pX:uint, pY:uint, pObject:Object):Object {
			var cols:Dictionary = takeCols(pX);
				cols[pY] = pObject;
			
			if (pY >= _sizeY) {
				_sizeY = pY + 1;
			}
			
			_count++;
			
			return pObject;
		};
		
		public function take(pX:uint, pY:uint):Object {
			var cols:Dictionary = _rows[pX];
			
			if (!cols) {
				return null;
			}
			
			return cols[pY];
		};
		
		public function remove(pX:uint, pY:uint):void {
			var cols:Dictionary = _rows[pX];
			
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
			var objectA:Object = take(pObjectAX, pObjectAY);
			var objectB:Object = take(pObjectBX, pObjectBY);
			
			add(pObjectAX, pObjectAY, objectB);
			add(pObjectBX, pObjectBY, objectA);
		};
		
		public function clean():void {
			_sizeX = 0;
			_sizeY = 0;
			
			_count = 0;
			
			_rows = new Dictionary();
		};
		
		public function clone():MatrixMxN {
			var result:MatrixMxN = _pool.get(MatrixMxN) as MatrixMxN;
			
			if (!result) {
				result = new MatrixMxN();
			}
			
			for (var i:uint = 0; i < sizeX; i++) {
				for (var j:uint = 0; j < sizeY; j++) {
					if (take(i, j)) {
						result.add(i, j, take(i, j).clone());
					}
				}
			}
			
			return result;
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();
		};
	}
}