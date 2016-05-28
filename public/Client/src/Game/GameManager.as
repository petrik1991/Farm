package Game
{
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import mx.controls.Button;

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
            _game = _currentGame;
            _farms = farms;

            StageItem.setManager(this);

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

            var _panelGroup : HGroup = new HGroup();
            _itemPanel.addElement(_panelGroup);
            _panelGroup.x = _itemPanel.width;
            _panelGroup.y = -15;
            _panelGroup.width = _itemPanel.width;
            _panelGroup.height = _itemPanel.height;

            // Добавляем доступные саженцы
            for each (var _type : ItemType in ItemType._typesItem) {
                var _panelItem : ItemOnPanel = new ItemOnPanel(_type);
                _panelItem.setSize(Config.ITEM_ON_PANEL_SIZE);
                _panelGroup.addElement(_panelItem);
                _panelItem.addEventListener(MouseEvent.CLICK, mouseClickOnPlant);
            }

            // Спросим с сервака состояние игры
            ConnectToServer.sendToServer("game/get_game_state", false, null, gameStateReturned);
        }

        private function gameStateReturned(_event : Event) : void {
            trace("GameManager.game_state_returned");
            var _stageCollection : XMLList = new XMLList(_event.target.data);
            trace(_stageCollection);
            for each(var _item : XML in _stageCollection.children()) {
                var _point : Point = new Point(_item.@x, _item.@y);

                var _stageItem : StageItem = StageItem.load(_item.@id, _point, ItemType.getById(_item.@item_type), _item.@phase);
                _gameScene.getBackground().addElement(_stageItem);
            }

            afterLoadGame();
        }

        private function afterLoadGame() : void {
            trace("GameManager.after_load_game");
            // Покажем игру
            _farms.showGame();
        }

        public function addItemOnScene(_stageItem : StageItem) : void {
            _gameScene.getBackground().addElement(_stageItem);
        }

        private function mouseClickOnPlant(_event : MouseEvent) : void {
            _activeSeed = _event.currentTarget.getType();
            _currentAction = Config.ACTION_PLANT;
            readyForAction(_event.stageX, _event.stageY);
        }

        private function readyForAction(_x : Number, _y : Number) : void {
            if(_currentAction == Config.ACTION_PLANT)
                _gameScene.getBackground().addEventListener(MouseEvent.CLICK, clickOnBg);
        }

        private function clickOnBg(_event : MouseEvent) : void {
            if (_currentAction == Config.ACTION_PLANT)
            {
                // Сажаем
                var _point : Point = getClickedPoint(_event.stageX, _event.stageY);
                StageItem.createByPoint(_point);
            }
        }

        private function getClickedPoint(_x: Number, _y: Number) : Point{
            var point : Point = new Point();
            point.x = _x + _gameScene.getDelta_X() - Config.BED_WIDTH / 2;
            point.y = _y + _gameScene.getDelta_Y() - Config.BED_HEIGHT / 2;

            return point;
        }
    }
}
