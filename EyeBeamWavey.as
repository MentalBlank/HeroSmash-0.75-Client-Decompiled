// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//EyeBeamWavey

package {
    import flash.display.MovieClip;

    public dynamic class EyeBeamWavey extends MovieClip {

        public function EyeBeamWavey(){
            addFrameScript(24, frame25);
        }
        function frame25(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

