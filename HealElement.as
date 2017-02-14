// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//HealElement

package {
    import flash.display.MovieClip;

    public dynamic class HealElement extends MovieClip {

        public function HealElement(){
            addFrameScript(21, frame22);
        }
        function frame22(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

