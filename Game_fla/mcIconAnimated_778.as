// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcIconAnimated_778

package Game_fla{
    import flash.display.MovieClip;

    public dynamic class mcIconAnimated_778 extends MovieClip {

        public var Icon:MovieClip;

        public function mcIconAnimated_778(){
            addFrameScript(0, frame1, 3, frame4, 10, frame11);
        }
        function frame1(){
            visible = false;
            stop();
        }
        function frame4(){
            visible = true;
        }
        function frame11(){
            stop();
        }

    }
}//package Game_fla

