package {
    import ncollections.Heap;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertTrue;

    public class HeapTest {
        public function HeapTest() {
        }
        
        [Test]
        public function heapTest():void {
            var heap:Heap = new Heap();

            assertEquals(Heap, heap.reflection);
            assertFalse(heap.disposed);
        }

        [Test]
        public function headDisposeTest():void {
            var heap:Heap = new Heap();
                heap.dispose();

            assertTrue(heap.disposed);
        }
        
        [Test]
        public function insertTest():void {
            var heap:Heap = new Heap();
                heap.insert(1);
                heap.insert(2);
                heap.insert(3);

            assertEquals(3, heap.extractMax());
        }

        [Test]
        public function extractTest():void {
            var heap:Heap = new Heap();
                heap.insert(1);
                heap.insert(2);
                heap.insert(3);
                heap.insert(4);
                heap.insert(5);
                heap.insert(6);

            assertEquals(6, heap.extractMax());
            assertEquals(5, heap.extractMax());
            assertEquals(4, heap.extractMax());
            assertEquals(3, heap.extractMax());
            assertEquals(2, heap.extractMax());
            assertEquals(1, heap.extractMax());
        }
    }
}
