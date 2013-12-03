package ncollections {
	import flash.utils.Dictionary;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class TDictionary implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _keys:Set;
		private var _values:Set;
		
		private var _raw:Dictionary;
		
		private var _count:int;
		
		public function TDictionary() {
			_keys   = Set.EMPTY;
			_values = Set.EMPTY;
			
			_raw  = new Dictionary();
			
			_count = 0;
		};
		
		public static function get EMPTY():TDictionary {
			var result:TDictionary = _pool.get(TDictionary) as TDictionary;
			
			if (!result) {
				result = new TDictionary();
				_pool.allocate(TDictionary, 1);
			}
			
			return result;
		};
		
		public static function zip(pArrayA:Array, 
								   pArrayB:Array):TDictionary {
			if (pArrayA.length != pArrayB.length) {
				return null;
			}
			
			var result:TDictionary = EMPTY;
				
			for (var i:int = 0; i < pArrayA.length; i++) {
				result.add(pArrayA[i], pArrayB[i]);
			}
			
			return result;
		};
		
		public function get reflection():Class {
			return TDictionary;
		};
		
		public function get count():int {
			return _count;
		};
		
		public function get keys():Set {
			return _keys;
		};
		
		public function get values():Set {
			return _values;
		};
		
		public function add(pKey:*, pValue:*):void {
			if (!_keys.contains(pKey)) {
				_count++;
			}
			
			_keys.add(pKey);
			_values.add(pValue);
			
			_raw[pKey] = pValue;
		};
		
		public function get(pKey:*):* {
			return _raw[pKey];
		};
		
		public function remove(pKey:*):void {
			if (!_keys.contains(pKey)) {
				return;
			}
			
			_count--;
			
			_keys.remove(pKey);
			_values.remove(_raw[pKey]);
			
			delete _raw[pKey];
		};
		
		public function clone():TDictionary {
			var result:TDictionary = EMPTY;
				
			for (var id:* in _raw) {
				result.add(id, _raw[id]);
			}
			
			return result;
		};
 		
		public function clean():void {
			for each (var key:* in _keys.list) {
				delete _raw[key];
			}
			
			_keys.clean();
			_values.clean();
			
			_count = 0;
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();
			
			_pool.put(_keys);
			_pool.put(_values);
			
			_raw = null;
		};
	};
}