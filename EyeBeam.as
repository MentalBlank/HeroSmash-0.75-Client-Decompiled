// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//EyeBeam

package {
    import flash.display.MovieClip;

    public dynamic class EyeBeam extends MovieClip {

        public function EyeBeam(){
            addFrameScript(19, frame20);
        }
        function frame20(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

