package ndatas.uf {
	import ngine.pool.IReusable;
	import ngine.pool.Pool;
	
	public final class QuickUnionUF implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _count:int;
		private var _data:Array;
		
		public function QuickUnionUF() {
			_data = [];
		};
		
		public static function get EMPTY():QuickUnionUF {
			var result:QuickUnionUF = _pool.get(QuickUnionUF) as QuickUnionUF;
			
			if (!result) {
				result = new QuickUnionUF();
				_pool.allocate(QuickUnionUF, 1);
			}
			
			return result;
		};
		
		public function get reflection():Class {
			return QuickUnionUF;
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
		
		public function root(pI:int):int {
			while (pI != _data[pI]) {
				pI = _data[pI]
			}
			
			return pI;
		};
		
		public function connected(pA:int, pB:int):Boolean {
			return root(pA) == root(pB);
		};
		
		public function union(pA:int, pB:int):void {
			var idA:int = root(pA);
			var idB:int = root(pB);
			
			_data[idA] = idB;
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