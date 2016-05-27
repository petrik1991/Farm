package Game
{
import flash.events.MouseEvent;

import mx.controls.Button;
import mx.controls.Image;

import spark.components.HGroup;

import spark.components.SkinnableContainer;

public class GameManager
    {
        private var _game : Game;

        private var _farms : Farms;

        private var _currentAction : String = Config.ACTION_NONE;

        private var _gameScene : GameScene;

        private var _itemPanel : SkinnableContainer;

        private var _activeSeed : ItemType;

        public function GameManager(farms : Farms, _currentGame : Game) {
            trace("GameManager.new(_game = " + _currentGame.toString() + ")");

            _game = _currentGame;
            _farms = farms;

            _gameScene = new GameScene();
            _game.addChild(_gameScene);

            ItemType.Init(this);
        }

        public function afterInitItems() : void {

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

            // Добавляем горизонтальную группу, для айтемов
            var _panelGroup : HGroup = new HGroup();
            _itemPanel.addElement(_panelGroup);
            _panelGroup.x = _itemPanel.width;
            _panelGroup.y = -15;
            _panelGroup.width = _itemPanel.width;
            _panelGroup.height = _itemPanel.height;

            // Добавляем доступные саженцы
            for each (var _type : ItemType in ItemType._typesItem) {
                var _panelItem : ItemOnPanel = new ItemOnPanel(_type);
                _panelItem.setSize(100);
                _panelGroup.addElement(_panelItem);
                _panelItem.addEventListener(MouseEvent.CLICK, mouseClickOnPlant);
            }
        }

        private function mouseClickOnPlant(_event : MouseEvent) : void {
            _activeSeed = _event.currentTarget.getType();
            _currentAction = Config.ACTION_PLANT;
            trace("READY" + _activeSeed.getImgName());
//            readyForAction(Config.SEED_IMAGE, _event.stageX, _event.stageY);
        }
    }
}
