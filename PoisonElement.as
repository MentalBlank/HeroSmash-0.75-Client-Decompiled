// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//PoisonElement

package {
    import flash.display.MovieClip;

    public dynamic class PoisonElement extends MovieClip {

        public function PoisonElement(){
            addFrameScript(35, frame36);
        }
        function frame36(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

