package Game {
    public class Config {
        public static const SERVER_URL : String = "http://localhost:2500/";

        public static const STAGE_WIDTH : Number = 800;
        public static const STAGE_HEIGHT : Number = 600;

        public static const PICTURES_DIR : String = "images/";

        public static const IMAGE_FILE_TYPE : String = ".png";

        public static const GROUND_WIDTH : Number = 1300;
        public static const GROUND_HEIGHT : Number = 1300;
        public static const GROUND_CENTER_X : Number = GROUND_WIDTH / 2;
        public static const GROUND_CENTER_Y : Number = GROUND_HEIGHT / 2;

        public static const BUTTON_PANEL_SIZE : Number = 80;
        public static const BUTTON_WIDTH : Number = 120;

        public static const BG_IMAGE : String = "grass.jpg";

        public static const BED_WIDTH : Number = 150;
        public static const BED_RATIO : Number = .6;
        public static const BED_HEIGHT : Number = BED_WIDTH * BED_RATIO;

        public static const BED_NUMBER_OF_ROWS : Number = 2;	// Колличесво равно 2n + 1

        public static const ACTION_NONE : String = "NONE";
        public static const ACTION_STEP : String = "STEP";
        public static const ACTION_PLANT : String = "PLANT";
    }
}
