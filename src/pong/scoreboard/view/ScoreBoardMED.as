/**
 * Created by Cengiz on 13.9.2015.
 */
package pong.scoreboard.view {
import pong.game.view.*;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

import pong.enums.GameNotifications;
import pong.scoreboard.model.ScoreBoardProxy;
import pong.scoreboard.model.ScoreData;

import starling.core.Starling;

public class ScoreBoardMED extends Mediator {

    public static const NAME:String = "ScoreBoardMED";

    private var _viewComp:ScoreBoardView;

    private var _scoreBoardProxy:ScoreBoardProxy;

    public function ScoreBoardMED() {
        _viewComp = new ScoreBoardView();
        super(NAME, _viewComp);
    }

    public function init():void {
        _scoreBoardProxy = facade.retrieveProxy(ScoreBoardProxy.NAME) as ScoreBoardProxy;
        _viewComp.init();
    }


    override public function onRegister():void {
        super.onRegister();
        _viewComp.x = 10;

        Starling.current.stage.addChild(_viewComp);

        facade.sendNotification(GameNotifications.GAMETABLE_READY);
    }


    override public function listNotificationInterests():Array {
        return [GameNotifications.UPDATE_SCORE];
    }


    override public function handleNotification(notification:INotification):void {
        switch (notification.getName()) {
            case GameNotifications.UPDATE_SCORE:
                var scoreData:ScoreData = _scoreBoardProxy.scoreData;

                _viewComp.player1.text = scoreData.player1.toString();
                _viewComp.player2.text = scoreData.player2.toString();
                break;


        }
    }
}
}
