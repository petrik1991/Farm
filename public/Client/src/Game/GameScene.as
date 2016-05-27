package Game
{
import flash.events.MouseEvent;

import mx.controls.Image;
import mx.core.LayoutContainer;

import spark.components.SkinnableContainer;

    public class GameScene extends LayoutContainer
    {
        private var _bg : SkinnableContainer;
        private var _bgImage : Image;
        private var _bgGarden : SkinnableContainer;

        // Координаты курсора, для перемещения поля
        private var _xCoord : Number;
        private var _yCoord : Number;

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
            _bgImage.smoothBitmapContent = true;
            _bg.addElement(_bgImage);

            _bgGarden = new SkinnableContainer();
            _bgGarden.width = _bg.width;
            _bgGarden.height = _bg.height;
            _bgGarden.x = 0;
            _bgGarden.y = 0;
            _bg.addElement(_bgGarden);

            paintGardenArea();

            // Добавлем слушателя на нажатие кнопки
            addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
        }

        private function paintGardenArea() : void {
            //прямоугольник, ограничивающий поле
            _bgGarden.graphics.lineStyle(1, 0x000000, 0.7);
            // К вершине верхней грядки
            _bgGarden.graphics.moveTo(
                    Config.GROUND_CENTER_X + Config.BED_WIDTH / 2,
                    Config.GROUND_CENTER_Y - Config.BED_HEIGHT * Config.BED_NUMBER_OF_ROWS);
            // Рисуем 4 линии
            _bgGarden.graphics.lineTo(
                    Config.GROUND_CENTER_X + Config.BED_WIDTH * (Config.BED_NUMBER_OF_ROWS + 1),
                    Config.GROUND_CENTER_Y + Config.BED_HEIGHT / 2);
            _bgGarden.graphics.lineTo(
                    Config.GROUND_CENTER_X + Config.BED_WIDTH / 2,
                    Config.GROUND_CENTER_Y + Config.BED_HEIGHT * (Config.BED_NUMBER_OF_ROWS + 1));
            _bgGarden.graphics.lineTo(
                    Config.GROUND_CENTER_X - Config.BED_WIDTH * Config.BED_NUMBER_OF_ROWS,
                    Config.GROUND_CENTER_Y + Config.BED_HEIGHT / 2);
            _bgGarden.graphics.lineTo(
                    Config.GROUND_CENTER_X + Config.BED_WIDTH / 2,
                    Config.GROUND_CENTER_Y - Config.BED_HEIGHT * Config.BED_NUMBER_OF_ROWS);
        }

        private function mousePressed(_event : MouseEvent) : void {
            _xCoord = _event.stageX;
            _yCoord = _event.stageY;
            // Добавлем слушателя на отжатие и перемещение
            addEventListener(MouseEvent.MOUSE_UP, mousePressedOff);
            addEventListener(MouseEvent.MOUSE_MOVE, mouseDrag);
        }

        private function mousePressedOff(_event : MouseEvent) : void {
            // Удаляем слушателя на отжатие и перемещение
            removeEventListener(MouseEvent.MOUSE_UP, mousePressedOff);
            removeEventListener(MouseEvent.MOUSE_MOVE, mouseDrag);
        }

        private function mouseDrag(_event : MouseEvent) : void {
            // Вычисляем новые координаты
            var _x : Number = _bg.x - (_xCoord - _event.stageX);
            var _y : Number = _bg.y - (_yCoord - _event.stageY);

            if (_x < Config.STAGE_WIDTH - _bg.width){_x = Config.STAGE_WIDTH - _bg.width}
            if (_y < Config.STAGE_HEIGHT - _bg.height){_y = Config.STAGE_HEIGHT - _bg.height}
            if (_x > 0){_x = 0}
            if (_y > 0){_y = 0}

            _xCoord = _event.stageX;
            _yCoord = _event.stageY;

            _bg.x = _x;
            _bg.y = _y;
        }

        public function getBackground() : SkinnableContainer {
            return _bg;
        }

        public function getDelta_X() : Number {
            return -1 * _bg.x;
        }

        public function getDelta_Y() : Number {
            return -1 * (_bg.y);
        }
    }
}