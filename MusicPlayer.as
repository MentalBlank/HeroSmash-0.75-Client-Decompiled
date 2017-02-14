// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//MusicPlayer

package {
    import flash.media.SoundTransform;
    import flash.media.SoundChannel;
    import flash.media.Sound;
    import flash.display.MovieClip;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class MusicPlayer {

        var musicTrans:SoundTransform;
        public var currentlyPlaying:Boolean = false;
        public var songLoaded:Boolean = false;
        var musicURL:String;
        var musicChannel:SoundChannel;
        var music:Sound;
        var currentSong:String = null;
        var songLink:String = null;
        var isLoading:Boolean = false;
        var rootClass:MovieClip;
        private var Volume:Number = 1;
        private var musicStart:Number = 0;
        var urlReq:URLRequest;
        public var musicDomain:ApplicationDomain;
        public var musicContext:LoaderContext;
        var sFilePath:String;
        private var repeatTimes:Number = 9999;
        private var musicPosition:Number = 0;
        var ldr:Loader;
        var sURL:String = "";

        public function MusicPlayer(rootObj){
            var rootObj:* = rootObj;
            musicDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
            musicContext = new LoaderContext(false, musicDomain);
            currentlyPlaying = false;
            songLoaded = false;
            currentSong = null;
            songLink = null;
            Volume = 1;
            repeatTimes = 9999;
            musicPosition = 0;
            musicStart = 0;
            musicChannel = new SoundChannel();
            sURL = "";
            ldr = new Loader();
            isLoading = false;
            super();
            try {
                rootClass = rootObj;
                sURL = rootClass.sFilePath;
            }
            catch(e:Error) {
                trace(e);
            };
            if ((((sURL == "")) || ((sURL == null)))){
                sFilePath = "";
            }
            else {
                sFilePath = (sURL + "maps/Music/");
            };
            trace((sFilePath + " - MUSIC FILE PATH !!!!!!!!!!!!!!!!!!!!!!!!!!!!"));
            musicTrans = musicChannel.soundTransform;
        }
        public function setStartTime(mStart:Number=0){
            musicStart = mStart;
        }
        public function resetPlayer(){
            setStartTime();
            setRepeat();
            setMusicVolume();
            musicPosition = 0;
        }
        public function setRepeat(repeat:Number=9999){
            repeatTimes = repeat;
        }
        private function loadSong(){
            var ldrClass:Class;
            if (rootClass.mixer.bSoundOn){
                if (musicURL != null){
                    if ((((currentSong == null)) || (((!((currentSong == musicURL))) && (!(isLoading)))))){
                        currentSong = musicURL;
                        isLoading = true;
                        urlReq = new URLRequest((sFilePath + musicURL));
                        ldr = new Loader();
                        ldr.load(urlReq, musicContext);
                        ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
                        ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                        trace("Load Song has been Sent!");
                    };
                }
                else {
                    trace("Error: appRequest not found!");
                };
            }
            else {
                trace("The game sound is set to off!");
            };
        }
        public function stopSong(){
            musicPosition = musicChannel.position;
            musicChannel.stop();
            currentlyPlaying = false;
        }
        public function removeSong(){
            if (currentlyPlaying){
                stopSong();
            };
            resetPlayer();
            musicURL = null;
            currentSong = null;
            musicChannel = new SoundChannel();
            songLoaded = false;
            if (ldr != null){
                try {
                    ldr.unload();
                }
                catch(e:Error) {
                    trace(e);
                };
            };
            musicDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
            musicContext = new LoaderContext(false, musicDomain);
        }
        public function requestSong(url:String=null, song:String=null){
            if ((((url == null)) || ((song == null)))){
                trace("loadSong has no Song Title to load!");
            }
            else {
                if (rootClass.mixer.bSoundOn){
                    currentlyPlaying = true;
                    musicURL = url;
                    songLink = song;
                    loadSong();
                };
            };
        }
        private function getSongDefinition(){
            var mClass:* = undefined;
            trace("getting song definition++++++++++++++++++");
            try {
                mClass = (musicDomain.getDefinition(songLink) as Class);
                music = new (mClass)();
                songLoaded = true;
            }
            catch(e:Error) {
                trace(e);
            };
        }
        private function completeHandler(event:Event):void{
            var evt:*;
            evt = event.currentTarget;
            trace("Song Loading Complete-----------------------");
            isLoading = false;
            getSongDefinition();
            playSong();
            evt.removeEventListener(Event.COMPLETE, completeHandler);
            evt.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            ldr = null;
        }
        public function setMusicVolume(vol:Number=0.4){
            musicTrans.volume = vol;
        }
        public function hasSongThenPlay(){
            var mapSong:String;
            var mapSongLink:String;
            if (rootClass.world.map != null){
                if (rootClass.world.map.strSong != null){
                    mapSong = rootClass.world.map.strSong;
                    mapSongLink = rootClass.world.map.strSongLink;
                    requestSong(mapSong, mapSongLink);
                };
            };
        }
        public function resumeSong(){
            if (rootClass.mixer.bSoundOn){
                if (music != null){
                    musicChannel = music.play(musicPosition, repeatTimes, musicTrans);
                    currentlyPlaying = true;
                };
            }
            else {
                trace("The Game Sound is set to Off!");
            };
        }
        private function ioErrorHandler(event:IOErrorEvent):void{
            var evt:*;
            evt = event.currentTarget;
            isLoading = false;
            trace("URL NOT FOUND");
            evt.removeEventListener(Event.COMPLETE, completeHandler);
            evt.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            ldr = null;
        }
        public function playSong(){
            trace("Song Playing-----------------");
            if (rootClass.mixer.bSoundOn){
                if (music != null){
                    musicChannel = music.play(musicStart, repeatTimes, musicTrans);
                    currentlyPlaying = true;
                };
            }
            else {
                trace("The Game Sound is set to Off!");
            };
        }

    }
}//package 

