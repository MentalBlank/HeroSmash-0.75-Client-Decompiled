// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//mcPadName

package {
    import flash.display.MovieClip;

    public dynamic class mcPadName extends MovieClip {

        public var cnt:MovieClip;
        public var isOn;

        public function mcPadName(){
            addFrameScript(0, frame1, 4, frame5, 9, frame10, 19, frame20);
        }
        function frame10(){
            stop();
        }
        function frame1(){
            visible = false;
            isOn = false;
            stop();
        }
        function frame5(){
            visible = true;
        }
        function frame20(){
            visible = false;
            stop();
        }

    }
}//package 

