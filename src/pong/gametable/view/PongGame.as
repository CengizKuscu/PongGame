/**
 * Created by Cengiz on 12.9.2015.
 */
package pong.gametable.view {
import pong.game.view.*;

import flash.geom.Point;
import flash.geom.Rectangle;

import org.puremvc.as3.interfaces.IFacade;
import org.puremvc.as3.patterns.facade.Facade;

import pong.scoreboard.controller.params.UpdateScoreParam;
import pong.enums.GameNotifications;

import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.display.Quad;
import starling.display.Shape;
import starling.display.Sprite;

public class PongGame extends Sprite implements IAnimatable {

    private var _gameTable:Shape;
    private var _player1:Player;
    private var _player2:Player;
    private var _ball:Shape;

    private var _velocity:Point;

    private var _ballRect:Rectangle;
    private var _facade:IFacade;

    public function PongGame() {
        super();
    }

    public function init():void {
        _facade = Facade.getInstance();

        var quad:Quad = new Quad(960, 640, 0x000000);
        addChild(quad);

        createGameTable();
        createPlayer1();
        createPlayer2();
        createBall();
    }

    public function startGame():void {
        startRound();
    }

    private function startRound(looserWay:int = 1):void {

        Starling.juggler.purge();

        _ball.visible = true;

        _ball.x = 480;

        _ball.y = randRange(100, 400);


        _velocity = new Point();
        _velocity.x = randRange(350, 400);
        _velocity.y = Math.sqrt(160000 - Math.pow(_velocity.x, 2));

        _velocity.x *= looserWay;

        var tmpRandom:Number = randRange(0, 1);

        if (tmpRandom == 0) {
            tmpRandom = -1;
        }

        _velocity.y = _velocity.y * tmpRandom;

        Starling.juggler.add(this);
    }


    private function collisionDedection():Boolean {
        _ballRect = new flash.geom.Rectangle(_ball.x, _ball.y, _ball.width, _ball.height);

        _player1.playerBounds = new flash.geom.Rectangle(_player1.x, _player1.y, _player1.width, _player1.height);

        _player2.playerBounds = new flash.geom.Rectangle(_player2.x, _player2.y, _player2.width, _player2.height);

        var currentRect:Rectangle;

        if (_ballRect.intersects(_player1.playerBounds)) {
            currentRect = _player1.playerBounds;
            _ball.x = _player1.playerBounds.right;
        }
        else if (_ballRect.intersects(_player2.playerBounds)) {
            currentRect = _player2.playerBounds;
            _ball.x = _player2.playerBounds.x - _ball.width;
        }
        else {
            return false;
        }

        var hitPos:Number = _ball.y - (currentRect.y + (currentRect.height * 0.5) - _ball.height);

        var percentFromCenter:Number = hitPos / currentRect.height / 2;

        _velocity.y += percentFromCenter * 30;

        return true;

    }

    private function createBall():void {
        _ball = new Shape();

        _ball.graphics.beginFill(0xffffff);
        _ball.graphics.drawCircle(0, 0, 10);
        _ball.graphics.endFill();

        addChild(_ball);

        _ballRect = _ball.getBounds(this);

        _ball.visible = false;
    }

    private function createPlayer2():void {
        _player2 = new Player();

        _player2.graphics.beginFill(0xffffff);
        _player2.graphics.drawRoundRect(0, 0, 15, 75, 3);
        _player2.graphics.endFill();

        _player2.x = 910;
        _player2.y = 260;

        addChild(_player2);
        _player2.init(2);
        _player2.playerBounds = _player2.getBounds(this);
    }

    private function createPlayer1():void {
        _player1 = new Player();

        _player1.graphics.beginFill(0xffffff);
        _player1.graphics.drawRoundRect(0, 0, 15, 75, 3);
        _player1.graphics.endFill();

        _player1.x = 30;
        _player1.y = 260;

        addChild(_player1);
        _player1.init(1);
        _player1.playerBounds = _player1.getBounds(this);
    }


    private function createGameTable():void {
        _gameTable = new Shape();


        _gameTable.graphics.lineStyle(5, 0xffffff);
        _gameTable.graphics.drawRoundRect(0, 0, 920, 600, 10);

        _gameTable.graphics.moveTo(460, 0);
        _gameTable.graphics.lineTo(460, 600);

        _gameTable.x = 20;
        _gameTable.y = 20;

        addChild(_gameTable);
    }


    private function randRange(minNum:Number, maxNum:Number):Number {
        return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
    }

    public function advanceTime(time:Number):void {

        var collision:Boolean = collisionDedection();
        var updateScoreParam:UpdateScoreParam;

        if (collision) {
            _velocity.x = -_velocity.x;

            _ball.x += _velocity.x * time;
            _ball.y += _velocity.y * time;
            return;

        }

        if (_ball.y <= 30) {
            _ball.y = 31;
            _velocity.y = -_velocity.y;
        }

        if (_ball.y + _ball.height >= 630) {
            _ball.y = 630 - _ball.height;
            _velocity.y = -_velocity.y;
        }
        _ball.x += _velocity.x * time;
        _ball.y += _velocity.y * time;

        if (_ball.x + _ball.width > 950) {
            updateScoreParam = new UpdateScoreParam();
            updateScoreParam.playerId = 1;
            updateScoreParam.score = 1;
            _facade.sendNotification(GameNotifications.UPDATE_SCORE, updateScoreParam);

            startRound(1);
            return;
        }

        if (_ball.x < 30) {
            updateScoreParam = new UpdateScoreParam();
            updateScoreParam.playerId = 2;
            updateScoreParam.score = 1;
            _facade.sendNotification(GameNotifications.UPDATE_SCORE, updateScoreParam);

            startRound(-1);
            return;
        }
    }
}
}
