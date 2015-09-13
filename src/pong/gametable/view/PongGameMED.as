/**
 * Created by Cengiz on 12.9.2015.
 */
package pong.gametable.view {
import flash.geom.Point;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

import pong.enums.GameNotifications;

import starling.core.Starling;

public class PongGameMED extends Mediator {

    public static const NAME:String = "pong.gametable.view.PongGameMED";

    private var _viewComp:PongGame;
    private var _velocity:Point;


    public function PongGameMED() {
        _viewComp = new PongGame();
        super(NAME, _viewComp);
        init();
    }

    private function init():void {
        _viewComp.init();

        facade.sendNotification(GameNotifications.UPDATE_SCORE, null);
    }


    override public function onRegister():void {
        super.onRegister();

        Starling.current.stage.addChild(_viewComp);
    }


    override public function listNotificationInterests():Array {
        return [GameNotifications.GAMETABLE_READY];
    }


    override public function handleNotification(notification:INotification):void {
        switch (notification.getName()) {
            case GameNotifications.GAMETABLE_READY:
                _viewComp.startGame();
                break;
        }
    }
}
}
