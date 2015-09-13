/**
 * Created by Cengiz on 12.9.2015.
 */
package pong.game.view {
import flash.geom.Rectangle;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

import pong.enums.GameNotifications;
import pong.game.view.StarlingRoot;

import starling.core.Starling;
import starling.events.Event;

public class StarlingMED extends Mediator {

    public static const NAME:String = "pong.game.view.StarlingMED";

    private var _starling:Starling;

    private var _viewComp:StarlingRoot;

    public function StarlingMED() {
        super(NAME, null);
    }

    public function init():void {

        var viewPort:Rectangle = new Rectangle(0, 0, 960, 640);
        _starling = new Starling(StarlingRoot, GameRunner.instance.stage, viewPort);
        _starling.stage.stageWidth = 960;
        _starling.stage.stageHeight = 640;
        _starling.antiAliasing = 0;
        _starling.addEventListener(Event.ROOT_CREATED, rootCreated);
    }

    private function rootCreated(e:Event):void {
        _viewComp = _starling.root as StarlingRoot;
        setViewComponent(_viewComp);
        facade.sendNotification(GameNotifications.STARLING_READY);
    }


    override public function listNotificationInterests():Array {
        return [GameNotifications.STARLING_READY];
    }


    override public function handleNotification(notification:INotification):void {
        switch (notification.getName()) {
            case GameNotifications.STARLING_READY:
                trace("STARLING IS READY");
                break;
        }
    }
}
}
