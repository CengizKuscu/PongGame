/**
 * Created by Cengiz on 13.9.2015.
 */
package pong.scoreboard.view {
import pong.enums.Assets;

import starling.display.Sprite;
import starling.text.BitmapFont;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.HAlign;

public class ScoreBoardView extends Sprite {

    private var _player1:TextField;
    private var _player2:TextField;

    public function ScoreBoardView() {
        super();
    }

    public function init():void {
        var texture:Texture = Texture.fromEmbeddedAsset(Assets.FontTexture);
        var cls:Class = Assets.FontXml;

        var textureXML:XML = XML(new cls());

        TextField.registerBitmapFont(new BitmapFont(texture, textureXML));


        _player1 = new TextField(450, 150, "0", "font", 70, 0xffffff);
        _player1.hAlign = HAlign.RIGHT;
        _player1.x = 0;
        addChild(_player1);

        _player2 = new TextField(450, 150, "0", "font", 70, 0xffffff);
        _player2.hAlign = HAlign.LEFT;
        _player2.x = 480;
        addChild(_player2);
    }

    public function get player1():TextField {
        return _player1;
    }

    public function get player2():TextField {
        return _player2;
    }
}
}
