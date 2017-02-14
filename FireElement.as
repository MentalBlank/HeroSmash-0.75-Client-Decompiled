// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//FireElement

package {
    import flash.display.MovieClip;

    public dynamic class FireElement extends MovieClip {

        public function FireElement(){
            addFrameScript(21, frame22);
        }
        function frame22(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

