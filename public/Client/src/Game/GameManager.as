package Game
{

    public class GameManager
    {
        private var _game : Game;

        // Главная форма
        private var _farms : Farms;

        // Текущее действие
        private var _currentAction : String = Config.ACTION_NONE;

        // Игровое поле
        private var _gameScene : GameScene;

        public function GameManager(farms : Farms, _currentGame : Game) {
            trace("GameManager.new(_game = " + _currentGame.toString() + ")");

            _game = _currentGame;
            _farms = farms;

            // Игровое поле
            _gameScene = new GameScene();
            _game.addChild(_gameScene);
            _farms.showGame();
        }
    }
}
