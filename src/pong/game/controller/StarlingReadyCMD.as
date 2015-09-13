/**
 * Created by Cengiz on 12.9.2015.
 */
package pong.game.controller {
import org.puremvc.as3.patterns.command.MacroCommand;

import pong.gametable.controller.CreateGameTableCMD;
import pong.scoreboard.controller.CreateScoreBoardCMD;

public class StarlingReadyCMD extends MacroCommand {


    override protected function initializeMacroCommand():void {
        addSubCommand(CreateGameTableCMD);
        addSubCommand(CreateScoreBoardCMD);
    }
}
}
