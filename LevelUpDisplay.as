// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//LevelUpDisplay

package {
    import flash.display.MovieClip;

    public dynamic class LevelUpDisplay extends MovieClip {

        public var t:MovieClip;

        public function LevelUpDisplay(){
            addFrameScript(37, frame38);
        }
        function frame38(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

