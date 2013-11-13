package ndatas.uf {
	import ngine.pool.IReusable;
	import ngine.pool.Pool;
	
	public final class QuickFindUF implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _count:int;
		private var _data:Array;
		
		public function QuickFindUF() {
			_data = [];
		};
		
		public static function get EMPTY():QuickFindUF {
			var result:QuickFindUF = _pool.get(QuickFindUF) as QuickFindUF;
			
			if (!result) {
				result = new QuickFindUF();
				_pool.allocate(QuickFindUF, 1);
			}
			
			return result;
		};
		
		public function get reflection():Class {
			return QuickFindUF;
		};
		
		public function get count():int {
			return _count;
		};
		
		public function create(pN:int):void {
			_count = pN;
			
			for (var i:int = 0; i < pN; i++) {
				_data[i] = i;
			}
		};
		
		public function connected(pA:int, pB:int):Boolean {
			return _data[pA] == _data[pB];
		};
		
		public function union(pA:int, pB:int):void {
			var idA:int = _data[pA];
			var idB:int = _data[pB];
			
			for (var i:int = 0; i < _data.length; i++) {
				if (_data[i] == idA) {
					_data[i] = idB;
				}
			}
		};
		
		public function clean():void {
			_count = 0;
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();
		};
	}
}