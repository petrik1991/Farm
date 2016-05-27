package Game
{

    public class GameManager
    {
        private var _game : Game;

        private var _farms : Farms;

        private var _currentAction : String = Config.ACTION_NONE;

        private var _gameScene : GameScene;

        public function GameManager(farms : Farms, _currentGame : Game) {
            trace("GameManager.new(_game = " + _currentGame.toString() + ")");

            _game = _currentGame;
            _farms = farms;

            _gameScene = new GameScene();
            _game.addChild(_gameScene);
        }
    }
}
