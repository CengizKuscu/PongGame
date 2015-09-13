/**
 * Created by Cengiz on 12.9.2015.
 */
package pong.gametable.view {
import flash.geom.Rectangle;
import flash.ui.Keyboard;

import starling.display.Shape;
import starling.events.Event;
import starling.events.KeyboardEvent;

public class Player extends Shape {

    private var _keyMode:String;

    private var _playerId:int;
    private var _direction:int = 0;

    private var _bounds:Rectangle;

    public function Player() {
        super();
    }

    public function init(playerId:int):void {

        _playerId = playerId;
        addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        addEventListener(Event.ENTER_FRAME, changePaddlePosition);
    }

    private function keyUpHandler(e:KeyboardEvent):void {
        _keyMode = e.type;
        _direction = 0;
    }

    private function keyDownHandler(e:KeyboardEvent):void {
        if (_playerId == 1) {
            if (e.keyCode == 87 && _keyMode != "keyDown") {
                _direction = -1;
            }
            else if (e.keyCode == 83 && _keyMode != "keyDown") {
                _direction = 1;
            }

        }
        else if (_playerId == 2) {
            if (e.keyCode == Keyboard.UP && _keyMode != "keyDown") {
                _direction = -1;
            }
            else if (e.keyCode == Keyboard.DOWN && _keyMode != "keyDown") {
                _direction = 1;
            }

        }


        _keyMode = e.type;
    }

    private function changePaddlePosition(e:Event):void {
        if (_direction != 0) {
            this.y += (10 * _direction);
            trace("paddle position: ", this.y);
            if (this.y < 20) {
                this.y = 20
            }
            else if (this.y + this.height > 620) {
                this.y = 620 - this.height;
            }
        }
    }


    public function get playerBounds():Rectangle {
        return _bounds;
    }

    public function set playerBounds(value:Rectangle):void {
        _bounds = value;
    }
}
}
