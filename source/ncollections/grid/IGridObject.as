package ncollections.grid {
	import npooling.IReusable;

	public interface IGridObject extends IReusable {
		function get indexX():int;
		function get indexY():int;
		
		function updateIndex(pX:int, pY:int):void;
		
		function clone():IGridObject;
	};
};