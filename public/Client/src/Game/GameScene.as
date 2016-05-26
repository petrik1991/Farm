package Game
{
import mx.controls.Image;
import mx.core.LayoutContainer;

import spark.components.SkinnableContainer;

    public class GameScene extends LayoutContainer
    {
        // Игровое поле
        private var _bg : SkinnableContainer;
        private var _bgImage : Image;

        public function GameScene() {
            // Устанавливаем размеры
            width = Config.STAGE_WIDTH;
            height = Config.STAGE_HEIGHT;
            x = 0;
            y = 0;

            // Поле для растений
            _bg = new SkinnableContainer();
            addChild(_bg);

            // Устанавливаем размеры поля и центрируем
            _bg.width = Config.GROUND_WIDTH;
            _bg.height = Config.GROUND_HEIGHT;
            _bg.x = - (_bg.width - Config.STAGE_WIDTH) / 2;
            _bg.y = - (_bg.height - Config.STAGE_HEIGHT) / 2;

            // Добавляем фон
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