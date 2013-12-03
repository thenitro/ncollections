package ncollections {
	import flash.utils.Dictionary;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class Set implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _hash:Dictionary;
		private var _list:Array;
		
		private var _count:int;
		
		public function Set() {
			_hash = new Dictionary();
			_list = [];
		};
		
		public static function get EMPTY():Set {
			var result:Set = _pool.get(Set) as Set;
			
			if (!result) {
				result = new Set();
				_pool.allocate(Set, 1);
			}
			
			return result;
		};
		
		public static function fromList(pList:Array):Set {
			var result:Set = Set.EMPTY;
				result.fromList(pList);
				
			return result;
		};
		
		public function get reflection():Class {
			return Set;
		}
		
		public function get dict():Dictionary {
			return _hash;
		};
		
		public function get list():Array {
			return _list;
		};
		
		public function get count():int {
			return _count;
		};
		
		public function fromList(pList:Array):void {
			for each (var object:Object in pList) {
				add(object);
			}
		};
		
		public function add(pData:Object):void {
			if (contains(pData)) {
				return;
			}
			
			_hash[pData] = true;
			_list.push(pData);
			
			_count++;
		};
		
		public function remove(pData:Object):void {
			if (!contains(pData)) {
				return;
			}
			
			delete _hash[pData];
			_list.splice(_list.indexOf(pData), 1);
			
			_count--;
		};
		
		public function contains(pTarget:Object):Boolean {
			return Boolean(_hash[pTarget]);
		};
		
		public function clean():void {
			for (var data:Object in _list) {
				delete _hash[data];
			}
			
			_list.length = 0;
			_count = 0;
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();
			
			_hash = null;
			_list = null;
		};
	}
}