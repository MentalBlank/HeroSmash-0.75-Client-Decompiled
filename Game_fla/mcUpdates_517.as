// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcUpdates_517

package Game_fla{
    import flash.display.MovieClip;

    public dynamic class mcUpdates_517 extends MovieClip {

        public var t1:MovieClip;

        public function mcUpdates_517(){
            addFrameScript(0, frame1, 100, frame101);
        }
        function frame1(){
            stop();
        }
        function frame101(){
            try {
                if (parent != null){
                    parent.removeChild(this);
                };
            }
            catch(e:Error) {
            };
            stop();
        }

    }
}//package Game_fla

