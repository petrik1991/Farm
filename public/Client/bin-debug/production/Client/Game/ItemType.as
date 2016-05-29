package Game
{
import flash.events.Event;
import flash.utils.Dictionary;

    public class ItemType
    {
        public static var _typesItem : Dictionary;
        public static var _manager : GameManager;

        private var _id : int;
        private var _phaseCount : int;
        private var _name : String;

        public function ItemType(id : int, phaseCount : int, name : String) {
            _id = id;
            _phaseCount = phaseCount;
            _name = name;
        }

        public static function Init(manager : GameManager) : void {
            _manager = manager;
            _typesItem = new Dictionary();

            ConnectToServer.sendToServer("game/all_item_types", false, null, onGetTypesComplete);
        }

        private static function onGetTypesComplete(_event : Event) : void {
            var _itemCollection : XMLList = new XMLList(_event.target.data);
            for each(var _type : XML in _itemCollection.children()) {
                _typesItem[int(_type.@id)] = new ItemType(
                        _type.@id,
                        _type.@phase_count,
                        _type.@name);
            }
            _manager.afterInitItems();
        }

        public function getImgName() : String {
            return _name;
        }

        public function getPhaseCount() : int {
            return _phaseCount - 1;
        }

        public function getID() : int {
            return _id;
        }

        public static function getById(_id : int) : ItemType {
            trace("ItemType.get_by_id " + _typesItem[_id])
            return _typesItem[_id];
        }
    }
}
