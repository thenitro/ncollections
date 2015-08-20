package ncollections {
    import npooling.IReusable;

    public class Heap implements IReusable {
        private var _disposed:Boolean;
        private var _heap:Vector.<Number>;

        public function Heap() {
            _heap = new <Number>[];
            _heap.push(0);
        }

        public function get reflection():Class {
            return Heap;
        }

        public function get disposed():Boolean {
            return _disposed;
        }

        public function insert(pElement:Number):void {
            var index:int = _heap.length;

            _heap.push(pElement);

            var parent:int   = getParent(index);
            var flag:Boolean = false;

            while (!flag) {
                if (index == 1) {
                    flag = true;
                } else if (_heap[parent] > pElement) {
                    flag = true;
                } else {
                    swap(parent, index);

                    index  = parent;
                    parent = getParent(index);
                }
            }
        }

        public function extractMax():Number {
            if (!_heap.length) {
                return null;
            }

            var maxElement:Number = _heap[1];

            _heap[1] = _heap[_heap.length - 1];
            _heap.pop();

            haxHeapify(1);

            return maxElement;
        }

        public function poolPrepare():void {
            _heap.length = 0;
        }

        public function dispose():void {
            _disposed = true;
            _heap = null;
        }
        
        [Inline]
        private function swap(pA:int, pB:int):void {
            var temp:Number = _heap[pA];

            _heap[pA] = _heap[pB];
            _heap[pB] = temp;
        }

        [Inline]
        private function getParent(pI:int):int {
            return pI / 2;
        }

        [Inline]
        public function getLeft(pI:int):int {
            return pI * 2;
        }

        [Inline]
        private function getRight(pI:int):int {
            return pI * 2 + 1;
        }

        [Inline]
        private function haxHeapify(pIndex:int):void {
            var parent:int = pIndex;

            var left:int  = getLeft(pIndex);
            var right:int = getRight(pIndex);

            if (left <= _heap.length - 1 && _heap[left] > _heap[parent]) {
                parent = left;
            }

            if (right <= _heap.length - 1 && _heap[right] > _heap[parent]) {
                parent = right;
            }

            if (parent != pIndex) {
                swap(pIndex, parent);
                haxHeapify(parent);
            }
        }
    }
}
