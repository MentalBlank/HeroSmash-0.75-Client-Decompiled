// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//ActionImpactTimer

package {
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.*;

    public class ActionImpactTimer extends EventDispatcher {

        var world:MovieClip;
        var aTimer:Timer;
        var actID:int;
        var actionResult:Object;

        public function kill(){
            if (((!((aTimer == null))) && (aTimer.running))){
                aTimer.stop();
            };
            aTimer.removeEventListener(TimerEvent.TIMER, triggerResult);
            aTimer = null;
            actionResult = null;
            world = null;
        }
        public function showImpact(del:int){
            aTimer = new Timer(del, 1);
            aTimer.addEventListener(TimerEvent.TIMER, triggerResult, false, 0, true);
            aTimer.start();
        }
        public function triggerResult(e:TimerEvent){
            world.showActionImpact(actionResult);
            kill();
        }

    }
}//package 

