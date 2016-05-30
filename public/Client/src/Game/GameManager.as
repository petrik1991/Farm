package Game
{
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import spark.components.Button;

import spark.components.HGroup;
import spark.components.Label;

import spark.components.SkinnableContainer;

public class GameManager
    {
        private var _game : Game;

        private var _farms : Farms;

        private var _currentAction : String = Config.ACTION_NONE;

        private var _gameScene : GameScene;

        private var _itemPanel : SkinnableContainer;

        private var _activeSeed : ItemType;

        private var _state : Label;

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

            //кнопка сбора урожая
            var _btnCollect : Button = new Button();
            _btnCollect.label = "Собрать растение";
            _btnCollect.y = Config.STAGE_HEIGHT - 30;
            _btnCollect.width = Config.BUTTON_WIDTH;
            _btnCollect.addEventListener(MouseEvent.CLICK, onCollectClick);
            _itemPanel.addElement(_btnCollect);

            //сделать ход/вырастить растения на фазу
            var _btnStep : Button = new Button();
            _btnStep.label = "Сделать ход";
            _btnStep.y = Config.STAGE_HEIGHT - 60;
            _btnStep.width = Config.BUTTON_WIDTH;
            _btnStep.addEventListener(MouseEvent.CLICK, onStepClick);
            _itemPanel.addElement(_btnStep);

            _state = new Label();
            _state.y = Config.STAGE_HEIGHT - 90;
            _state.width = Config.BUTTON_WIDTH;
            _state.height = 40;
            _itemPanel.addElement(_state);

            var _panelGroup : HGroup = new HGroup();
            _itemPanel.addElement(_panelGroup);
            _panelGroup.x = Config.BUTTON_WIDTH * 2;
            _panelGroup.y = Config.STAGE_HEIGHT - Config.ITEM_ON_PANEL_SIZE;

            // Добавляем доступные саженцы
            for each (var _type : ItemType in ItemType._typesItem) {
                var _panelItem : ItemOnPanel = new ItemOnPanel(_type);
                _panelItem.setSize(Config.ITEM_ON_PANEL_SIZE);
                _panelGroup.addElement(_panelItem);
                _panelItem.addEventListener(MouseEvent.CLICK, mouseClickOnPlant);
            }

            // Спросим состояние игры
            ConnectToServer.sendToServer("game/get_game_state", false, null, gameStateReturned);
        }

        private function onCollectClick(event: MouseEvent) : void{
            _currentAction = Config.ACTION_COLLECT;
            _state.text = "Собираем";
        }

        private function gameStateReturned(_event : Event) : void {
            var _stageCollection : XMLList = new XMLList(_event.target.data);
            for each(var _item : XML in _stageCollection.children()) {
                var _point : Point = new Point(_item.@x, _item.@y);

                var _stageItem : StageItem = StageItem.load(_item.@id, _point, ItemType.getById(_item.@item_type), _item.@phase);
                _gameScene.getBackground().addElement(_stageItem);
                _stageItem.addEventListener(MouseEvent.CLICK, clickOnStageItem);
            }

            afterLoadGame();
        }

        private function afterLoadGame() : void {
            // Покажем игру
            _farms.showGame();
        }

        public function addItemOnScene(_stageItem : StageItem) : void {
            _gameScene.getBackground().addElement(_stageItem);
            _stageItem.addEventListener(MouseEvent.CLICK, clickOnStageItem);
        }

        private function mouseClickOnPlant(_event : MouseEvent) : void {
            _activeSeed = _event.currentTarget.getType();
            _currentAction = Config.ACTION_PLANT;
            _state.text = "Сажаем " + _activeSeed.getImgName();
            readyForAction();
        }

        private function readyForAction() : void {
            _gameScene.getBackground().addEventListener(MouseEvent.CLICK, clickOnBg);
        }

        private function onStepClick(_event : MouseEvent) : void {
            if(StageItem._collection.length == 0)
                return;

            _currentAction = Config.ACTION_STEP;
            _state.text = "Выращиваем";

            for each(var stageItem: StageItem in StageItem._collection)
                stageItem.incPhase();
        }

        public function deleteFromFarm(stageItem : StageItem) : void{
            if(StageItem._collection.indexOf(stageItem) >= 0)
            {
                StageItem._collection.splice(StageItem._collection.indexOf(stageItem), 1);
                stageItem.source = null;
            }
        }

        private function clickOnStageItem(_event : MouseEvent) : void {
            var stageItem : StageItem = _event.currentTarget as StageItem;

            if(stageItem == null)
                return;

            if (_currentAction == Config.ACTION_COLLECT)
            {
                // Собираем
                StageItem(stageItem).collect();
            }
        }

        private function clickOnBg(_event : MouseEvent) : void {
            if (_currentAction == Config.ACTION_PLANT)
            {
                // Сажаем
                var _point : Point = getClickedPoint(_event.stageX, _event.stageY);
                StageItem.createByPoint(_point, _activeSeed.getID());
            }
        }

        private function getClickedPoint(_x: Number, _y: Number) : Point{
            var point : Point = new Point();
            point.x = _x + _gameScene.getDelta_X() - Config.BED_WIDTH / 2;
            point.y = _y + _gameScene.getDelta_Y() + Config.BED_HEIGHT / 2;

            return point;
        }
    }
}
