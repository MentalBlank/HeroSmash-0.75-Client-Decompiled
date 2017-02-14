// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//CharpanelMC

package {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.Graphics;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.geom.ColorTransform;
    import flash.text.*;

    public class CharpanelMC extends MovieClip {

        private var spendStuC:Array;
        private var barVal:int = 150;
        private var stg:Object;
        private var uoLeaf:Object;
        private var nextMode:String;
        private var sta:Object;
        private var stu:Object;
        private var stp:Object;
        public var bg:MovieClip;
        public var cnt:MovieClip;
        private var uoData:Object;
        private var ttFields:Array;
        private var upts:int = -1;
        private var world:MovieClip;
        private var spendStpC:Array;
        public var bg2:MovieClip;
        private var rootClass:MovieClip;
        private var mcPopup:MovieClip;
        private var spendTicks:int = 0;
        private var spendStat:String = "none";
        private var spendOp:String = "";
        public var cnt2:MovieClip;
        private var pts:int = -1;
        private var spendVals:Array;

        public function CharpanelMC():void{
            rootClass = (stage.getChildAt(0) as MovieClip);
            world = (rootClass.world as MovieClip);
            mcPopup = rootClass.ui.mcPopup;
            uoLeaf = world.myLeaf();
            uoData = world.myAvatar.objData;
            sta = uoLeaf.sta;
            stp = new Object();
            stu = new Object();
            stg = new Object();
            pts = -1;
            upts = -1;
            spendStuC = [1595286, 1470895, 1410498, 1349844, 1289447, 1229821];
            spendStpC = [0xE66200, 0xEB7B00, 0xF08E00, 0xF4A100, 0xF9B400, 0xFFCC00];
            barVal = 150;
            spendStat = "none";
            spendOp = "";
            spendTicks = 0;
            spendVals = [{
                a:0,
                b:1
            }, {
                a:30,
                b:3
            }, {
                a:60,
                b:9
            }];
            ttFields = [];
            super();
            addFrameScript(0, frame1, 4, frame5, 11, frame12, 24, frame25);
            bg.btnClose.addEventListener(MouseEvent.MOUSE_DOWN, btnCloseClick, false, 0, true);
            bg.tTitle.text = "Character Overview";
            bg2.btnClose.addEventListener(MouseEvent.MOUSE_DOWN, btnCloseClick, false, 0, true);
            bg2.tTitle.text = "Class Overview";
            buildStu();
        }
        private function btnCloseClick(e:MouseEvent):void{
            fClose();
        }
        public function fClose():void{
            var bars:Array;
            var icons:Array;
            var mc:MovieClip;
            var i:int;
            var clip:* = undefined;
            var icon:MovieClip;
            var parentMC:MovieClip;
            if (MovieClip(this).currentLabel.indexOf("overview") > -1){
                try {
                    bars = [cnt.sl1, cnt.sl2, cnt.sl3, cnt.sl4, cnt.sl5, cnt.sl6];
                    icons = [cnt.abilities.a1, cnt.abilities.a2, cnt.abilities.a3, cnt.abilities.a4, cnt.abilities.p1, cnt.abilities.p2];
                    i = 0;
                    while (i < bars.length) {
                        mc = bars[i];
                        i = (i + 1);
                    };
                    for each (clip in ttFields) {
                        clip.removeEventListener(MouseEvent.MOUSE_OVER, onTTFieldMouseOver);
                        clip.removeEventListener(MouseEvent.MOUSE_OUT, onTTFieldMouseOut);
                    };
                    for each (icon in icons) {
                        icon.removeEventListener(MouseEvent.MOUSE_OVER, rootClass.actIconOver);
                        icon.addEventListener(MouseEvent.MOUSE_OUT, rootClass.actIconOut);
                        icon.actObj = null;
                    };
                }
                catch(e:Error) {
                };
            };
            bg.btnClose.removeEventListener(MouseEvent.MOUSE_DOWN, btnCloseClick);
            bg2.btnClose.removeEventListener(MouseEvent.MOUSE_DOWN, btnCloseClick);
            if (parent != null){
                parentMC = MovieClip(parent);
                parentMC.removeChild(this);
                parentMC.onClose();
            };
        }
        public function onTTFieldMouseOut(e:MouseEvent):void{
            rootClass.ui.ToolTip.close();
        }
        public function openWith(o:Object):void{
            nextMode = o.typ;
            if (isValidMode(nextMode)){
                if (((!((this.currentLabel == "init"))) && ((this.currentLabel.indexOf("-out") < 0)))){
                    this.gotoAndPlay((this.currentLabel + "-out"));
                }
                else {
                    this.gotoAndPlay(nextMode);
                };
            };
        }
        private function spendBarOver(e:MouseEvent):void{
            var mc:MovieClip;
            mc = (e.currentTarget as MovieClip);
            spendStat = "none";
            spendTicks = 0;
            mc.gotoAndPlay("in");
        }
        private function updateSpend():void{
            var mc:MovieClip;
            var bars:Array;
            var o:Object;
            var i:int;
            var j:int;
            var s:String;
            var vis:Boolean;
            var aura:Object;
            var wDPS:int;
            var wSPD:Number;
            var wDMG:Number;
            var AA:Object;
            var wItem:Object;
            var iRNG:Number;
            var wDMN:int;
            var wDMX:int;
            var tDmgStr:* = undefined;
            var icon:MovieClip;
            var g:Graphics;
            var n:int;
            var ox:int;
            var boxFill:Number;
            var textCol:String;
            trace("charPanel.updateSpend() > ");
            mc = MovieClip(this).cnt;
            bars = [mc.sl1, mc.sl2, mc.sl3, mc.sl4, mc.sl5, mc.sl6];
            o = {};
            i = 0;
            j = 0;
            s = "";
            vis = false;
            pts = rootClass.getInnateStats(uoLeaf.intLevel);
            upts = getUnusedPts();
            i = 0;
            while (i < rootClass.stats.length) {
                s = rootClass.stats[i];
                o[("_" + s)] = (stu[("_" + s)] + stp[("_" + s)]);
                i = (i + 1);
            };
            for (s in stg) {
                o[s] = stg[s];
            };
            rootClass.applyCoreStatRatings(o, uoLeaf);
            i = 0;
            while (i < uoLeaf.passives.length) {
                aura = uoLeaf.passives[i];
                if (aura.e != null){
                    j = 0;
                    while (j < aura.e.length) {
                        rootClass.applyAuraEffect(aura.e[j], o);
                        j = (j + 1);
                    };
                };
                i = (i + 1);
            };
            mc.tHit.text = rootClass.coeffToPct(Number(((1 - rootClass.baseMiss) + o.$thi)));
            mc.tHaste.text = rootClass.coeffToPct(o.$tha);
            mc.tCrit.text = rootClass.coeffToPct(o.$tcr);
            mc.tDodge.text = rootClass.coeffToPct(o.$tdo);
            mc.tAP.text = String(o.$ap);
            mc.tSP.text = String(o.$sp);
            wDPS = o.wDPS;
            wSPD = 2;
            wDMG = (wDPS * wSPD);
            AA = world.getAutoAttack();
            wItem = world.myAvatar.getEquippedItemBySlot("Weapon");
            iRNG = ((("iRng" in wItem)) ? wItem.iRng : 0);
            iRNG = (iRNG / 100);
            wDMG = (wDMG * AA.damage);
            wDMN = Math.floor((wDMG - (wDMG * iRNG)));
            wDMX = Math.ceil((wDMG + (wDMG * iRNG)));
            tDmgStr = (("<br><font color='#FFFFFF'>" + wDPS) + " DPS");
            tDmgStr = (tDmgStr + ((((((" (<font color='#999999'>" + wDMN) + "-") + wDMX) + ", ") + rootClass.numToStr((AA.cd / 1000), 1)) + " speed</font>)</font>"));
            mc.tDmg.htmlText = tDmgStr;
            i = 0;
            while (i < bars.length) {
                updateSpendPeg(bars[i]);
                vis = updateSpendBar(bars[i]);
                i = (i + 1);
            };
            mc = MovieClip(this).cnt2;
            o = {};
            i = 0;
            j = 0;
            s = "";
            mc.tDesc.autoSize = "left";
            mc.tMana.autoSize = "left";
            mc.tClass.text = (((uoData.strClassName + "  (Rank ") + uoData.iRank) + ")");
            mc.tDesc.text = uoData.sClassDesc;
            mc.tMana.text = "";
            for each (s in uoData.aClassMRM) {
                if (s.charAt(0) == "-"){
                    mc.tMana.text = (mc.tMana.text + ((" * " + s.substr(1)) + "\n"));
                }
                else {
                    mc.tMana.text = (mc.tMana.text + (s + "\n"));
                };
            };
            mc.tManaHeader.y = Math.round(((mc.tDesc.y + mc.tDesc.height) + 5));
            mc.tMana.y = Math.round(((mc.tManaHeader.y + mc.tManaHeader.height) + 2));
            i = Math.round((mc.tMana.y + mc.tMana.height));
            mc.abilities.y = Math.round((i + ((188 - i) / 2)));
            if (mc.abilities.y > 188){
                mc.abilities.y = 188;
            };
            for each (o in world.actions.active) {
                try {
                    icon = (mc.abilities.getChildByName(o.ref) as MovieClip);
                }
                catch(e:Error) {
                    icon = null;
                };
                if (icon != null){
                    icon.tQty.visible = false;
                    rootClass.updateIcons([icon], o.icon.split(","), null);
                    if (!o.isOK){
                        icon.alpha = 0.33;
                    };
                    icon.actObj = o;
                    icon.addEventListener(MouseEvent.MOUSE_OVER, rootClass.actIconOver, false, 0, true);
                    icon.addEventListener(MouseEvent.MOUSE_OUT, rootClass.actIconOut, false, 0, true);
                };
            };
            for each (o in world.actions.passive) {
                icon = mc.abilities.getChildByName(o.ref);
                icon.tQty.visible = false;
                rootClass.updateIcons([icon], o.icon.split(","), null);
                if (!o.isOK){
                    icon.alpha = 0.33;
                };
                icon.actObj = o;
                icon.addEventListener(MouseEvent.MOUSE_OVER, rootClass.actIconOver, false, 0, true);
                icon.addEventListener(MouseEvent.MOUSE_OUT, rootClass.actIconOut, false, 0, true);
            };
            g = mc.abilities.bg.graphics;
            g.clear();
            g.lineStyle(0, 0, 0);
            n = 0;
            ox = 0;
            boxFill = 0x666666;
            textCol = "#FFFFFF";
            n = 0;
            while (n < 5) {
                ox = (n * 51);
                boxFill = 0x666666;
                textCol = "#FFFFFF";
                if (uoData.iRank < (n + 1)){
                    boxFill = 0x242424;
                    textCol = "#999999";
                    g.beginFill(boxFill);
                    g.moveTo(ox, 19);
                    g.lineTo((ox + 50), 19);
                    g.lineTo((ox + 50), 127);
                    g.lineTo(ox, 127);
                    g.lineTo(ox, 19);
                    g.endFill();
                };
                g.beginFill(boxFill);
                g.moveTo(ox, 0);
                g.lineTo((ox + 50), 0);
                g.lineTo((ox + 50), 18);
                g.lineTo(ox, 18);
                g.lineTo(ox, 0);
                g.endFill();
                g.beginFill(boxFill);
                g.moveTo(ox, 128);
                g.lineTo((ox + 50), 128);
                g.lineTo((ox + 50), 132);
                g.lineTo(ox, 132);
                g.lineTo(ox, 128);
                g.endFill();
                TextField(mc.abilities.getChildByName(("tRank" + (n + 1)))).htmlText = (((("<font color='" + textCol) + "'>") + TextField(mc.abilities.getChildByName(("tRank" + (n + 1)))).text) + "</font>");
                n = (n + 1);
            };
        }
        function frame12(){
            stop();
        }
        private function spendBarOut(e:MouseEvent):void{
            var mc:MovieClip;
            mc = (e.currentTarget as MovieClip);
            spendStat = "none";
            spendTicks = 0;
            mc.gotoAndPlay("out");
        }
        private function spendEF(e:Event):void{
            if (spendStat != "none"){
                spendPts();
                spendTicks++;
                updateSpend();
            };
        }
        private function getUnusedPts():int{
            var i:int;
            var s:String;
            i = pts;
            for (s in stu) {
                if ((((s.indexOf("_") > -1)) && ((rootClass.stats.indexOf(s.substr(1)) > -1)))){
                    i = (i - (int(stu[s]) + int(stp[s])));
                };
            };
            return (0);
        }
        private function playNextMode():void{
            if (this.currentLabel == "overview"){
            };
            if (this.currentLabel == "enh"){
            };
            this.gotoAndPlay(nextMode);
        }
        function frame5(){
            update();
        }
        private function btnAcceptClick(e:MouseEvent):void{
            var mc:MovieClip;
            var resA:Array;
            mc = (e.currentTarget as MovieClip);
            resA = [int((stu._STR + stp._STR)), int((stu._DEX + stp._DEX)), int((stu._END + stp._END)), int((stu._INT + stp._INT)), int((stu._WIS + stp._WIS)), int((stu._LCK + stp._LCK))];
            if (world.coolDown("equipItem")){
                rootClass.sfc.sendXtMessage("zm", "statsSave", resA, "str", rootClass.world.curRoom);
                mc.visible = false;
            }
            else {
                rootClass.addUpdate("Please allow time for requests to complete before submitting additional requests.");
            };
        }
        function frame25(){
            playNextMode();
        }
        private function spendPts():void{
            var n:int;
            var i:int;
            n = 0;
            i = 0;
            while (i < spendVals.length) {
                if (spendTicks > spendVals[i].a){
                    n = spendVals[i].b;
                };
                i++;
            };
            if (spendOp == "+"){
                if (upts > 0){
                    if (n > upts){
                        n = upts;
                    };
                    stu[spendStat] = (stu[spendStat] + n);
                };
            }
            else {
                if (stu[spendStat] > 0){
                    if (n > stu[spendStat]){
                        n = stu[spendStat];
                    };
                    stu[spendStat] = (stu[spendStat] - n);
                };
            };
        }
        private function isValidMode(str:String):Boolean{
            var res:Boolean;
            var i:int;
            res = false;
            i = 0;
            while ((((i < this.currentLabels.length)) && (!(res)))) {
                if (this.currentLabels[i].name == str){
                    res = true;
                };
                i++;
            };
            return (res);
        }
        private function spendBarClick(e:MouseEvent):void{
            var mc:MovieClip;
            mc = MovieClip(e.currentTarget);
            spendOp = "+";
            if (mc.hitL.hitTestPoint(stage.mouseX, stage.mouseY)){
                if (mc.name.indexOf("l") > -1){
                    spendOp = "-";
                };
                spendStat = mc.a;
            }
            else {
                if (mc.hitR.hitTestPoint(stage.mouseX, stage.mouseY)){
                    if (mc.name.indexOf("r") > -1){
                        spendOp = "-";
                    };
                    spendStat = mc.a;
                }
                else {
                    spendStat = "none";
                };
            };
            spendTicks = 0;
        }
        private function update():void{
            var bars:Array;
            var clip:*;
            var mc:MovieClip;
            var signLX:int;
            var signRX:int;
            var i:int;
            if (MovieClip(this).currentLabel == "overview"){
                bars = [cnt.sl1, cnt.sl2, cnt.sl3, cnt.sl4, cnt.sl5, cnt.sl6];
                ttFields = [cnt.sl1, cnt.sl2, cnt.sl3, cnt.sl4, cnt.sl5, cnt.sl6, cnt.tAP, cnt.tSP, cnt.tDmg, cnt.tHitTF, cnt.tHasteTF, cnt.tCritTF, cnt.tDodgeTF, cnt.tSTR, cnt.tINT, cnt.tEND, cnt.tDEX, cnt.tWIS, cnt.tLCK];
                for each (clip in ttFields) {
                    clip.removeEventListener(MouseEvent.MOUSE_OVER, onTTFieldMouseOver);
                    clip.removeEventListener(MouseEvent.MOUSE_OUT, onTTFieldMouseOut);
                    clip.addEventListener(MouseEvent.MOUSE_OVER, onTTFieldMouseOver, false, 0, true);
                    clip.addEventListener(MouseEvent.MOUSE_OUT, onTTFieldMouseOut, false, 0, true);
                };
                signLX = bars[0].signs.bplus.x;
                signRX = bars[0].signs.bminus.x;
                i = 0;
                while (i < bars.length) {
                    mc = bars[i];
                    mc.hitL.alpha = 0;
                    mc.hitR.alpha = 0;
                    if (mc.name == "sl1"){
                        mc.a = "_STR";
                    };
                    if (mc.name == "sl2"){
                        mc.a = "_INT";
                    };
                    if (mc.name == "sl3"){
                        mc.a = "_END";
                    };
                    if (mc.name == "sl4"){
                        mc.a = "_DEX";
                    };
                    if (mc.name == "sl5"){
                        mc.a = "_WIS";
                    };
                    if (mc.name == "sl6"){
                        mc.a = "_LCK";
                    };
                    if (mc.name.indexOf("l") > -1){
                        mc.m = "right";
                        mc.signs.bplus.x = signRX;
                        mc.signs.bminus.x = signLX;
                    }
                    else {
                        mc.m = "left";
                    };
                    i++;
                };
                updateSpend();
            };
        }
        private function updateSpendPeg(mc:MovieClip):void{
            var m:String;
            var stpa:int;
            var stga:int;
            var gap:int;
            var stpc:int;
            var bgCol:Number;
            var bCT:ColorTransform;
            m = mc.m;
            stpa = stp[mc.a];
            stga = stg[("^" + mc.a.substr(1))];
            gap = (stpa % barVal);
            stpc = Math.floor((stpa / barVal));
            if (stpc == 0){
                if (!mc.bar.peg.visible){
                    mc.bar.peg.visible = true;
                };
            }
            else {
                if (mc.bar.peg.visible){
                    mc.bar.peg.visible = false;
                };
            };
            if (int(mc.t1.text) != stpa){
                bCT = new ColorTransform();
                mc.t1.text = stpa;
                if (stga > 0){
                    if (mc.t2.text != ("+" + stga)){
                        mc.t2.text = ("+" + stga);
                    };
                }
                else {
                    if (mc.t2.text != ""){
                        mc.t2.text = "";
                    };
                };
                if (stpa > 0){
                    if (m == "left"){
                        mc.bar.peg.x = (mc.bar.peg.width - gap);
                    }
                    else {
                        mc.bar.peg.x = (gap - mc.bar.peg.width);
                    };
                    if (mc.bar.peg.transform.colorTransform.color != spendStpC[stpc]){
                        bCT = new ColorTransform();
                        bCT.color = spendStpC[stpc];
                        mc.bar.peg.transform.colorTransform = bCT;
                    };
                };
                if (stpc > 0){
                    bgCol = spendStpC[(stpc - 1)];
                }
                else {
                    bgCol = 0;
                };
                if (mc.bar.b2.transform.colorTransform.color != bgCol){
                    bCT = new ColorTransform();
                    bCT.color = bgCol;
                    mc.bar.b2.transform.colorTransform = bCT;
                };
            };
        }
        private function updateSpendBar(mc:MovieClip):Boolean{
            var m:String;
            var stua:int;
            var stpa:int;
            var b1gap:int;
            var stuc:int;
            var stpc:int;
            var bgCol:Number;
            var inuse:Boolean;
            var bCT:ColorTransform;
            m = mc.m;
            stua = stu[mc.a];
            stpa = stp[mc.a];
            inuse = false;
            b1gap = ((stua + stpa) % barVal);
            stuc = Math.floor(((stua + stpa) / barVal));
            stpc = Math.floor((stpa / barVal));
            if (stua == 0){
                if (mc.bar.b1.visible){
                    mc.bar.b1.visible = false;
                };
            }
            else {
                if (!mc.bar.b1.visible){
                    mc.bar.b1.visible = true;
                };
            };
            if (stuc == 0){
                if (stpa == 0){
                    if (mc.bar.peg.visible){
                        mc.bar.peg.visible = false;
                    };
                }
                else {
                    if (!mc.bar.peg.visible){
                        mc.bar.peg.visible = true;
                    };
                };
            }
            else {
                if (mc.bar.peg.visible){
                    mc.bar.peg.visible = false;
                };
            };
            if (int(mc.t1.text) != (stua + stpa)){
                bCT = new ColorTransform();
                mc.t1.text = (stua + stpa);
                if (stua > 0){
                    inuse = true;
                    if (m == "left"){
                        mc.bar.b1.x = (mc.bar.b1.width - b1gap);
                    }
                    else {
                        mc.bar.b1.x = (b1gap - mc.bar.b1.width);
                    };
                    if (mc.bar.b1.transform.colorTransform.color != spendStuC[stuc]){
                        bCT = new ColorTransform();
                        bCT.color = spendStuC[stuc];
                        mc.bar.b1.transform.colorTransform = bCT;
                    };
                    if (stuc > 0){
                        bgCol = spendStuC[(stuc - 1)];
                    }
                    else {
                        if (stpc > 0){
                            bgCol = spendStpC[(stpc - 1)];
                        }
                        else {
                            bgCol = 0;
                        };
                    };
                }
                else {
                    if (stpc > 0){
                        bgCol = spendStpC[(stpc - 1)];
                    }
                    else {
                        bgCol = 0;
                    };
                };
                if (mc.bar.b2.transform.colorTransform.color != bgCol){
                    bCT = new ColorTransform();
                    bCT.color = bgCol;
                    mc.bar.b2.transform.colorTransform = bCT;
                };
            };
            return (inuse);
        }
        private function spendBarRelease(e:MouseEvent):void{
            spendStat = "none";
            spendTicks = 0;
        }
        private function onTTFieldMouseOver(e:MouseEvent):void{
            var fieldName:String;
            var ttStr:String;
            fieldName = e.currentTarget.name;
            ttStr = "";
            switch (fieldName){
                case "tPt1":
                    ttStr = "Number of stat points remaining to spend via the bars below.";
                    break;
                case "tPt2":
                    ttStr = "Total number of stat points currently available to your character.";
                    break;
                case "tAP":
                    ttStr = "<b>Attack Power</b> increases the effectiveness of your physical damage attacks.";
                    break;
                case "tSP":
                    ttStr = "<b>Magic Power</b> increases the effectiveness of your magical damage attacks.";
                    break;
                case "tDmg":
                    ttStr = "This is the damage you would expect to see on a normal melee hit, before any other modifiers.";
                    break;
                case "tHP":
                    ttStr = "Your total <b>Hit Points</b>.  When these reach zero, you will need to wait a short time before being able to continue playing.";
                    break;
                case "tHitTF":
                    ttStr = "<b>Hit chance</b> determines how likely you are to hit a target, before any other modifiers.";
                    break;
                case "tHasteTF":
                    ttStr = "<b>Haste</b> reduces the cooldown on all of your attacks and spells, including Auto Attack, by a certain percentage (hard capped at 50%).";
                    break;
                case "tCritTF":
                    ttStr = "<b>Critical Strike chance</b> increases the likelihood of dealing additional damage on a any attack.";
                    break;
                case "tDodgeTF":
                    ttStr = "<b>Evasion</b> chance allows you to completely avoid incoming damage.";
                    break;
                case "tSTR":
                case "sl1":
                    ttStr = "<b>Strength</b> increases Attack Power, which boosts physical damage. It also improves Critical Strike chance for melee classes.";
                    break;
                case "tINT":
                case "sl2":
                    ttStr = "<b>Intellect</b> increases Magic Power, which boosts magical damage. It also improves Haste for caster classes.";
                    break;
                case "tEND":
                case "sl3":
                    ttStr = "<b>Endurance</b> directly contributes to your total Hit Points.  While very useful for all classes, some abilities work best with very high or very low total HP.";
                    break;
                case "tDEX":
                case "sl4":
                    ttStr = "<b>Dexterity</b> is valuable to melee classes. It increases Haste, Hit chance, and Evasion chance. It increases only Evasion chance for caster classes.";
                    break;
                case "tWIS":
                case "sl5":
                    ttStr = "<b>Wisdom</b> is valuable to caster classes. It increases Hit chance, Crit chance, and Evasion chance. It improves only Evasion chance for melee classes.";
                    break;
                case "tLCK":
                case "sl6":
                    ttStr = "<b>Luck</b> offers a moderate overall improvement in combat, but is extremely valuable to those classes which specialize in games of chance.  It may also have effects outside of combat.";
                    break;
            };
            rootClass.ui.ToolTip.openWith({str:ttStr});
        }
        function frame1(){
            openWith(MovieClip(parent).fData);
        }
        private function buildStu(){
            var innate:Object;
            var s:String;
            var i:int;
            var slot:String;
            var gearStat:String;
            innate = rootClass.getCategoryStats(uoData.sClassCat, uoLeaf.intLevel);
            s = "";
            i = 0;
            i = 0;
            while (i < rootClass.stats.length) {
                s = rootClass.stats[i];
                stg[("^" + s)] = 0;
                stp[("_" + s)] = Math.floor(innate[s]);
                stu[("_" + s)] = 0;
                i++;
            };
            for (slot in uoLeaf.tempSta) {
                if (slot != "innate"){
                    for (gearStat in uoLeaf.tempSta[slot]) {
                        if (stg[("^" + gearStat)] == null){
                            stg[("^" + gearStat)] = 0;
                        };
                        stg[("^" + gearStat)] = (stg[("^" + gearStat)] + int(uoLeaf.tempSta[slot][gearStat]));
                    };
                };
            };
        }

    }
}//package 

