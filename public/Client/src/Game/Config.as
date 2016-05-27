package Game {
    public class Config {
        public static const SERVER_URL : String = "http://localhost:2500/";

        public static const STAGE_WIDTH : Number = 800;
        public static const STAGE_HEIGHT : Number = 600;

        public static const PICTURES_DIR : String = "images/";

        public static const IMAGE_FILE_TYPE : String = ".png";

        public static const GROUND_WIDTH : Number = 1100;
        public static const GROUND_HEIGHT : Number = 1100;
        public static const GROUND_CENTER_X : Number = GROUND_WIDTH / 2;
        public static const GROUND_CENTER_Y : Number = GROUND_HEIGHT / 2;

        public static const BG_IMAGE : String = "grass.jpg";

        public static const BED_SIZE : Number = 150;

        public static const ACTION_NONE : String = "NONE";
        public static const ACTION_STEP : String = "STEP";
        public static const ACTION_PLANT : String = "PLANT";
    }
}
