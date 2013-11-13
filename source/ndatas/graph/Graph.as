package ndatas.graph {
	import flash.utils.Dictionary;
	
	import ndatas.MatrixMxN;
	import ndatas.Set;
	
	import ngine.pool.IReusable;
	import ngine.pool.Pool;
	
	public final class Graph implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _vData:Set;
		private var _adjacency:MatrixMxN;
		
		private var _v:int;
		private var _e:int;
		
		public function Graph() {
			_vData     = Set.EMPTY;
			_adjacency = MatrixMxN.EMPTY;
		};
		
		public static function get EMPTY():Graph {
			var result:Graph = _pool.get(Graph) as Graph;
			
			if (!result) {
				_pool.allocate(Graph, 1);
				result = new Graph();
			}
			
			return result;
		};
		
		public static function degree(pG:Graph, pV:int):int {
			var result:int = 0;
			
			for (var obj:Object in pG.adj(pV)) {
				result++;
			}
			
			return result;
		};
		
		public static function maxDegree(pG:Graph):int {
			var result:int = 0;
			
			for (var v:int = 0; v < pG.v; v++) {
				var current:int = degree(pG, v); 
				
				if (current > result) {
					result = current;
				}
			}
			
			return result;
		};
		
		public static function averageDegree(pG:Graph):Number {
			return 2.0 * pG.e / pG.v;
		};
		
		public static function numberOfSelfLoops(pG:Graph):int {
			var result:int = 0;
			
			for (var v:int = 0; v < pG.v; v++) {
				for (var w:int in pG.adj(v)) {
					if (v == w) {
						result++;
					}
				}
			}
			
			return result / 2;
		};
		
		public function get reflection():Class {
			return Graph;
		};
		
		public function get v():int {
			return _v;
		};
		
		public function get e():int {
			return _e;
		};
		
		public function create(pV:int):void {
			_v = pV;
			
			for (var i:int = 0; i < v; i++) {
				_vData.add(i);
			}
		};
		
		public function addEdge(pV:int, pW:int):void {
			if (pV > _v || pW > _v) {
				return;
			}
			
			_adjacency.add(pV, pW, 1);
			_adjacency.add(pW, pV, 1);
		};
		
		public function adj(pV:int):Dictionary {		
			return _adjacency.takeCols(pV);
		};
		
		public function clean():void {
			_vData.clean();
			_adjacency.clean();
			
			_v = 0;
			_e = 0;
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			_pool.put(_adjacency);
			_pool.put(_vData);
			
			_vData     = null;
			_adjacency = null;
		};
	}
}