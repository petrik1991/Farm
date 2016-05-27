package Game
{
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

import mx.controls.Alert;

    public class ConnectToServer
    {
        public static function sendToServer(_url : String, _post : Boolean, _variables : URLVariables, _afterCompleate : Function) : void {
            var _req : URLRequest = new URLRequest(Config.SERVER_URL + _url);

            if (_post)
                _req.method = URLRequestMethod.POST;
            else
                _req.method = URLRequestMethod.GET;

            _req.data = _variables;

            var loader : URLLoader = new URLLoader();

            if(_afterCompleate != null)
                loader.addEventListener(Event.COMPLETE, _afterCompleate);
            loader.addEventListener(IOErrorEvent.IO_ERROR, connectError);

            loader.load(_req);

        }

        public static function connectError(_event : Event): void {
            trace("ConnectToServer.connect_error");
            Alert.show("Ошибка соединения с сервером");
        }
    }
}