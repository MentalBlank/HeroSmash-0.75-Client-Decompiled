// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//InventoryItem

package {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
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

    public dynamic class InventoryItem extends MovieClip {

        public var strIndex:TextField;
        public var bg:MovieClip;
        public var mcCoin:MovieClip;
        public var strName:TextField;
        public var isEq:Boolean;
        public var btnSelect:SimpleButton;
        public var icon:MovieClip;
        public var mcMember:MovieClip;
        public var strLevel:TextField;
        public var isSel:Boolean;
        public var equipped:MovieClip;

        public function InventoryItem(){
            addFrameScript(0, frame1);
        }
        public function select():void{
            bg.selected.visible = true;
            isSel = true;
        }
        public function clearText():void{
            strName.text = "";
            strLevel.text = "";
            icon.visible = false;
        }
        public function unequip():void{
            isEq = false;
            bg.equipped.visible = false;
        }
        public function equip():void{
            isEq = true;
            bg.equipped.visible = true;
        }
        function frame1(){
            isEq = false;
            isSel = false;
            stop();
        }
        public function reset():void{
            bg.selected.visible = false;
            isSel = false;
        }

    }
}//package 

