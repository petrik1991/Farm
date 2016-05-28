package Game {
    public class Config {
        public static const SERVER_URL : String = "http://localhost:2500/";

        public static const STAGE_WIDTH : Number = 800;
        public static const STAGE_HEIGHT : Number = 600;

        public static const PICTURES_DIR : String = "images/";

        public static const IMAGE_FILE_TYPE : String = ".png";

        public static const GROUND_WIDTH : Number = 1000;
        public static const GROUND_HEIGHT : Number = 1100;
        public static const GROUND_CENTER_X : Number = GROUND_WIDTH / 2;
        public static const GROUND_CENTER_Y : Number = GROUND_HEIGHT / 2;

        public static const BUTTON_PANEL_SIZE : Number = 80;
        public static const BUTTON_WIDTH : Number = 120;

        public static const ITEM_ON_PANEL_SIZE : Number = 100;

        public static const BG_IMAGE : String = "grass.jpg";

        public static const BED_PHASE_ZERO : String = "bed_phase_0.png";
        public static const BED_WIDTH : Number = 140;
        public static const BED_RATIO : Number = .6;
        public static const BED_RATIO_AS_PLANT : Number = 3/2;
        public static const BED_HEIGHT_AS_PLANT : Number = BED_WIDTH * BED_RATIO_AS_PLANT;
        public static const BED_HEIGHT : Number = BED_WIDTH * BED_RATIO;

        public static const BED_CORNER : Number = Math.PI / 4;
        public static const BED_CODE_WIDTH : Number = 0.75 * BED_WIDTH;
        public static const BED_CODE_HEIGHT : Number = 0.72 * BED_HEIGHT;
        public static const BED_NUMBER_OF_ROWS : Number = 2;

        public static const ACTION_NONE : String = "NONE";
        public static const ACTION_STEP : String = "STEP";
        public static const ACTION_PLANT : String = "PLANT";
        public static const ACTION_COLLECT : String = "COLLECT";
    }
}
