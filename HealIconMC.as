// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//HealIconMC

package {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;

    public class HealIconMC extends MovieClip {

        private var world:MovieClip;
        public var hit:MovieClip;
        public var shp:MovieClip;
        private var avt:Avatar;

        public function HealIconMC(myAvt:Avatar, worldMC:MovieClip):void{
            addFrameScript(35, frame36);
            world = worldMC;
            avt = myAvt;
            hit.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
            hit.buttonMode = true;
            hit.alpha = 0;
            shp.mouseEnabled = false;
            shp.mouseChildren = false;
            y = ((avt.pMC.pname.y - height) - 5);
            x = (x - int((width / 2)));
        }
        public function fClose():void{
            stop();
            hit.removeEventListener(MouseEvent.CLICK, onClick);
            parent.removeChild(this);
        }
        function frame36(){
            gotoAndPlay("loop");
        }
        public function onClick(e:MouseEvent):void{
            world.healByIcon(avt);
            fClose();
        }

    }
}//package 

