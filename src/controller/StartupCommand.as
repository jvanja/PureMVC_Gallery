package controller 
{
	import flash.display.Stage;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import model.ImageDataProxy;
	import view.StageMediator;
	
	/**
	 * ...
	 * @author Vanja Jelic
	 */
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			// Create and register proxy
			facade.registerProxy(new ImageDataProxy());
			// Create and register StageMediator with the stage instance as an argument
			var stage:Stage = notification.getBody() as Stage;
			trace("[START UP COMMAND ] "+ stage);
			facade.registerMediator(new StageMediator(stage));
			
			var imageDataProxy:ImageDataProxy = facade.retrieveProxy(ImageDataProxy.NAME) as ImageDataProxy;
			// Set the char code of the key pressed in KeyDataProxy 
			//var charCode:uint = note.getBody() as uint;
			imageDataProxy.loadImages();
		}
	}

}