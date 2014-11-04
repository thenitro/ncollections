package ncollections {
	import flash.utils.Dictionary;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public class MatrixMxN implements IReusable {
		protected static var _pool:Pool = Pool.getInstance();

        private var _disposed:Boolean;

		private var _rows:Dictionary;

        private var _minX:int;
        private var _minY:int;

		private var _maxX:int;
		private var _maxY:int;
		
		private var _count:int;
		
		private var _items:Set;
		
		public function MatrixMxN() {
			_count = 0;
			_rows  = new Dictionary();
			_items = Set.EMPTY;
		};
		
		public static function get EMPTY():MatrixMxN {
			var result:MatrixMxN = _pool.get(MatrixMxN) as MatrixMxN;
			
			if (!result) {
				_pool.allocate(MatrixMxN, 1);
				result = new MatrixMxN();
			}
			
			return result;
		};
		
		public function get minX():int {
			return _minX;
		};
		
		public function get minY():int {
			return _minY;
		};

		public function get maxX():int {
			return _maxX;
		};

		public function get maxY():int {
			return _maxY;
		};

		public function get count():int {
			return _count;
		};
		
		public function get reflection():Class {
			return MatrixMxN;
		};

        public function get disposed():Boolean {
            return _disposed;
        };

		public function get items():Set {
			return _items;
		};
		
		public function add(pX:int, pY:int, pObject:Object):Object {
			var cols:Dictionary = takeCols(pX);
				cols[pY] = pObject;

            if (pY < _minY) {
                _minY = pY;
            }

			if (pY > _maxY) {
				_maxY = pY;
			}
			
			_count++;
			
			_items.add(pObject);
			
			return pObject;
		};
		
		public function take(pX:int, pY:int):Object {
			var cols:Dictionary = _rows[pX] as Dictionary;
			
			if (!cols) {
				return null;
			}
			
			return cols[pY] as Object;
		};
		
		public function remove(pX:int, pY:int):void {
			var cols:Dictionary = _rows[pX];
			
			if (!cols) {
				return;
			}
			
			_count--;
			
			_items.remove(cols[pY]);
			
			delete cols[pY];
		};
		
		public function takeCols(pX:int):Dictionary {
			var cols:Dictionary = _rows[pX];
			
			if (!cols) {
				cols = new Dictionary();
				_rows[pX] = cols;
			}

            if (pX < _minX) {
                _minX = pX;
            }
			
			if (pX > _maxX) {
				_maxX = pX;
			}
			
			return cols;
		};
		
		public function swap(pObjectAX:int, pObjectAY:int, 
							 pObjectBX:int, pObjectBY:int):void {
			var objectA:Object = take(pObjectAX, pObjectAY);
			var objectB:Object = take(pObjectBX, pObjectBY);
			
			add(pObjectAX, pObjectAY, objectB);
			add(pObjectBX, pObjectBY, objectA);
		};
		
		public function clean():void {
            _minY = 0;
            _minX = 0;

			_maxX = 0;
			_maxY = 0;
			
			_count = 0;
			
			_rows = new Dictionary();
		};
		
		public function clone():MatrixMxN {
			var result:MatrixMxN = _pool.get(MatrixMxN) as MatrixMxN;
			
			if (!result) {
				result = new MatrixMxN();
			}
			
			for (var i:int = 0; i < maxX; i++) {
				for (var j:int = 0; j < maxY; j++) {
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

            _disposed = true;
		};
	}
}