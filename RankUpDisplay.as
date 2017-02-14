// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//RankUpDisplay

package {
    import flash.display.MovieClip;

    public dynamic class RankUpDisplay extends MovieClip {

        public var t:MovieClip;

        public function RankUpDisplay(){
            addFrameScript(37, frame38);
        }
        function frame38(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

