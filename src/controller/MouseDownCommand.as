package controller 
{
	import model.ImageDataProxy;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author Vanja Jelic
	 */
	public class MouseDownCommand extends SimpleCommand implements ICommand 
	{
        override public function execute(note:INotification):void    {
			// Get the WindowMetricsProxy
			var imageDataProxy:ImageDataProxy = facade.retrieveProxy(ImageDataProxy.NAME) as ImageDataProxy;
			// Set the char code of the key pressed in KeyDataProxy 
			//var charCode:uint = note.getBody() as uint;
			imageDataProxy.nextImage();
			trace("[MOUSE DOWN COMMAND ] "+ imageDataProxy.imageIndex);
			
        }
		
	}

}