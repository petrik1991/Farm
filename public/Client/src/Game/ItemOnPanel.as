package Game
{
import mx.controls.Image;

import spark.components.SkinnableContainer;

    public class ItemOnPanel extends SkinnableContainer
    {
        private var _type : ItemType;
        private var _image : Image;

        public function ItemOnPanel(type : ItemType) {
            _type = type;

            //изображение растения
            _image = new Image();
            AssetsManager.getInstance().loadPictureAndCache(_type.getImgName() + Config.IMAGE_FILE_TYPE, _image);
            addElement(_image);
        }

        public function setSize(size : Number): void {
            width = height = size;
           //    _image.height = _image.width = size;
        }

        public function getType() : ItemType {
            return _type;
        }
    }
}