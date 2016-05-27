package Game
{
import mx.controls.Image;
import mx.core.LayoutContainer;

import spark.components.SkinnableContainer;

    public class GameScene extends LayoutContainer
    {
        private var _bg : SkinnableContainer;
        private var _bgImage : Image;

        public function GameScene() {
            layout = "absolute";
            verticalScrollPolicy = "off";
            horizontalScrollPolicy = "off";

            width = Config.STAGE_WIDTH;
            height = Config.STAGE_HEIGHT;
            x = 0;
            y = 0;

            _bg = new SkinnableContainer();
            addChild(_bg);

            _bg.width = Config.GROUND_WIDTH;
            _bg.height = Config.GROUND_HEIGHT;
            _bg.x = - (_bg.width - Config.STAGE_WIDTH) / 2;
            _bg.y = - (_bg.height - Config.STAGE_HEIGHT) / 2;

            _bgImage = new Image();
            AssetsManager.getInstance().loadPictureAndCache(Config.BG_IMAGE, _bgImage);
            _bgImage.width = _bg.width;
            _bgImage.height = _bg.height;
            _bgImage.x = 0;
            _bgImage.y = 0;
            _bg.addElement(_bgImage);
        }
    }
}