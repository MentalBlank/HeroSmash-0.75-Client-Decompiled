// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//mcQuestpopup

package {
    import flash.display.MovieClip;
    import flash.text.TextField;
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

    public dynamic class mcQuestpopup extends MovieClip {

        public var tFaction:TextField;
        public var Faction:String;
        public var tIcon:TextField;
        public var tGold:TextField;
        public var mTitle:String;
        public var intFaction:String;
        public var tTitle:TextField;
        public var tFactionP:TextField;
        public var intXp:String;
        public var tXp:TextField;
        public var qbox:MovieClip;
        public var rootClass;
        public var sIcon:String;
        public var intGold:String;

        public function mcQuestpopup(){
            addFrameScript(0, frame1, 6, frame7, 19, frame20, 32, frame33, 37, frame38, 45, frame46, 50, frame51, 58, frame59, 63, frame64, 65, frame66, 145, frame146);
        }
        function frame64(){
            trace((tFaction.text + " - Faction"));
            if (Faction != "None"){
                trace("Going into Faction");
                qbox.faction.gotoAndPlay("On");
                rootClass.mixer.playSound("ClickMagic");
            };
        }
        function frame7(){
            intXp = tXp.text;
            intGold = tGold.text;
            intFaction = tFactionP.text;
            Faction = tFaction.text;
            mTitle = tTitle.text;
            sIcon = tIcon.text;
            rootClass = MovieClip(stage.getChildAt(0));
            trace(((((((((intXp + ":") + intGold) + ":") + intFaction) + ":") + Faction) + ":") + mTitle));
            visible = true;
        }
        function frame1(){
            visible = false;
            Faction = "None";
            tXp.visible = (tGold.visible = (tFactionP.visible = (tFaction.visible = false)));
            stop();
        }
        function frame20(){
            qbox.qTitle.qTitle.tName.text = mTitle;
            qbox.qTitle.gotoAndPlay("On");
            if (Faction != null){
                qbox.factionAnim.tFaction.factionTitle.text = Faction;
            };
        }
        function frame38(){
            qbox.fame.gotoAndPlay("On");
            rootClass.mixer.playSound("ClickMagic");
        }
        function frame33(){
            qbox.fameAnim.gotoAndPlay("On");
        }
        function frame46(){
            qbox.xpAnim.gotoAndPlay("On");
        }
        function frame51(){
            qbox.xp.gotoAndPlay("On");
            rootClass.mixer.playSound("ClickMagic");
        }
        function frame59(){
            if (Faction != "None"){
                qbox.factionAnim.gotoAndPlay("On");
            };
        }
        function frame146(){
            MovieClip(parent).removeChild(this);
            stop();
        }
        function frame66(){
            if (sIcon != "None"){
                qbox.aIcon.gotoAndPlay("On");
            };
        }

    }
}//package 

