// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//xpDisplayBonus

package {
    import flash.display.MovieClip;

    public dynamic class xpDisplayBonus extends MovieClip {

        public var t:MovieClip;

        public function xpDisplayBonus(){
            addFrameScript(39, frame40);
        }
        function frame40(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

