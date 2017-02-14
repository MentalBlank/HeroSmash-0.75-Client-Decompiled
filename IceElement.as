// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//IceElement

package {
    import flash.display.MovieClip;

    public dynamic class IceElement extends MovieClip {

        public function IceElement(){
            addFrameScript(16, frame17);
        }
        function frame17(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

