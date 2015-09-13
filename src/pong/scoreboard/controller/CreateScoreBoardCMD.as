/**
 * Created by Cengiz on 13.9.2015.
 */
package pong.scoreboard.controller {
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

import pong.scoreboard.view.ScoreBoardMED;

public class CreateScoreBoardCMD extends SimpleCommand {


    override public function execute(notification:INotification):void {

        var med:ScoreBoardMED = new ScoreBoardMED();
        med.init();
        facade.registerMediator(med);
    }
}
}
