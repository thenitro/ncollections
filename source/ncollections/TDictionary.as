package ncollections {
	import flash.utils.Dictionary;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class TDictionary implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _keys:Set;
		private var _values:Array;
		
		private var _raw:Dictionary;
		
		private var _count:int;
		
		public function TDictionary() {
			_keys   = Set.EMPTY;
			_values = [];
			
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
		
		public function get values():Array {
			return _values;
		};
		
		public function add(pKey:*, pValue:*):void {
            if (_raw[pKey] === pValue) {
				return;
            }

			if (_keys.contains(pKey)) {
				_values.splice(_values.indexOf(_raw[pKey]), 1, pValue);
			} else {
				_keys.add(pKey);
                _values.push(pValue);

                _count++;
            }

            _raw[pKey] = pValue;
		};
		
		public function get(pKey:*, pDefault:* = null):* {
			return _raw[pKey] || pDefault;
		};
		
		public function remove(pKey:*):void {
			if (!_keys.contains(pKey)) {
				return;
			}
			
			_count--;
			
			_keys.remove(pKey);
			_values.splice(_values.indexOf(_raw[pKey]), 1);
			
			delete _raw[pKey];
		};
		
		public function contains(pKey:*):Boolean {
			return Boolean(_keys.contains(pKey));
		};
		
		public function clone():TDictionary {
			var result:TDictionary = EMPTY;
				
			for (var id:* in _raw) {
				result.add(id, _raw[id]);
			}
			
			return result;
		};
 		
		public function clean():void {
			var keys:Array = _keys.list.concat();
			
			for each (var key:* in keys) {
				remove(key);
			}
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();
			
			_pool.put(_keys);
			
			_values = null;
			_raw    = null;
		};
	};
}