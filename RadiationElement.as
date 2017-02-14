// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//RadiationElement

package {
    import flash.display.MovieClip;

    public dynamic class RadiationElement extends MovieClip {

        public function RadiationElement(){
            addFrameScript(35, frame36);
        }
        function frame36(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

