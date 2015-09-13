package {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

import org.puremvc.as3.interfaces.IFacade;
import org.puremvc.as3.patterns.facade.Facade;

import pong.game.controller.StarlingReadyCMD;
import pong.scoreboard.controller.UpdateScoreCMD;
import pong.enums.GameNotifications;
import pong.scoreboard.model.ScoreBoardProxy;
import pong.game.view.StarlingMED;

import starling.core.Starling;

[SWF(frameRate="60", width="960", height="640", backgroundColor="0xffffff")]
public class GameRunner extends Sprite {

    private var _facade:IFacade;

    private var _starlingMED:StarlingMED;

    private static var _instance:GameRunner;

    public function GameRunner() {

        _instance = this;

        this.stage.scaleMode = StageScaleMode.NO_SCALE;
        this.stage.align = StageAlign.TOP_LEFT;

        _facade = Facade.getInstance();

        initProxies();
        initCommands();
        initMeds();
        initStarling();
    }

    private function initProxies():void {
        _facade.registerProxy(new ScoreBoardProxy());
    }

    private function initCommands():void {
        _facade.registerCommand(GameNotifications.STARLING_READY, StarlingReadyCMD);
        _facade.registerCommand(GameNotifications.UPDATE_SCORE, UpdateScoreCMD);
    }

    private function initMeds():void {
        _facade.registerMediator(new StarlingMED());
    }

    private function initStarling():void {
        _starlingMED = _facade.retrieveMediator(StarlingMED.NAME) as StarlingMED;
        _starlingMED.init();
        Starling.current.start();
    }

    public static function get instance():GameRunner {
        return _instance;
    }
}
}