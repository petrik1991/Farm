package Game
{
import mx.core.LayoutContainer;

    public class Game extends LayoutContainer
    {
        private var _gameManager : GameManager;

        public function Game(farms : Farms) {
            layout = "absolute";
            _gameManager = new GameManager(farms, this);
            verticalScrollPolicy = "off";
            horizontalScrollPolicy = "off";
        }
    }
}