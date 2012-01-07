package model 
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import com.greensock.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	
	/**
	 * ...
	 * @author Vanja Jelic
	 */
	public class ImageDataProxy extends Proxy implements IProxy 
	{
		
		// Cannonical name of the Proxy
        public static const NAME:String = 'ImageDataProxy';
		
		private var _prevIndex:int;
		private var _imageIndex:int = 1;
		private var _numImages:int = 10;
		
		// Constructor 
        public function ImageDataProxy() {
            super(NAME); // pass the cannonical name to the superclass
        }
		
		public function loadImages():void {
			var queue:LoaderMax = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			for (var i:int = 1; i <= _numImages; i++){ 
				queue.append( new ImageLoader("assets/image"+i+".jpg", {name:"photo"+i, estimatedBytes:2400, container:this, scaleMode:"proportionalInside"}) );
			}
			LoaderMax.prioritize("photo1");  			 

			queue.load();
 
		}
		
		public function nextImage():void {
			if(_imageIndex < _numImages) {
				_prevIndex = _imageIndex;
				_imageIndex++;
			} else {
				_imageIndex = 1;
				_prevIndex = 10;
			}
			trace("[PROXY] " + _imageIndex);
			sendNotification(ApplicationFacade.INDEX_UPDATE, imageIndex);			
		}
		
		public function get imageIndex():int 
		{
			return _imageIndex;
		}
		
		public function set imageIndex(value:int):void 
		{
			_imageIndex = value;
		}
		
		public function get prevIndex():int 
		{
			return _prevIndex;
		}
		
		public function set prevIndex(value:int):void 
		{
			_prevIndex = value;
		}

		private function progressHandler(event:LoaderEvent):void {
			trace("progress: " + event.target.progress);
		}
		 
		private function completeHandler(event:LoaderEvent):void {
			sendNotification(ApplicationFacade.LOAD_COMPLETE, LoaderMax);
			trace(event.target + " is complete!");
		}
		 
		private function errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
	}
}

