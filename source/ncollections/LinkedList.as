package ncollections {
	import flash.utils.Dictionary;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class LinkedList implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _header:Object;
		
		private var _prev:Dictionary;
		private var _next:Dictionary;
		
		private var _count:int;
		
		public function LinkedList() {
			_count = 0;
			
			_header = {};
			
			_prev = new Dictionary();
			_next = new Dictionary();
			
			_next[_header] = _prev[_header] = _header;
		};
		
		public static function get EMPTY():LinkedList {
			var result:LinkedList = _pool.get(LinkedList) as LinkedList;
			
			if (!result) {
				result = new LinkedList();
				_pool.allocate(LinkedList, 1);
			}
			
			return result;
		};
		
		public function get reflection():Class {
			return LinkedList;
		};
		
		public function get count():int {
			return _count;
		}
		
		public function contains(pItem:*):Boolean {
			return _next[pItem] || _prev[pItem];
		};
		
		public function get first():* {
			return _next[_header];
		};
		
		public function get last():* {			
			return _prev[_header];
		};
		
		public function add(pItem:*):void {
			if (contains(pItem)) {
				return;
			}
			
			_prev[pItem] = _prev[_header];
			_next[pItem] =_header;
			
			_next[_prev[pItem]] = pItem;
			_prev[_header] = pItem;
			
			_count++;
		};
		
		public function remove(pItem:*):void {
			if(!contains(pItem)) {
				return;
			}
			
			_next[_prev[pItem]] = _next[pItem];
			_prev[_next[pItem]] = _prev[pItem];
			
			delete _prev[pItem];
			delete _next[pItem];
			
			_count--;
		};
		
		public function next(pItem:*):* {
			return _next[pItem];
		};
		
		public function prev(pItem:*):* {
			return _prev[pItem];
		};
		
		public function clean():void {
			_next[_header] = _prev[_header] = _header;
			
			var id:Object;
			var temp:Array = [];
			
			for (id in _next) {
				temp.push(id);
			}
			
			for (id in temp) {
				delete _next[id];
			}
			
			for (id in temp) {
				delete _prev[id];
			}
			
			temp = null;
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			_header = null;
			
			_prev = null;
			_next = null;
		};
	}
}