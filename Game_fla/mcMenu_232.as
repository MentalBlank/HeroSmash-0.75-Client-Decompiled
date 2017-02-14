// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcMenu_232

package Game_fla{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.system.*;
    import flash.text.*;
    import flash.net.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.filters.*;
    import flash.ui.*;
    import flash.external.*;
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.xml.*;

    public dynamic class mcMenu_232 extends MovieClip {

        public var btnBag:SimpleButton;
        public var btnHouse:SimpleButton;
        public var mcHal:MovieClip;
        public var btnRest:SimpleButton;
        public var btnFly:SimpleButton;
        public var btnBook:SimpleButton;
        public var btnMap:SimpleButton;
        public var btnChar:MovieClip;
        public var btnQuest:SimpleButton;
        public var btnOption:SimpleButton;

        public function mcMenu_232(){
            addFrameScript(0, frame1);
        }
        public function onMouseOver(e:MouseEvent){
            var rootClass:*;
            var tt:*;
            rootClass = MovieClip(stage.getChildAt(0));
            tt = MovieClip(stage.getChildAt(0)).ui.ToolTip;
            switch (e.currentTarget.name){
                case "btnRest":
                    tt.openWith({str:"Rest"});
                    break;
                case "btnBag":
                    tt.openWith({str:"Inventory"});
                    break;
                case "btnTemp":
                    tt.openWith({str:"Temp Inventory"});
                    break;
                case "btnMap":
                    tt.openWith({str:"Map"});
                    break;
                case "btnOption":
                    tt.openWith({str:"Options"});
                    break;
                case "btnQuest":
                    tt.openWith({str:"Missions"});
                    break;
                case "btnBook":
                    tt.openWith({str:"H.A.L. Droid"});
                    break;
                case "btnHouse":
                    tt.openWith({str:"House"});
                    break;
                case "btnChar":
                    tt.openWith({str:"Character Panel"});
                    break;
                case "btnFly":
                    if (rootClass.world.myAvatar.pMC.fly){
                        tt.openWith({str:"Land"});
                    }
                    else {
                        tt.openWith({str:"Fly"});
                    };
                    break;
            };
        }
        public function onMouseClick(e:MouseEvent){
            var rootClass:*;
            rootClass = MovieClip(stage.getChildAt(0));
            MovieClip(Game.root).mixer.playSound("Click");
            switch (e.currentTarget.name){
                case "btnRest":
                    MovieClip(parent.parent.parent).world.rest();
                    break;
                case "btnBag":
                    toggleInventory();
                    break;
                case "btnTemp":
                    toggleTempInventory();
                    break;
                case "btnMap":
                    if (rootClass.ui.mcPopup.currentLabel == "Map"){
                        rootClass.ui.mcPopup.onClose();
                    }
                    else {
                        rootClass.ui.mcPopup.fOpen("Map");
                    };
                    break;
                case "btnBook":
                    if (rootClass.ui.mcPopup.currentLabel == "Book"){
                        rootClass.ui.mcPopup.onClose();
                    }
                    else {
                        rootClass.ui.mcPopup.fOpen("Book");
                    };
                    break;
                case "btnOption":
                    if (rootClass.ui.mcPopup.currentLabel == "Option"){
                        rootClass.ui.mcPopup.onClose();
                    }
                    else {
                        rootClass.ui.mcPopup.fOpen("Option");
                    };
                    break;
                case "btnQuest":
                    rootClass.world.toggleQuestLog();
                    break;
                case "btnHouse":
                    if (rootClass.ui.mcPopup.currentLabel == "House"){
                        rootClass.ui.mcPopup.onClose();
                    }
                    else {
                        rootClass.ui.mcPopup.fOpen("House");
                    };
                    break;
                case "btnChar":
                    break;
                case "btnFly":
                    rootClass.world.flyToggle();
                    break;
            };
        }
        public function toggleTempInventory():void{
            var rootClass:*;
            rootClass = MovieClip(stage.getChildAt(0));
            if (!rootClass.world.uiLock){
                if (rootClass.ui.mcPopup.currentLabel == "Temp"){
                    rootClass.ui.mcPopup.onClose();
                }
                else {
                    rootClass.ui.mcPopup.fOpen("Temp");
                };
            };
        }
        function frame1(){
            btnRest.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            btnRest.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            btnBag.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            btnBag.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            btnMap.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            btnMap.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            btnOption.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            btnOption.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            btnQuest.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            btnQuest.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            btnRest.addEventListener(MouseEvent.CLICK, onMouseClick);
            btnBag.addEventListener(MouseEvent.CLICK, onMouseClick);
            btnOption.addEventListener(MouseEvent.CLICK, onMouseClick);
            btnMap.addEventListener(MouseEvent.CLICK, onMouseClick);
            btnQuest.addEventListener(MouseEvent.CLICK, onMouseClick);
            btnBook.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            btnBook.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            btnBook.addEventListener(MouseEvent.CLICK, onMouseClick);
            btnHouse.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            btnHouse.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            btnHouse.addEventListener(MouseEvent.CLICK, onMouseClick);
            btnChar.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            btnChar.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            btnChar.addEventListener(MouseEvent.CLICK, onMouseClick);
            btnFly.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            btnFly.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            btnFly.addEventListener(MouseEvent.CLICK, onMouseClick);
        }
        public function onMouseOut(e:MouseEvent){
            var rootClass:*;
            var tt:*;
            rootClass = MovieClip(stage.getChildAt(0));
            tt = MovieClip(stage.getChildAt(0)).ui.ToolTip;
            if (tt.t.running){
                tt.t.stop();
            };
            tt.close();
        }
        public function toggleInventory():void{
            var rootClass:*;
            rootClass = MovieClip(stage.getChildAt(0));
            if (!rootClass.world.uiLock){
                if (rootClass.ui.mcPopup.currentLabel == "Inventory"){
                    rootClass.ui.mcPopup.onClose();
                }
                else {
                    rootClass.ui.mcPopup.fOpen("Inventory");
                };
            };
        }

    }
}//package Game_fla

