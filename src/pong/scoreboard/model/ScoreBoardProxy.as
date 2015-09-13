/**
 * Created by Cengiz on 13.9.2015.
 */
package pong.scoreboard.model {
import org.puremvc.as3.patterns.proxy.Proxy;

public class ScoreBoardProxy extends Proxy {


    public static const NAME:String = "ScoreBoardData";

    private var _proxyData:ScoreBoardProxyData;

    public function ScoreBoardProxy() {
        _proxyData = new ScoreBoardProxyData();
        super(NAME, _proxyData);
    }

    public function set scoreData(val:ScoreData):void {
        _proxyData.scoreData = val;
    }

    public function get scoreData():ScoreData {
        if (_proxyData.scoreData == null) {
            _proxyData.scoreData = new ScoreData();
        }
        return _proxyData.scoreData;
    }

    public function updateScore(playerId:int, score:int):void {
        var scoreData:ScoreData = _proxyData.scoreData;

        switch (playerId) {
            case 1:
                scoreData.player1 = score;
                break;

            case 2:
                scoreData.player2 = score;
                break;
        }
    }

    public function getPlayerScore(playerId:int):int {
        var score:int;

        switch (playerId) {
            case 1:
                score = scoreData.player1;
                break;

            case 2:
                score = scoreData.player2;
                break;
        }

        return score;
    }
}
}
