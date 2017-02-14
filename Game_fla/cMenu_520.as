// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.cMenu_520

package Game_fla{
    import flash.display.MovieClip;

    public dynamic class cMenu_520 extends MovieClip {

        public var iproto:MovieClip;
        public var bg:MovieClip;
        public var mHi:MovieClip;

        public function cMenu_520(){
            addFrameScript(0, frame1, 19, frame20);
        }
        function frame1(){
            stop();
        }
        function frame20(){
            MovieClip(parent).gotoAndPlay("out");
            gotoAndStop("hold");
        }

    }
}//package Game_fla

