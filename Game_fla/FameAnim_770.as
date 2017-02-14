// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.FameAnim_770

package Game_fla{
    import flash.display.MovieClip;

    public dynamic class FameAnim_770 extends MovieClip {

        public var fame:MovieClip;

        public function FameAnim_770(){
            addFrameScript(0, frame1, 4, frame5, 12, frame13);
        }
        function frame1(){
            visible = false;
            stop();
        }
        function frame13(){
            stop();
        }
        function frame5(){
            visible = true;
        }

    }
}//package Game_fla

