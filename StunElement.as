// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//StunElement

package {
    import flash.display.MovieClip;

    public dynamic class StunElement extends MovieClip {

        public function StunElement(){
            addFrameScript(29, frame30);
        }
        function frame30(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

