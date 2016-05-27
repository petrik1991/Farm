package Game
{
import mx.controls.Image;
import mx.core.LayoutContainer;

import spark.components.SkinnableContainer;

    public class GameScene extends LayoutContainer
    {
        private var _bg : SkinnableContainer;
        private var _bgImage : Image;

        private var _bgGarden : SkinnableContainer;

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

            _bgGarden = new SkinnableContainer();
            _bgGarden.width = _bg.width;
            _bgGarden.height = _bg.height;
            _bgGarden.x = 0;
            _bgGarden.y = 0;
            _bg.addElement(_bgGarden);

            paintGardenArea();
        }

        private function paintGardenArea() : void {
            //прямоугольник, ограничивающий поле
            _bgGarden.graphics.lineStyle(2, 0x000000, 0.7);
            // К вершине верхней грядки
            _bgGarden.graphics.moveTo(
                    Config.GROUND_CENTER_X - Config.BED_SIZE * .2,
                    Config.GROUND_CENTER_Y - Config.BED_SIZE * 1.8);
            // Рисуем 4 линии
            _bgGarden.graphics.lineTo(
                    Config.GROUND_CENTER_X + Config.BED_SIZE * 1.1,
                    Config.GROUND_CENTER_Y + Config.BED_SIZE * .4);
            _bgGarden.graphics.lineTo(
                    Config.GROUND_CENTER_X - Config.BED_SIZE * 1.4,
                    Config.GROUND_CENTER_Y + Config.BED_SIZE * 1.4);
            _bgGarden.graphics.lineTo(
                    Config.GROUND_CENTER_X - Config.BED_SIZE * 2.6,
                    Config.GROUND_CENTER_Y - Config.BED_SIZE);
            _bgGarden.graphics.lineTo(
                    Config.GROUND_CENTER_X - Config.BED_SIZE * .2,
                    Config.GROUND_CENTER_Y - Config.BED_SIZE * 1.8);
        }
    }
}