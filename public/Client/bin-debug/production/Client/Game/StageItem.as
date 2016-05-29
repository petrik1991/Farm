package Game
{
import flash.events.Event;
import flash.geom.Point;
import flash.net.URLVariables;

import mx.controls.Image;

public class StageItem extends Image
    {

    public static var _collection : Vector.<StageItem> = new Vector.<StageItem>();
    private static var _manager : GameManager;

    private var _id : int;
    private var _type : ItemType;
    private var _phase : int = 0;
    private var _x : int;
    private var _y : int;
    private var _defY : Number;

        public function StageItem(_codePoint : Point, _decodePoint : Point) {
            _x = _codePoint.x;
            _y = _codePoint.y;

            _defY = _decodePoint.y;
            x = _decodePoint.x;
            y = _defY;

            smoothBitmapContent = true;
            //setImage();
        }

        public static function createByPoint(_point : Point, type : int) : void {
            var _codePoint : Point = codePoint(_point);

            // Проверим умещается ли на плантацию
            if (Math.abs(_codePoint.x) > Config.BED_NUMBER_OF_ROWS || Math.abs(_codePoint.y) > Config.BED_NUMBER_OF_ROWS)
            {
                return;
            }

            // Проверим наличие данной клетки
            for each (var _stageItem : StageItem in _collection)
            {
                trace(_codePoint.x.toString() + " " + _codePoint.y.toString() + " " + _stageItem._x.toString() + " "  + _stageItem._y.toString() + " ");
                if (_codePoint.x == _stageItem._x && _codePoint.y == _stageItem._y)
                {
                    return;
                }
            }

            // Скажем серверу про новый айтэм
            var _variables : URLVariables = new URLVariables();
            _variables.decode("x=" + _codePoint.x);
            _variables.decode("y=" + _codePoint.y);
            _variables.decode("item_type=" + type);
            ConnectToServer.sendToServer("game/add_item_on_stage", true, _variables, createByData);
        }

        public static function load(_idNumber : int, _point : Point, _itemType : ItemType, _onPhase : int) : StageItem {
            trace("StageItem.load");

            var _codePoint : Point = _point;
            var _decodePoint : Point = StageItem.decodePoint(_point);

            var _stageItem : StageItem = new StageItem(_codePoint, _decodePoint);
            _collection.push(_stageItem);

            _stageItem._id = _idNumber;
            _stageItem._type = _itemType;
            _stageItem._phase = _onPhase;
            _stageItem.setImage();

            return _stageItem;
        }

        public static function decodePoint(_point : Point) : Point {
            var _newPoint : Point = new Point();

            _newPoint.x = Config.GROUND_CENTER_X + Config.BED_CODE_WIDTH *
                    (_point.x * Math.cos(Config.BED_CORNER) - _point.y * Math.sin(Config.BED_CORNER));
            _newPoint.y = Config.GROUND_CENTER_Y + Config.BED_CODE_HEIGHT *
                    (_point.x * Math.sin(Config.BED_CORNER) + _point.y * Math.cos(Config.BED_CORNER));

            return _newPoint;
        }

        public static function getStageItemByCoord(point: Point) : StageItem{
            for each (var _stageItem : StageItem in _collection)
            {
                if (point.x == _stageItem._x && point.y == _stageItem._y)
                    return _stageItem;
            }
            return null;
        }

        public static function setManager(_gameManager : GameManager) : void {
            _manager = _gameManager;
        }

        private function setImage() : void {
            var _deltaY : Number = 0;
            visible = false;
            if (_type == null)
            {
                //AssetsManager.getInstance().loadPictureAndCache(Config.BED_PHASE_ZERO, this);
            } else
            {
                AssetsManager.getInstance().loadPictureAndCache(_type.getImgName() + "_" + _phase.toString() + Config.IMAGE_FILE_TYPE, this);
                _deltaY = Config.BED_HEIGHT_AS_PLANT - Config.BED_HEIGHT;
            }

            y = _defY - _deltaY;
            width = Config.BED_WIDTH;
            visible = true;
        }

        private static function createByData(_event : Event) : void {
            var _item : XMLList = new XMLList(_event.target.data);
            var _point : Point = new Point(_item.@x, _item.@y);
            var _stageItem : StageItem = load(_item.@id, _point, ItemType.getById(_item.@item_type), _item.@phase);
            _manager.addItemOnScene(_stageItem);
        }

        public static function codePoint(_point : Point) : Point {
            _point.x = (Config.GROUND_CENTER_X - _point.x) / Config.BED_CODE_WIDTH;
            _point.y = (Config.GROUND_CENTER_Y - _point.y) / Config.BED_CODE_HEIGHT;

            var _newPoint : Point = new Point();
            var _newCorner : Number = 3 * Config.BED_CORNER;
            _newPoint.x = _point.x * Math.cos(_newCorner) -
                    _point.y * Math.sin(_newCorner);
            _newPoint.y = _point.x * Math.sin(_newCorner) +
                    _point.y * Math.cos(_newCorner);
            _newPoint.x = Math.round(_newPoint.x);
            _newPoint.y = Math.round(_newPoint.y);

            return _newPoint;
        }

        public function incPhase() : void {
            trace("StageItem.inc_phase");
                if (_phase < _type.getPhaseCount())
                {
                    trace(_phase.toString());
                    _phase += 1;

                    // Скажем серверу про увеличение стадии
                    var _variables : URLVariables = new URLVariables();
                    _variables.decode("id=" + _id);
                    ConnectToServer.sendToServer("game/inc_item_phase", true, _variables, null);

                    setImage();
                }
        }

        private function afterCollect() : void{
            delete this;
        }

        public function collect() : void {
            trace("StageItem.collect");

            if (_phase == _type.getPhaseCount() && _manager != null)
            {
                // Скажем серверу что мы собали
                var _variables : URLVariables = new URLVariables();
                _variables.decode("id=" + _id);
                ConnectToServer.sendToServer("game/collect_item", true, _variables, afterCollect);
            }
        }
    }
}
