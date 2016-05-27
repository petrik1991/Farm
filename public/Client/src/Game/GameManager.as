package Game
{
import mx.controls.Button;

import spark.components.SkinnableContainer;

public class GameManager
    {
        private var _game : Game;

        private var _farms : Farms;

        private var _currentAction : String = Config.ACTION_NONE;

        private var _gameScene : GameScene;

        private var _itemPanel : SkinnableContainer;

        public function GameManager(farms : Farms, _currentGame : Game) {
            trace("GameManager.new(_game = " + _currentGame.toString() + ")");

            _game = _currentGame;
            _farms = farms;

            _gameScene = new GameScene();
            _game.addChild(_gameScene);

            initItems();
        }

        public function initItems() : void {

            _itemPanel = new SkinnableContainer();
            _game.addChild(_itemPanel);

            _itemPanel.width = Config.BUTTON_PANEL_SIZE * 2;
            _itemPanel.height = Config.BUTTON_PANEL_SIZE * 2;
            _itemPanel.x = 0;
            _itemPanel.y = Config.STAGE_HEIGHT - Config.BUTTON_PANEL_SIZE;

            //кнопка сбора урожая
            var _btnCollect : Button = new Button();
            _btnCollect.label = "Собрать растение";
            _btnCollect.x = 0;
            _btnCollect.width = Config.BUTTON_WIDTH;
            _itemPanel.addElement(_btnCollect);

            //сделать ход/вырастить растения на фазу
            var _btnStep : Button = new Button();
            _btnStep.label = "Сделать ход";
            _btnStep.x = 0;
            _btnStep.y = 40;
            _btnStep.width = Config.BUTTON_WIDTH;
            _itemPanel.addElement(_btnStep);
        }
    }
}
