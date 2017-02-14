// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.Element_1_CircleINOUT2_888

package Game_fla{
    import flash.display.MovieClip;

    public dynamic class Element_1_CircleINOUT2_888 extends MovieClip {

        public var bitYeah;

        public function Element_1_CircleINOUT2_888(){
            addFrameScript(0, frame1);
        }
        function frame1(){
            if (bitYeah == undefined){
                bitYeah = true;
                gotoAndPlay(Math.ceil((Math.random() * totalFrames)));
            };
        }

    }
}//package Game_fla

