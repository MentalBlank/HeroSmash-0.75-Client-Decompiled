// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Killvis

package {
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.display.MovieClip;

    public class Killvis extends EventDispatcher {

        var vobj;
        var vTimer:Timer;

        public function Killvis(){
            vTimer = new Timer(1000, 1);
            super();
            vTimer.addEventListener(TimerEvent.TIMER, noVis, false, 0, true);
        }
        public function kill(obj:Object, del:int){
            this.vobj = obj;
            vTimer.delay = del;
            vTimer.reset();
            vTimer.start();
        }
        public function stopkill(){
            if (((!((vTimer == null))) && (vTimer.running))){
                vTimer.stop();
            };
        }
        public function resetkill(){
            if (((!((vTimer == null))) && (vTimer.running))){
                vTimer.reset();
                vTimer.start();
            };
        }
        public function noVis(e:TimerEvent){
            vobj.visible = false;
            MovieClip(MovieClip(vobj).parent).kv = null;
        }

    }
}//package 

