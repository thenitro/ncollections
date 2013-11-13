package ndatas.grid {
	import npooling.IReusable;

	public interface IGridObject extends IReusable {
		function get indexX():uint;
		function get indexY():uint;
		
		function updateIndex(pX:uint, pY:uint):void;
		
		function clone():IGridObject;
	};
};