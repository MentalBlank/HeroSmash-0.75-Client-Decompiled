// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//LightningFX

package {
    import flash.display.MovieClip;

    public dynamic class LightningFX extends MovieClip {

        public function LightningFX(){
            addFrameScript(39, frame40);
        }
        function frame40(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

