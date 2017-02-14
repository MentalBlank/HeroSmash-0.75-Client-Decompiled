// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Decrease

package {
    import flash.display.MovieClip;

    public dynamic class Decrease extends MovieClip {

        public function Decrease(){
            addFrameScript(21, frame22);
        }
        function frame22(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

