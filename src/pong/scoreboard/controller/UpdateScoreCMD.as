/**
 * Created by Cengiz on 13.9.2015.
 */
package pong.scoreboard.controller {
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

import pong.scoreboard.controller.params.UpdateScoreParam;
import pong.scoreboard.model.ScoreBoardProxy;
import pong.scoreboard.model.ScoreData;

public class UpdateScoreCMD extends SimpleCommand {


    override public function execute(notification:INotification):void {
        var param:UpdateScoreParam = notification.getBody() as UpdateScoreParam;

        var scoreBoardProxy:ScoreBoardProxy = facade.retrieveProxy(ScoreBoardProxy.NAME) as ScoreBoardProxy;
        if (param == null) {
            scoreBoardProxy.scoreData = new ScoreData();
        }
        else {
            var score:int = scoreBoardProxy.getPlayerScore(param.playerId);

            scoreBoardProxy.updateScore(param.playerId, score + param.score);
        }

    }
}
}
