package Game
{
import flash.utils.Dictionary;

import mx.controls.Image;

    public class AssetsManager
    {
        private static var _instance : AssetsManager;
        private var _cash : Dictionary;

        public function AssetsManager() {
            _cash = new Dictionary();
        }

        public static function getInstance() : AssetsManager {
            if (_instance == null)
                _instance = new AssetsManager();

            return _instance;
        }

        public function loadPicture(_url : String) : void {
            if (_cash[_url] == null)
            {
                trace("Caching " + _url);
                var _img : Image = new Image();
                _img.load(Config.SERVER_URL);
                _cash[_url] = _img;
                trace("Caching done");
            }
        }
    }
}