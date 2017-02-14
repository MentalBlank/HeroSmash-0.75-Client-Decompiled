// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//MentalElement

package {
    import flash.display.MovieClip;

    public dynamic class MentalElement extends MovieClip {

        public function MentalElement(){
            addFrameScript(33, frame34);
        }
        function frame34(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

