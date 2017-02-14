// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//auraDisplay

package {
    import flash.display.MovieClip;

    public dynamic class auraDisplay extends MovieClip {

        public var t:MovieClip;

        public function auraDisplay(){
            addFrameScript(34, frame35);
        }
        function frame35(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

