package view 
{
	import com.greensock.loading.display.ContentDisplay;
	import com.greensock.loading.LoaderMax;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	
	/**
	 * ...
	 * @author Vanja Jelic
	 */
	public class StageMediator extends Mediator implements IMediator 
	{		
	   	// Cannonical name of the Mediator
        public static const NAME:String = 'StageMediator';
		private var stage:Stage;
		private var image:ContentDisplay;
		private var gallery:Sprite = new Sprite();
        
        public function StageMediator(viewComponent:*) {
		    // pass the viewComponent to the superclass
            super(viewComponent);
			this.stage = viewComponent;
            this.stage.addChild(gallery);
			gallery.alpha = 0;
            // Listen for events from the view component 
			viewComponent.addEventListener(MouseEvent.CLICK, onClickEvent);
        }
		
		private function onClickEvent(e:MouseEvent):void {
            sendNotification(ApplicationFacade.MOUSEDOWN, "click click");
		}
		
		/* INTERFACE org.puremvc.as3.interfaces.IMediator */
		
		override public function getMediatorName():String {
			return NAME;
		}
		
		// Return list of Nofitication names that Mediator is interested in
		override public function listNotificationInterests():Array {
			return [ApplicationFacade.LOAD_COMPLETE, ApplicationFacade.INDEX_UPDATE ];
		}
		
		// Handle all notifications this Mediator is interested in
		override public function handleNotification(note:INotification):void  {
			switch (note.getName()) {
				case ApplicationFacade.LOAD_COMPLETE:
					var loader:Object = note.getBody();
					trace("[STAGE MEDIATOR ]" + loader);
					image = LoaderMax.getContent("photo1");
					gallery.addChild(image);
					TweenLite.to(gallery, 1, {alpha:1, y:100});
					break;
				case ApplicationFacade.INDEX_UPDATE:
					var newIndex:uint = note.getBody() as uint;
					trace("[STAGE MEDIATOR ]" + newIndex);
					TweenLite.to(gallery, 0.5, {alpha:0, y:0, onComplete:swapImages, onCompleteParams:[newIndex]});
					break;	
			}
		}
		
		private function swapImages(newIndex:uint):void {
			trace("photo" + newIndex);
			gallery.removeChildAt(0);
			var newImage:ContentDisplay = LoaderMax.getContent("photo" + newIndex);
			gallery.addChild(newImage);
			TweenLite.to(gallery , 0.5, {alpha:1, y:100});
		}
	}
}