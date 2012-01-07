package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Vanja Jelic
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// Call the application startup method and pass the stage as the argument
			var facade:ApplicationFacade  = ApplicationFacade.getInstance();
			facade.startup(this.stage);
		}
		
	}
	
}