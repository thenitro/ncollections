package ndatas.uf {
	import ngine.pool.IReusable;
	import ngine.pool.Pool;
	
	public final class BalancedQuickUnionUF implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _count:int;
		private var _data:Array;
		private var _sizes:Array;
		
		public function BalancedQuickUnionUF() {
			_data  = [];
			_sizes = [];
		};
		
		public static function get EMPTY():QuickUnionUF {
			var result:BalancedQuickUnionUF = _pool.get(BalancedQuickUnionUF) as BalancedQuickUnionUF;
			
			if (!result) {
				result = new BalancedQuickUnionUF();
				_pool.allocate(BalancedQuickUnionUF, 1);
			}
			
			return result;
		};
		
		public function get reflection():Class {
			return BalancedQuickUnionUF;
		};
		
		public function get count():int {
			return _count;
		};
		
		public function create(pN:int):void {
			_count = pN;
			
			for (var i:int = 0; i < pN; i++) {
				_data[i]  = i;
				_sizes[i] = 1;
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
			
			if (_sizes[idA] < _sizes[idB]) {
				_data[idA]   = idB;
				_sizes[idB] += _sizes[idA];
			} else {
				_data[idB]   = idA;
				_sizes[idA] += _sizes[idB];
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