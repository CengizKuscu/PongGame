/**
 * Created by Cengiz on 12.9.2015.
 */
package pong.gametable.controller {
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

import pong.gametable.view.PongGameMED;

public class CreateGameTableCMD extends SimpleCommand {


    override public function execute(notification:INotification):void {

        var gameTableMed:PongGameMED = new PongGameMED();
        facade.registerMediator(gameTableMed);
    }
}
}
