package  
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notification;
	import controller.*;
	
	/**
	 * ...
	 * @author Vanja Jelic
	 */
	public class ApplicationFacade extends Facade implements IFacade 
	{
		       // Notification name constants
        public static const STARTUP:String          = "startup";
		public static const MOUSEDOWN:String        = "mouse down";
		public static const INDEX_UPDATE:String     = "index update";
		static public const LOAD_COMPLETE:String 	= "loadComplete";

        // this class iis singleton so no NEW() is allowed
		public static function getInstance(): ApplicationFacade {
			trace("[FACADE] GET INSTANCE");
            if (instance == null) {
				instance = new ApplicationFacade( );
			}
            return instance as ApplicationFacade;
        }
		
		// Broadcast the STARTUP Notification
		public function startup(app:Object):void {
		trace("[FACADE] START UP COMMAND")
			notifyObservers(new Notification(STARTUP, app));
		}
		
        // Register Commands with the Controller 
        override protected function initializeController():void {
            super.initializeController();            
            registerCommand(STARTUP, StartupCommand);
            registerCommand(MOUSEDOWN, MouseDownCommand);
		}
    
	}

}