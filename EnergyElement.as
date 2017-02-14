// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//EnergyElement

package {
    import flash.display.MovieClip;

    public dynamic class EnergyElement extends MovieClip {

        public function EnergyElement(){
            addFrameScript(18, frame19);
        }
        function frame19(){
            MovieClip(parent).removeChild(this);
            stop();
        }

    }
}//package 

