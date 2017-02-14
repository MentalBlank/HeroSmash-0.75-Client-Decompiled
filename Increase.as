// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Increase

package {
    import flash.display.MovieClip;

    public dynamic class Increase extends MovieClip {

        public function Increase(){
            addFrameScript(21, frame22);
        }
        function frame22(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

