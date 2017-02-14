// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//AvatarMC

package {
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import flash.system.ApplicationDomain;
    import fl.motion.Color;
    import flash.events.IOErrorEvent;
    import flash.utils.getDefinitionByName;
    import flash.display.Graphics;

    public class AvatarMC extends MovieClip {

        private var walkTS:Number;
        public var mcChar:MovieClip;
        private var xTar;
        private var nDuration;
        public var strGender:String;
        public var framePrefix:String = "";
        public var proxy:MovieClip;
        private var yTar:Number;
        private var xDep;
        private var tp:Point;
        public var tx;
        public var defaultCT:ColorTransform;
        public var ty:Number;
        private var totalTransform:Object;
        private var jumpOP:Point;
        public var bubble:MovieClip;
        public var pAV:Avatar;
        public var bFly:Boolean = false;
        public var previousframe:int = -1;
        public var STAGE:MovieClip;
        private var bLoadingHelm:Boolean = false;
        private var jumpTargetY:Number;
        private var yDep;
        public var bFlyTransition:Boolean = false;
        private var objLinks:Object;
        public var pname:MovieClip;
        private var nYStep;
        public var shadow:MovieClip;
        private var heavyAssets:Array;
        private var jumpTS:Number;
        private var bLanding:Boolean;
        public var kv:Killvis = null;
        private var animQueue:Array;
        private var headPoint:Point;
        public var world:MovieClip;
        private var walkD:Number;
        private var nXStep;
        public var rootClass:MovieClip;
        public var isLoaded:Boolean = false;
        public var ignore:MovieClip;
        public var CT1:ColorTransform;
        private var op:Point;
        public var CT3:ColorTransform;
        public var CT2:ColorTransform;
        public var hpBar:MovieClip;
        public var spFX:Object;
        public var bBackHair:Boolean = false;
        private var clampedTransform:ColorTransform;
        public var hitboxR:Rectangle;
        private var walkSpeed:Number;

        public function AvatarMC():void{
            var c:Class;
            bLoadingHelm = false;
            objLinks = {};
            heavyAssets = [];
            totalTransform = {
                alphaMultiplier:1,
                alphaOffset:0,
                redMultiplier:1,
                redOffset:0,
                greenMultiplier:1,
                greenOffset:0,
                blueMultiplier:1,
                blueOffset:0
            };
            clampedTransform = new ColorTransform();
            animQueue = [];
            spFX = {};
            bBackHair = false;
            isLoaded = false;
            kv = null;
            defaultCT = MovieClip(this).transform.colorTransform;
            previousframe = -1;
            CT3 = new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0);
            CT2 = new ColorTransform(1, 1, 1, 1, 127, 127, 127, 0);
            CT1 = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
            framePrefix = "";
            bFly = false;
            bFlyTransition = false;
            super();
            addFrameScript(0, frame1, 5, frame6, 8, frame9, 10, frame11, 12, frame13, 13, frame14, 14, frame15, 18, frame19, 20, frame21, 23, frame24);
            rootClass = Game.root;
            c = rootClass.getAssetClass("Skeleton");
            mcChar = MovieClip(this.addChildAt(new (c)(), 1));
            mcChar.alpha = 0;
            headPoint = new Point(0, (this.mcChar.head.y - (1.6 * this.mcChar.head.height)));
            ignore.visible = false;
            bubble.mouseEnabled = (bubble.mouseChildren = false);
            shadow.mouseEnabled = (shadow.mouseChildren = false);
            this.addEventListener(Event.ENTER_FRAME, checkQueue, false, 0, true);
            bubble.visible = false;
            bubble.t = "";
            pname.ti.text = "";
            hideHPBar();
            gotoAndPlay("hold");
        }
        public function loadArmor(strFilename:String, sLink:String):void{
            trace("** PMC loadArmor >");
            objLinks.ar = sLink;
            rootClass.loadermanager.queueLoad({
                strFile:((Game.serverFilePath + "items/armor/") + strFilename),
                callBackA:onLoadArmorComplete,
                callBackB:ioErrorHandler,
                avt:pAV,
                sES:"ar"
            });
        }
        public function setHelmVisibility(b:Boolean):void{
            trace(("setHelmVisibility > " + b));
            if (((!((pAV.objData.eqp.he == null))) && (!((pAV.objData.eqp.he.sLink == null))))){
                if (b){
                    mcChar.head.helm.visible = true;
                    mcChar.head.hair.visible = false;
                    mcChar.backhair.visible = false;
                }
                else {
                    mcChar.head.helm.visible = false;
                    mcChar.head.hair.visible = true;
                    mcChar.backhair.visible = bBackHair;
                };
                if (pAV == world.myAvatar){
                    world.rootClass.showPortrait(pAV);
                };
                if (pAV == world.myAvatar.target){
                    world.rootClass.showPortraitTarget(pAV);
                };
            };
        }
        private function onJumpEnterFrame(e:Event):void{
            var now:Number;
            var f:Number;
            var jumpY:int;
            var deltaY:Number;
            now = new Date().getTime();
            f = (((now - jumpTS) * 24) / 1000);
            jumpY = (-96 * this.mcChar.scaleY);
            if (f >= 10){
                deltaY = (((jumpY * 2) / 3) + (((f - 10) * jumpY) / (3 * 6)));
                this.y = (jumpOP.y + deltaY);
            };
            if (f >= 16){
                this.y = (jumpOP.y + jumpY);
                this.removeEventListener(Event.ENTER_FRAME, onJumpEnterFrame);
                bFlyTransition = false;
            };
            if (this.pAV.isMyAvatar){
                rootClass.world.mapScrollCheck();
            };
        }
        public function modulateColor(ct:ColorTransform, op:String):void{
            var rootClass:MovieClip;
            rootClass = (this.stage.getChildAt(0) as MovieClip);
            if (op == "+"){
                totalTransform.alphaMultiplier = (totalTransform.alphaMultiplier + ct.alphaMultiplier);
                totalTransform.alphaOffset = (totalTransform.alphaOffset + ct.alphaOffset);
                totalTransform.redMultiplier = (totalTransform.redMultiplier + ct.redMultiplier);
                totalTransform.redOffset = (totalTransform.redOffset + ct.redOffset);
                totalTransform.greenMultiplier = (totalTransform.greenMultiplier + ct.greenMultiplier);
                totalTransform.greenOffset = (totalTransform.greenOffset + ct.greenOffset);
                totalTransform.blueMultiplier = (totalTransform.blueMultiplier + ct.blueMultiplier);
                totalTransform.blueOffset = (totalTransform.blueOffset + ct.blueOffset);
            }
            else {
                if (op == "-"){
                    totalTransform.alphaMultiplier = (totalTransform.alphaMultiplier - ct.alphaMultiplier);
                    totalTransform.alphaOffset = (totalTransform.alphaOffset - ct.alphaOffset);
                    totalTransform.redMultiplier = (totalTransform.redMultiplier - ct.redMultiplier);
                    totalTransform.redOffset = (totalTransform.redOffset - ct.redOffset);
                    totalTransform.greenMultiplier = (totalTransform.greenMultiplier - ct.greenMultiplier);
                    totalTransform.greenOffset = (totalTransform.greenOffset - ct.greenOffset);
                    totalTransform.blueMultiplier = (totalTransform.blueMultiplier - ct.blueMultiplier);
                    totalTransform.blueOffset = (totalTransform.blueOffset - ct.blueOffset);
                };
            };
            clampedTransform.alphaMultiplier = rootClass.clamp(totalTransform.alphaMultiplier, -1, 1);
            clampedTransform.alphaOffset = rootClass.clamp(totalTransform.alphaOffset, -255, 0xFF);
            clampedTransform.redMultiplier = rootClass.clamp(totalTransform.redMultiplier, -1, 1);
            clampedTransform.redOffset = rootClass.clamp(totalTransform.redOffset, -255, 0xFF);
            clampedTransform.greenMultiplier = rootClass.clamp(totalTransform.greenMultiplier, -1, 1);
            clampedTransform.greenOffset = rootClass.clamp(totalTransform.greenOffset, -255, 0xFF);
            clampedTransform.blueMultiplier = rootClass.clamp(totalTransform.blueMultiplier, -1, 1);
            clampedTransform.blueOffset = rootClass.clamp(totalTransform.blueOffset, -255, 0xFF);
            this.transform.colorTransform = clampedTransform;
        }
        private function onClickHandler(e:MouseEvent):void{
            var tAvt:Avatar;
            world = (MovieClip(stage.getChildAt(0)).world as MovieClip);
            tAvt = e.currentTarget.parent.pAV;
            if (e.shiftKey){
                world.onWalkClick();
            }
            else {
                if (!e.ctrlKey){
                    if (((((((!((tAvt == world.myAvatar))) && (world.bPvP))) && (!((tAvt.dataLeaf.pvpTeam == world.myAvatar.dataLeaf.pvpTeam))))) && ((tAvt == world.myAvatar.target)))){
                        world.approachTarget();
                    }
                    else {
                        if (tAvt != world.myAvatar.target){
                            world.setTarget(tAvt);
                        };
                    };
                };
            };
        }
        public function walkTo(toX:int, toY:int, walkSpeed:int):void{
            var isOK:Boolean;
            var dist:Number;
            var dx:Number;
            var toX:int = toX;
            var toY:int = toY;
            var walkSpeed:int = walkSpeed;
            isOK = true;
            try {
                STAGE = MovieClip(parent.parent);
            }
            catch(e:Error) {
                isOK = false;
            };
            if (isOK){
                tp = new Point(toX, toY);
                op = new Point(this.x, this.y);
                this.walkSpeed = walkSpeed;
                dist = Point.distance(op, tp);
                walkTS = new Date().getTime();
                walkD = Math.round((1000 * (dist / (walkSpeed * 22))));
                if (walkD > 0){
                    dx = (op.x - tp.x);
                    if (dx < 0){
                        this.turn("right");
                    }
                    else {
                        this.turn("left");
                    };
                    if (!this.mcChar.onMove){
                        this.mcChar.onMove = true;
                        if (this.mcChar.currentLabel != (framePrefix + "Walk")){
                            this.mcChar.gotoAndPlay((framePrefix + "Walk"));
                        };
                    };
                    this.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
                    this.addEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
                };
            };
        }
        public function setColor(mc:MovieClip, typ:String, strLocation:String, strShade:String):void{
            var intColor:Number;
            intColor = Number(pAV.objData[("intColor" + strLocation)]);
            mc.isColored = true;
            mc.intColor = intColor;
            mc.strLocation = strLocation;
            mc.strShade = strShade;
            changeColor(mc, intColor, strShade);
        }
        public function updateColor(objData:Object=null){
            var cData:*;
            trace("** PMC updateColor >");
            cData = pAV.objData;
            if (objData != null){
                cData = objData;
            };
            scanColor(this, cData);
        }
        public function simulateJumpDown():Point{
            var pt:Point;
            var deltaY:Number;
            var r:Rectangle;
            var lookahead:Number;
            var bCollision:Boolean;
            var i:*;
            pt = new Point(this.x, this.y);
            deltaY = (12 * this.mcChar.scaleY);
            r = this.shadow.getBounds(stage);
            lookahead = (8 * deltaY);
            while (true) {
                bCollision = false;
                i = 0;
                while (i < STAGE.arrSolid.length) {
                    if (((STAGE.arrSolid[i].shadow.hitTestPoint(r.x, (r.y + lookahead))) || (STAGE.arrSolid[i].shadow.hitTestPoint(r.right, (r.y + lookahead))))){
                        bCollision = true;
                        break;
                    };
                    i++;
                };
                if (!bCollision){
                    pt.y = (pt.y + lookahead);
                    break;
                };
                r.offset(0, deltaY);
                pt.y = (pt.y + deltaY);
            };
            if (world.map.cell.localToGlobal(pt).y >= 500){
                pt.y = world.map.cell.globalToLocal(new Point(0, 500)).y;
            };
            return (pt);
        }
        private function linearTween(t, b, c, d):Number{
            return ((((c * t) / d) + b));
        }
        public function onLoadWeaponComplete(e:Event):void{
            var AssetClass:Class;
            var e:Event = e;
            trace("onLoadWeaponComplete >");
            try {
                AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.we.sLink) as Class);
                mcChar.weapon1.removeChildAt(0);
                mcChar.weapon1.addChild(new (AssetClass)());
            }
            catch(err:Error) {
            };
            mcChar.weapon1.visible = true;
            mcChar.weapon2.visible = false;
            pAV.objData.eqp.we.bLoaded = true;
            checkLoadComplete();
        }
        public function onLoadMaskComplete(e:Event):void{
            var AssetClass:Class;
            trace("pMC.onLoadMaskComplete >");
            AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.ma.sLink) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((pAV.objData.eqp.ma.sLink + strGender)) as Class);
            };
            if (AssetClass != null){
                if (mcChar.head.mcMask.numChildren > 0){
                    mcChar.head.mcMask.removeChildAt(0);
                };
                mcChar.head.mcMask.addChild(new (AssetClass)());
                mcChar.head.mcMask.visible = true;
            }
            else {
                world.rootClass.chatF.pushMsg("warning", "Could not resolve Mask definition.", "SERVER", "", 0);
            };
            pAV.objData.eqp.ma.bLoaded = true;
            checkLoadComplete();
        }
        public function loadArmorPiecesFromDomain(strSkinLinkage:String, pLoaderD:ApplicationDomain):void{
            var AssetClass:Class;
            var child:DisplayObject;
            var strSkinLinkage:String = strSkinLinkage;
            var pLoaderD:ApplicationDomain = pLoaderD;
            trace((">>>>>>>>>>>> loadArmorPiecesFromDomain > " + strSkinLinkage));
            try {
                AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Head")) as Class);
                child = mcChar.head.getChildByName("face");
                if (child != null){
                    mcChar.head.removeChild(child);
                };
                mcChar.head.addChildAt(new (AssetClass)(), 0).name = "face";
            }
            catch(err:Error) {
                AssetClass = (pLoaderD.getDefinition(("mcHead" + strGender)) as Class);
                child = mcChar.head.getChildByName("face");
                if (child != null){
                    mcChar.head.removeChild(child);
                };
                mcChar.head.addChildAt(new (AssetClass)(), 0).name = "face";
            };
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Chest")) as Class);
            mcChar.chest.removeChildAt(0);
            mcChar.chest.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Hip")) as Class);
            mcChar.hip.removeChildAt(0);
            mcChar.hip.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Shoulder")) as Class);
            mcChar.frontshoulder.removeChildAt(0);
            mcChar.frontshoulder.addChild(new (AssetClass)());
            mcChar.backshoulder.removeChildAt(0);
            mcChar.backshoulder.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Hand")) as Class);
            mcChar.fronthand.removeChildAt(0);
            mcChar.fronthand.addChild(new (AssetClass)());
            mcChar.backhand.removeChildAt(0);
            mcChar.backhand.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Thigh")) as Class);
            mcChar.frontthigh.removeChildAt(0);
            mcChar.frontthigh.addChild(new (AssetClass)());
            mcChar.backthigh.removeChildAt(0);
            mcChar.backthigh.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Shin")) as Class);
            mcChar.frontshin.removeChildAt(0);
            mcChar.frontshin.addChild(new (AssetClass)());
            mcChar.backshin.removeChildAt(0);
            mcChar.backshin.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "FootIdle")) as Class);
            mcChar.idlefoot.removeChildAt(0);
            mcChar.idlefoot.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Foot")) as Class);
            mcChar.frontfoot.removeChildAt(0);
            mcChar.frontfoot.addChild(new (AssetClass)());
            mcChar.frontfoot.visible = false;
            mcChar.backfoot.removeChildAt(0);
            mcChar.backfoot.addChild(new (AssetClass)());
            try {
                AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Robe")) as Class);
                if (AssetClass != null){
                    mcChar.robe.removeChildAt(0);
                    mcChar.robe.addChild(new (AssetClass)());
                    mcChar.robe.visible = true;
                }
                else {
                    mcChar.robe.visible = false;
                };
            }
            catch(e:Error) {
                mcChar.robe.visible = false;
            };
            try {
                AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "RobeBack")) as Class);
                if (AssetClass != null){
                    mcChar.backrobe.removeChildAt(0);
                    mcChar.backrobe.addChild(new (AssetClass)());
                    mcChar.backrobe.visible = true;
                }
                else {
                    mcChar.backrobe.visible = false;
                };
            }
            catch(e:Error) {
                mcChar.backrobe.visible = false;
            };
            gotoAndPlay("in1");
            isLoaded = true;
        }
        function frame14(){
            mcChar.transform.colorTransform = CT2;
        }
        public function checkPadLabels(){
            var rootClass:*;
            var ui:*;
            var l:int;
            var pad:*;
            var padNO:*;
            rootClass = MovieClip(stage.getChildAt(0));
            ui = rootClass.ui;
            l = 0;
            while (l < ui.mcPadNames.numChildren) {
                pad = MovieClip(ui.mcPadNames.getChildAt(l));
                padNO = new Point(4, 8);
                padNO = pad.cnt.localToGlobal(padNO);
                if (rootClass.distanceO(this, padNO) < 200){
                    if (!pad.isOn){
                        pad.isOn = true;
                        pad.gotoAndPlay("in");
                    };
                }
                else {
                    if (pad.isOn){
                        pad.isOn = false;
                        pad.gotoAndPlay("out");
                    };
                };
                l++;
            };
        }
        public function onLoadArmorComplete(e:Event):void{
            trace(("** PMC onLoadArmorComplete >" + objLinks.ar));
            loadArmorPieces(objLinks.ar);
            pAV.objData.eqp.ar.bLoaded = true;
            checkLoadComplete();
            if (this.name.indexOf("previewMCB") > -1){
                MovieClip(parent.parent).repositionPreview(MovieClip(mcChar));
            };
        }
        public function setCloakVisibility(b:Boolean):void{
            trace(("setCloakVisibility > " + b));
            if (((!((pAV.objData.eqp.ba == null))) && (!((pAV.objData.eqp.ba.sLink == null))))){
                if (b){
                    mcChar.cape.visible = true;
                }
                else {
                    mcChar.cape.visible = false;
                };
            };
        }
        function frame11(){
            mcChar.alpha = 0;
        }
        function frame13(){
            mcChar.transform.colorTransform = CT3;
        }
        public function loadEyes():void{
            var AssetClass:*;
            AssetClass = (rootClass.loadermanager.getClass((rootClass["arrEyes"][pAV.objData.iEye] + strGender)) as Class);
            mcChar.head.mcEyes.removeChildAt(0);
            mcChar.head.mcEyes.addChild(new (AssetClass)());
        }
        public function tintElementColor(mc:MovieClip, elm:String):void{
            var c:Color;
            c = new Color();
            switch (elm){
                case "Fire":
                    c.setTint(0xCC0000, 0.7);
                    break;
                case "Ice":
                    c.setTint(6225919, 0.7);
                    break;
                case "Radiation":
                    c.setTint(0x99CC00, 0.7);
                    break;
                case "Mental":
                    c.setTint(6427568, 0.7);
                    break;
                case "Energy":
                    c.setTint(10079487, 0.7);
                    break;
            };
            mc.transform.colorTransform = c;
        }
        function frame1(){
            stop();
        }
        function frame19(){
            stop();
        }
        public function ioErrorHandler(event:IOErrorEvent):void{
            trace(("ioErrorHandler: " + event));
        }
        function frame6(){
        }
        function frame24(){
            stop();
        }
        public function loadBoots(sFile, sLink):void{
            rootClass.loadermanager.queueLoad({
                strFile:(Game.serverFilePath + sFile),
                callBackA:onLoadBootsComplete,
                avt:pAV,
                sES:"bt"
            });
        }
        private function simulateWalkLoop():Point{
            var vX:*;
            var vY:*;
            var bitCollision:Boolean;
            var n:*;
            var nY:*;
            var i:*;
            var j:*;
            while ((((((this.nXStep <= this.nDuration)) || ((this.nYStep <= this.nDuration)))) && (this.mcChar.onMove))) {
                vX = this.x;
                vY = this.y;
                this.x = linearTween(this.nXStep, this.xDep, (this.xTar - this.xDep), this.nDuration);
                this.y = linearTween(this.nYStep, this.yDep, (this.yTar - this.yDep), this.nDuration);
                bitCollision = false;
                n = 0;
                while (n < STAGE.arrSolid.length) {
                    if (this.shadow.hitTestObject(STAGE.arrSolid[n].shadow)){
                        bitCollision = true;
                        n = STAGE.arrSolid.length;
                    };
                    n++;
                };
                if (((!(bFly)) && (bitCollision))){
                    nY = this.y;
                    this.y = vY;
                    bitCollision = false;
                    i = 0;
                    while (i < STAGE.arrSolid.length) {
                        if (this.shadow.hitTestObject(STAGE.arrSolid[i].shadow)){
                            this.y = nY;
                            bitCollision = true;
                            break;
                        };
                        i++;
                    };
                    if (bitCollision){
                        this.x = vX;
                        bitCollision = false;
                        j = 0;
                        while (j < STAGE.arrSolid.length) {
                            if (this.shadow.hitTestObject(STAGE.arrSolid[j].shadow)){
                                bitCollision = true;
                                break;
                            };
                            j++;
                        };
                        if (bitCollision){
                            this.x = vX;
                            this.y = vY;
                            this.mcChar.onMove = false;
                            this.nDuration = -1;
                            return (new Point(this.x, this.y));
                        };
                        if (this.nYStep <= this.nDuration){
                            this.nYStep++;
                        };
                    }
                    else {
                        if (this.nXStep <= this.nDuration){
                            this.nXStep++;
                        };
                    };
                }
                else {
                    if (this.nXStep <= this.nDuration){
                        this.nXStep++;
                    };
                    if (this.nYStep <= this.nDuration){
                        this.nYStep++;
                    };
                };
                if ((((((Math.round(vX) == Math.round(this.x))) && ((Math.round(vY) == Math.round(this.y))))) && ((((this.nXStep > 1)) || ((this.nYStep > 1)))))){
                    this.mcChar.onMove = false;
                    this.nDuration = -1;
                    return (new Point(this.x, this.y));
                };
            };
            this.mcChar.onMove = false;
            this.nDuration = -1;
            return (new Point(this.x, this.y));
        }
        public function loadScar(sFile, sLink):void{
            trace("pMC.loadScar >");
            rootClass.loadermanager.queueLoad({
                strFile:((Game.serverFilePath + "items/scar/") + sFile),
                callBackA:onLoadScarComplete,
                avt:pAV,
                sES:"scar"
            });
        }
        public function GroundToFly():void{
            jumpOP = new Point(this.x, this.y);
            jumpTS = new Date().getTime();
            this.addEventListener(Event.ENTER_FRAME, onJumpEnterFrame);
            this.mcChar.gotoAndPlay("Ground2Fly");
            bFlyTransition = true;
        }
        public function get fly():Boolean{
            return (bFly);
        }
        function frame15(){
            mcChar.transform.colorTransform = CT1;
        }
        function frame9(){
            stop();
        }
        private function onEnterFrameWalk(event:Event):void{
            var now:Number;
            var f:Number;
            var vX:*;
            var vY:*;
            var bitCollision:Boolean;
            var n:*;
            var nY:*;
            var i:*;
            var j:*;
            var aP:Point;
            var k:int;
            var hitOK:Boolean;
            var aR:Rectangle;
            now = new Date().getTime();
            f = ((now - walkTS) / walkD);
            if (f > 1){
                f = 1;
            };
            if ((((Point.distance(op, tp) > 0.5)) && (this.mcChar.onMove))){
                vX = this.x;
                vY = this.y;
                this.x = Point.interpolate(tp, op, f).x;
                this.y = Point.interpolate(tp, op, f).y;
                if (!bFly){
                    bitCollision = false;
                    n = 0;
                    while (n < STAGE.arrSolid.length) {
                        if (this.shadow.hitTestObject(STAGE.arrSolid[n].shadow)){
                            bitCollision = true;
                            n = STAGE.arrSolid.length;
                        };
                        n++;
                    };
                    if (bitCollision){
                        nY = this.y;
                        this.y = vY;
                        bitCollision = false;
                        i = 0;
                        while (i < STAGE.arrSolid.length) {
                            if (this.shadow.hitTestObject(STAGE.arrSolid[i].shadow)){
                                this.y = nY;
                                bitCollision = true;
                                break;
                            };
                            i++;
                        };
                        if (bitCollision){
                            this.x = vX;
                            bitCollision = false;
                            j = 0;
                            while (j < STAGE.arrSolid.length) {
                                if (this.shadow.hitTestObject(STAGE.arrSolid[j].shadow)){
                                    bitCollision = true;
                                    break;
                                };
                                j++;
                            };
                            if (bitCollision){
                                this.x = vX;
                                this.y = vY;
                                this.stopWalking();
                            };
                        };
                    };
                };
                if ((((((Math.round(vX) == Math.round(this.x))) && ((Math.round(vY) == Math.round(this.y))))) && ((now > (walkTS + 50))))){
                    this.stopWalking();
                };
                if (this.pAV.isMyAvatar){
                    rootClass.world.mapScrollCheck();
                    checkPadLabels();
                    aP = this.shadow.localToGlobal(new Point(0, 0));
                    k = 0;
                    while (k < STAGE.arrEvent.length) {
                        hitOK = false;
                        world = MovieClip(stage.getChildAt(0)).world;
                        aR = STAGE.arrEvent[k].shadow.getBounds(stage);
                        if (aR.containsPoint(aP)){
                            hitOK = true;
                        };
                        if (hitOK){
                            if (((!(STAGE.arrEvent[k]._entered)) && (MovieClip(STAGE.arrEvent[k]).isEvent))){
                                STAGE.arrEvent[k]._entered = true;
                                if (this == MovieClip(parent.parent).myAvatar.pMC){
                                    STAGE.arrEvent[k].dispatchEvent(new Event("enter"));
                                };
                            };
                        }
                        else {
                            if (STAGE.arrEvent[k]._entered){
                                STAGE.arrEvent[k]._entered = false;
                            };
                        };
                        k++;
                    };
                };
            }
            else {
                this.stopWalking();
            };
        }
        private function hideface():void{
            mcChar.head.mcMask.visible = false;
            mcChar.head.mcEyes.visible = false;
            mcChar.head.mcNose.visible = false;
            mcChar.head.mcMouth.visible = false;
            mcChar.head.mcScar.visible = false;
            mcChar.head.face.visible = false;
            mcChar.backhair.visible = false;
        }
        public function onLoadHelmComplete(e:Event):void{
            var AssetClass:Class;
            trace("pMC.onLoadHelmComplete >");
            AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.he.sLink) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((pAV.objData.eqp.he.sLink + strGender)) as Class);
            };
            if (AssetClass != null){
                if (pAV.objData.eqp.he.sType == "Head"){
                    hideface();
                }
                else {
                    showface();
                };
                mcChar.head.mcHair.removeChildAt(0);
                mcChar.head.mcHair.addChild(new (AssetClass)());
                mcChar.head.mcHair.visible = true;
            }
            else {
                world.rootClass.chatF.pushMsg("warning", "Could not resolve Helm definition.", "SERVER", "", 0);
            };
            pAV.objData.eqp.he.bLoaded = true;
            checkLoadComplete();
        }
        public function hasLabel(l:String):Boolean{
            var labels:Array;
            var i:int;
            labels = mcChar.currentLabels;
            i = 0;
            while (i < labels.length) {
                if (labels[i].name == l){
                    return (true);
                };
                i++;
            };
            return (false);
        }
        public function loadWeapon(sFile, sLink):void{
            rootClass.loadermanager.queueLoad({
                strFile:((((Game.serverFilePath + "items/") + pAV.objData.eqp.we.sType) + "/") + sFile),
                callBackA:onLoadWeaponComplete,
                avt:pAV,
                sES:"weapon"
            });
        }
        public function loadArmorPieces(strSkinLinkage:String):void{
            var AssetClass:Class;
            var child:DisplayObject;
            var strSkinLinkage:String = strSkinLinkage;
            AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + "Chest") + strGender)) as Class);
            mcChar.chest.removeChildAt(0);
            mcChar.chest.addChild(new (AssetClass)());
            AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + "UpperArmFront") + strGender)) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "UpperArmFront")) as Class);
            };
            mcChar.frontshoulder.removeChildAt(0);
            mcChar.frontshoulder.addChild(new (AssetClass)());
            AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + "UpperArmBack") + strGender)) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "UpperArmBack")) as Class);
            };
            mcChar.backshoulder.removeChildAt(0);
            mcChar.backshoulder.addChild(new (AssetClass)());
            if (pAV.objData.eqp.gl == null){
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "LowerArmFront")) as Class);
                mcChar.fronthand.removeChildAt(0);
                mcChar.fronthand.addChild(new (AssetClass)());
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "LowerArmBack")) as Class);
                mcChar.backhand.removeChildAt(0);
                mcChar.backhand.addChild(new (AssetClass)());
            };
            AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + "UpperLegFront") + strGender)) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "UpperLegFront")) as Class);
            };
            mcChar.frontthigh.removeChildAt(0);
            mcChar.frontthigh.addChild(new (AssetClass)());
            AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + "UpperLegBack") + strGender)) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "UpperLegBack")) as Class);
            };
            mcChar.backthigh.removeChildAt(0);
            mcChar.backthigh.addChild(new (AssetClass)());
            AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + "LowerLegFront") + strGender)) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "LowerLegFront")) as Class);
            };
            mcChar.frontshin.removeChildAt(0);
            mcChar.frontshin.addChild(new (AssetClass)());
            AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + "LowerLegBack") + strGender)) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "LowerLegBack")) as Class);
            };
            mcChar.backshin.removeChildAt(0);
            mcChar.backshin.addChild(new (AssetClass)());
            try {
                AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + "BeltFront") + strGender)) as Class);
                if (AssetClass == null){
                    AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "BeltFront")) as Class);
                };
                if (AssetClass != null){
                    mcChar.robe.removeChildAt(0);
                    mcChar.robe.addChild(new (AssetClass)());
                    mcChar.robe.visible = true;
                }
                else {
                    mcChar.robe.visible = false;
                };
            }
            catch(e:Error) {
                mcChar.robe.visible = false;
            };
            try {
                AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + "BeltBack") + strGender)) as Class);
                if (AssetClass == null){
                    AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "BeltBack")) as Class);
                };
                if (AssetClass != null){
                    mcChar.backrobe.removeChildAt(0);
                    mcChar.backrobe.addChild(new (AssetClass)());
                    mcChar.backrobe.visible = true;
                }
                else {
                    mcChar.backrobe.visible = false;
                };
            }
            catch(e:Error) {
                mcChar.backrobe.visible = false;
            };
            isLoaded = true;
        }
        public function onLoadBootsComplete(e:Event):void{
            var AssetClass:Class;
            var strSkinLinkage:String;
            var e:Event = e;
            strSkinLinkage = pAV.objData.eqp.bt.sLink;
            try {
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "BootTop")) as Class);
                mcChar.frontshin.TopBoot.removeChildAt(0);
                mcChar.frontshin.TopBoot.addChild(new (AssetClass)());
                mcChar.backshin.TopBoot.removeChildAt(0);
                mcChar.backshin.TopBoot.addChild(new (AssetClass)());
            }
            catch(e:Error) {
                try {
                    AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + strGender) + "BootTop")) as Class);
                    mcChar.frontshin.TopBoot.removeChildAt(0);
                    mcChar.frontshin.TopBoot.addChild(new (AssetClass)());
                    mcChar.backshin.TopBoot.removeChildAt(0);
                    mcChar.backshin.TopBoot.addChild(new (AssetClass)());
                }
                catch(e:Error) {
                };
            };
            try {
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "BootIdle")) as Class);
                mcChar.idlefoot.Boot.removeChildAt(0);
                mcChar.idlefoot.Boot.addChild(new (AssetClass)());
            }
            catch(e:Error) {
                try {
                    AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + strGender) + "BootIdle")) as Class);
                    mcChar.idlefoot.Boot.removeChildAt(0);
                    mcChar.idlefoot.Boot.addChild(new (AssetClass)());
                }
                catch(e:Error) {
                };
            };
            try {
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "BootFront")) as Class);
                mcChar.frontfoot.Boot.removeChildAt(0);
                mcChar.frontfoot.Boot.addChild(new (AssetClass)());
                mcChar.backfoot.Boot.removeChildAt(0);
                mcChar.backfoot.Boot.addChild(new (AssetClass)());
            }
            catch(e:Error) {
                try {
                    AssetClass = (rootClass.loadermanager.getClass(((strSkinLinkage + strGender) + "BootFront")) as Class);
                    mcChar.frontfoot.Boot.removeChildAt(0);
                    mcChar.frontfoot.Boot.addChild(new (AssetClass)());
                    mcChar.backfoot.Boot.removeChildAt(0);
                    mcChar.backfoot.Boot.addChild(new (AssetClass)());
                }
                catch(e:Error) {
                };
            };
            mcChar.frontshin.TopBoot.visible = true;
            mcChar.backshin.TopBoot.visible = true;
            mcChar.idlefoot.Boot.visible = true;
            mcChar.frontfoot.Boot.visible = true;
            mcChar.backfoot.Boot.visible = true;
        }
        public function updateHPBar():void{
            var g:MovieClip;
            var r:MovieClip;
            var cLeaf:Object;
            g = (this.hpBar.g as MovieClip);
            r = (this.hpBar.r as MovieClip);
            if (this.hpBar.visible){
                cLeaf = this.pAV.dataLeaf;
                if (((!((cLeaf == null))) && (!((cLeaf.intHP == null))))){
                    g.visible = true;
                    g.width = Math.round(((cLeaf.intHP / cLeaf.intHPMax) * r.width));
                    if (cLeaf.intHP < 1){
                        g.visible = false;
                    };
                };
            };
        }
        public function turn(strDir:String):void{
            if ((((((strDir == "right")) && ((this.mcChar.scaleX < 0)))) || ((((strDir == "left")) && ((this.mcChar.scaleX > 0)))))){
                this.mcChar.scaleX = (this.mcChar.scaleX * -1);
            };
        }
        public function clearQueue():void{
            animQueue = [];
        }
        public function simulateJumpUp():Point{
            return (new Point(this.x, (this.y - (96 * this.mcChar.scaleY))));
        }
        public function queueAnim(anim:Object):void{
            var s:String;
            var wItem:Object;
            var sType:*;
            var world:MovieClip;
            var l:String;
            trace(("queueAnim >" + anim.animStr));
            s = anim.animStr;
            if (s.indexOf(",") > -1){
                s = s.split(",")[Math.floor((Math.random() * s.split(",").length))];
            };
            if ((((s == "Attack1")) || ((s == "Attack2")))){
                wItem = pAV.getItemByEquipSlot("we");
                if (((!((wItem == null))) && (!((wItem.sType == null))))){
                    sType = wItem.sType;
                    if ((((sType == "Mace")) && ((wItem.ItemID == 156)))){
                        sType = "Unarmed";
                    };
                    switch (sType){
                        case "Unarmed":
                            s = ["UnarmedAttack1", "UnarmedAttack2", "KickAttack", "FlipAttack"][Math.round((Math.random() * 3))];
                            break;
                        case "Polearm":
                            s = ["PolearmAttack1", "PolearmAttack2"][Math.round((Math.random() * 1))];
                            break;
                        case "Dagger":
                            s = ["DuelWield/DaggerAttack1", "DuelWield/DaggerAttack2"][Math.round((Math.random() * 1))];
                            break;
                        case "Gun":
                            if (((!((wItem.sMeta == null))) && ((wItem.sMeta.indexOf("Multi-Shot") >= 0)))){
                                s = ["MultiShot1", "Attack3"][Math.floor((Math.random() * 2))];
                            }
                            else {
                                s = ["SingleShot1", "Attack3"][Math.floor((Math.random() * 2))];
                            };
                            break;
                    };
                };
            };
            anim.animStr = s;
            if (((hasLabel(s)) && ((pAV.dataLeaf.intState > 0)))){
                world = (MovieClip(stage.getChildAt(0)).world as MovieClip);
                l = mcChar.currentLabel;
                if ((((world.combatAnims.indexOf(s) > -1)) && ((world.combatAnims.indexOf(l) > -1)))){
                    animQueue.push(anim);
                }
                else {
                    playAnim(anim);
                };
            };
        }
        public function showHealIcon():void{
            var icon:HealIconMC;
            if (!getChildByName("HealIconMC")){
                icon = new HealIconMC(pAV, world);
                icon.name = "HealIconMC";
                addChild(icon);
            };
        }
        function frame21(){
            mcChar.transform.colorTransform = CT1;
        }
        public function loadCape(sFile, sLink):void{
            rootClass.loadermanager.queueLoad({
                strFile:((Game.serverFilePath + "items/cape/") + sFile),
                callBackA:onLoadCapeComplete,
                avt:pAV,
                sES:"cape"
            });
        }
        private function showface():void{
            mcChar.head.mcEyes.visible = true;
            mcChar.head.mcNose.visible = true;
            mcChar.head.mcMouth.visible = true;
            mcChar.head.mcMask.visible = !((pAV.objData.eqp.ma == null));
            mcChar.head.mcScar.visible = !((pAV.objData.eqp.sc == null));
            mcChar.head.face.visible = true;
        }
        public function loadEquippedItems():void{
            var sES:*;
            trace(("debug " + pAV.objData.eqp));
            if (pAV.objData.eqp != null){
                for (sES in pAV.objData.eqp) {
                    pAV.objData.eqp[sES].bLoaded = false;
                    loadMovieAtES(sES, pAV.objData.eqp[sES].sFile, pAV.objData.eqp[sES].sLink);
                };
            };
            checkLoadComplete();
        }
        public function set fly(flag:Boolean):void{
            bFly = flag;
            if (bFly){
                framePrefix = "Fly";
                mcChar.cape.mcCape.gotoAndPlay("Fly");
                this.shadow.visible = false;
            }
            else {
                framePrefix = "";
                mcChar.cape.mcCape.gotoAndPlay("Ground");
            };
        }
        private function checkQueue(e:Event):Boolean{
            var world:MovieClip;
            var l:String;
            var f:int;
            if (animQueue.length > 0){
                world = (MovieClip(stage.getChildAt(0)).world as MovieClip);
                l = mcChar.currentLabel;
                f = mcChar.emoteLoopFrame();
                if ((((world.combatAnims.indexOf(l) > -1)) && ((mcChar.currentFrame >= (f + 4))))){
                    playAnim(animQueue[0]);
                    animQueue.shift();
                    return (true);
                };
            };
            return (false);
        }
        private function scanColor(mc:MovieClip, cData):void{
            var i:int;
            var child:DisplayObject;
            if (("isColored" in mc)){
                changeColor(mc, Number(cData[("intColor" + mc.strLocation)]), mc.strShade);
            };
            i = 0;
            while (i < mc.numChildren) {
                child = mc.getChildAt(i);
                if ((child is MovieClip)){
                    scanColor(MovieClip(child), cData);
                };
                i++;
            };
        }
        public function endAction():void{
            var tChar:*;
            var dx:Number;
            var s:String;
            var wItem:Object;
            var sType:*;
            tChar = null;
            if (this.pAV.target != null){
                tChar = this.pAV.target.pMC.mcChar;
            };
            if (!checkQueue(null)){
                if (this.mcChar.onMove){
                    this.mcChar.gotoAndPlay("Walk");
                    dx = (this.x - this.xTar);
                    if ((dx < 0)){
                        this.turn("right");
                    }
                    else {
                        this.turn("left");
                    };
                }
                else {
                    if ((((tChar == null)) || (((!((tChar == null))) && ((((((((tChar.currentLabel == "Die")) || ((tChar.currentLabel == "Feign")))) || ((tChar.currentLabel == "Dead")))) || ((((this.pAV.target.npcType == "player")) && (((!(("pvpTeam" in this.pAV.dataLeaf))) || ((this.pAV.dataLeaf.pvpTeam == this.pAV.target.dataLeaf.pvpTeam)))))))))))){
                        if (this.mcChar.currentLabel != "Jump"){
                            this.mcChar.gotoAndPlay("Idle");
                        };
                        if (tChar != null){
                            if (this.pAV.target.dataLeaf.intState == 0){
                                if (this.pAV == world.myAvatar){
                                    world.setTarget(null);
                                };
                            };
                        };
                    }
                    else {
                        s = "Fight";
                        wItem = pAV.getItemByEquipSlot("Weapon");
                        if (((!((wItem == null))) && (!((wItem.sType == null))))){
                            sType = wItem.sType;
                            if ((((sType == "Mace")) && ((wItem.ItemID == 156)))){
                                sType = "Unarmed";
                            };
                            switch (sType){
                                case "Unarmed":
                                    s = "UnarmedFight";
                                    break;
                                case "Polearm":
                                    s = "PolearmFight";
                                    break;
                                case "Dagger":
                                    s = "DuelWield/DaggerFight";
                                    break;
                            };
                        };
                        this.mcChar.gotoAndPlay(s);
                    };
                };
            };
        }
        public function loadMask(sFile, sLink):void{
            trace("pMC.loadMask >");
            rootClass.loadermanager.queueLoad({
                strFile:((Game.serverFilePath + "items/mask/") + sFile),
                callBackA:onLoadMaskComplete,
                avt:pAV,
                sES:"mask"
            });
        }
        public function onLoadScarComplete(e:Event):void{
            var AssetClass:Class;
            trace("pMC.onLoadScarComplete >");
            AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.sc.sLink) as Class);
            if (AssetClass != null){
                if (mcChar.head.mcScar.numChildren > 0){
                    mcChar.head.mcScar.removeChildAt(0);
                };
                mcChar.head.mcScar.addChild(new (AssetClass)());
                mcChar.head.mcScar.visible = (((pAV.objData.eqp.he == null)) || (!((pAV.objData.eqp.he.sType == "Head"))));
            }
            else {
                world.rootClass.chatF.pushMsg("warning", "Could not resolve Scar definition.", "SERVER", "", 0);
            };
            pAV.objData.eqp.sc.bLoaded = true;
            checkLoadComplete();
        }
        public function showHPBar():void{
            this.hpBar.y = (this.pname.y + 20);
            this.hpBar.visible = true;
            updateHPBar();
        }
        public function stopWalking():void{
            world = MovieClip(stage.getChildAt(0)).world;
            if (this.mcChar.onMove){
                this.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
                if (((this.pAV.isMyAvatar) && (MovieClip(parent.parent).actionReady))){
                    world.testAction(world.getAutoAttack());
                };
            };
            this.mcChar.onMove = false;
            this.mcChar.gotoAndPlay((framePrefix + "Idle"));
        }
        public function updateName():void{
            var uoLeaf:* = undefined;
            uoLeaf = world.uoTree[pAV.pnm];
            try {
                if (uoLeaf.afk){
                    pname.ti.text = ("<AFK> " + pAV.objData.strUsername.toUpperCase());
                }
                else {
                    pname.ti.text = pAV.objData.strUsername.toUpperCase();
                };
            }
            catch(e:Error) {
            };
        }
        public function onLoadWeaponOffComplete(e:Event):void{
            var AssetClass:Class;
            var e:Event = e;
            trace("onLoadWeaponOffComplete >");
            mcChar.weaponOff.removeChildAt(0);
            try {
                AssetClass = (world.getClass(pAV.objData.eqp.Weapon.sLink) as Class);
                mcChar.weaponOff.addChild(new (AssetClass)());
            }
            catch(err:Error) {
                trace(" weaponOff added to display list manually");
                mcChar.weaponOff.addChild(e.target.content);
            };
            mcChar.weaponOff.visible = true;
        }
        private function unloadGloves():void{
            var strLinkage:String;
            var AssetClass:Class;
            strLinkage = "Default";
            if (pAV.objData.eqp.ar != null){
                strLinkage = pAV.objData.eqp.ar.sLink;
            };
            AssetClass = (rootClass.loadermanager.getClass((strLinkage + "LowerArmFront")) as Class);
            mcChar.fronthand.removeChildAt(0);
            mcChar.fronthand.addChild(new (AssetClass)());
            AssetClass = (rootClass.loadermanager.getClass((strLinkage + "LowerArmBack")) as Class);
            mcChar.backhand.removeChildAt(0);
            mcChar.backhand.addChild(new (AssetClass)());
        }
        public function fClose():void{
            trace((("*** > " + pAV.pnm) + ".fClose() >"));
            recursiveStop(this);
            world = MovieClip(stage.getChildAt(0)).world;
            mcChar.removeEventListener(MouseEvent.CLICK, onClickHandler);
            pname.removeEventListener(MouseEvent.CLICK, onClickHandler);
            this.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
            this.removeEventListener(Event.ENTER_FRAME, checkQueue);
            if (world.CHARS.contains(this)){
                world.CHARS.removeChild(this);
            };
            if (world.TRASH.contains(this)){
                world.TRASH.removeChild(this);
            };
            if (pAV != null){
                if (pAV == world.myAvatar){
                    world.setTarget(null);
                }
                else {
                    pAV.target = null;
                };
                pAV.pMC = null;
                pAV = null;
            };
            try {
                if (getChildByName("HealIconMC") != null){
                    MovieClip(getChildByName("HealIconMC")).fClose();
                };
            }
            catch(e:Error) {
            };
        }
        public function onLoadCapeComplete(e:Event):void{
            var AssetClass:Class;
            trace(pAV.objData.eqp.ba.sLink);
            AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.ba.sLink) as Class);
            mcChar.cape.removeChildAt(0);
            mcChar.cape.mcCape = new (AssetClass)();
            mcChar.cape.addChild(mcChar.cape.mcCape);
            mcChar.cape.visible = true;
            if (bFly){
                mcChar.cape.mcCape.gotoAndPlay("Fly");
            };
            pAV.objData.eqp.ba.bLoaded = true;
            checkLoadComplete();
        }
        public function unloadMovieAtES(sES):void{
            trace("** AVATAR unloadMovieAtES >");
            if (sES != null){
                switch (sES){
                    case "we":
                        mcChar.weapon1.visible = false;
                        break;
                    case "he":
                        showface();
                        if (pAV.objData.eqp.ha != null){
                            loadHair();
                        }
                        else {
                            loadBaldHair();
                            updatePortrait();
                        };
                        mcChar.backhair.visible = bBackHair;
                        break;
                    case "ha":
                        if (pAV.objData.eqp.he == null){
                            loadBaldHair();
                            updatePortrait();
                        };
                        break;
                    case "ma":
                        mcChar.head.mcMask.visible = false;
                        updatePortrait();
                        break;
                    case "sc":
                        mcChar.head.mcScar.visible = false;
                        updatePortrait();
                        break;
                    case "ba":
                        mcChar.cape.visible = false;
                        break;
                    case "gl":
                        unloadGloves();
                        break;
                    case "ar":
                        loadArmorPieces("Default");
                        break;
                };
            };
        }
        public function loadMovieAtES(sES, sFile, sLink):void{
            trace(("** AVATAR loadMovieAtES > " + sES));
            if (sES != null){
                switch (sES){
                    case "we":
                        loadWeapon(sFile, sLink);
                        break;
                    case "he":
                        loadHelm(sFile, sLink);
                        break;
                    case "ha":
                        loadHair();
                        break;
                    case "ma":
                        loadMask(sFile, sLink);
                        break;
                    case "sc":
                        loadScar(sFile, sLink);
                        break;
                    case "ba":
                        loadCape(sFile, sLink);
                        break;
                    case "gl":
                        loadGloves(sFile, sLink);
                        break;
                    case "ar":
                        loadArmor(sFile, sLink);
                        break;
                };
            };
        }
        public function init():void{
            var AssetClass:Class;
            var child:DisplayObject;
            trace(pAV.dataLeaf);
            if (pAV.dataLeaf != null){
                mcChar.buttonMode = true;
                mcChar.addEventListener(MouseEvent.CLICK, onClickHandler);
                pname.mouseChildren = false;
                pname.buttonMode = true;
                pname.addEventListener(MouseEvent.CLICK, onClickHandler, false, 0, true);
                if (pAV.dataLeaf.fly){
                    fly = true;
                };
                if (pAV.dataLeaf.intState){
                    mcChar.gotoAndPlay((framePrefix + "Idle"));
                }
                else {
                    mcChar.gotoAndStop("Dead");
                };
            };
            strGender = pAV.objData.strGender;
            showface();
            hideOptionalParts();
            try {
                if (pAV.objData.eqp.he == null){
                    loadBaldHair();
                };
                AssetClass = (rootClass.loadermanager.getClass(("DefaultHead" + strGender)) as Class);
                mcChar.head.face.removeChildAt(0);
                mcChar.head.face.addChild(new (AssetClass)());
            }
            catch(e:Error) {
                trace(e.message);
            };
            if (pAV.objData.eqp.ar == null){
                loadArmorPieces("Default");
            };
            loadMouth();
            loadNose();
            loadEyes();
            STAGE = MovieClip(parent.parent);
            loadEquippedItems();
        }
        private function hideOptionalParts():void{
            var killList:*;
            var weaponSlots:*;
            var i:String;
            killList = ["cape", "backhair", "robe", "backrobe", "pvpFlag"];
            weaponSlots = ["weapon1", "weapon2"];
            i = "";
            for (i in weaponSlots) {
                if (typeof(mcChar[weaponSlots[i]]) != undefined){
                    mcChar[weaponSlots[i]].visible = false;
                };
            };
            mcChar.robe.visible = false;
            mcChar.cape.visible = false;
            mcChar.head.mcHelm.visible = false;
            mcChar.head.mcMask.visible = false;
            mcChar.head.mcScar.visible = false;
            mcChar.backhair.visible = false;
        }
        public function loadHelm(sFile, sLink):void{
            trace("pMC.loadHelm >");
            rootClass.loadermanager.queueLoad({
                strFile:((((Game.serverFilePath + "items/") + pAV.objData.eqp.he.sType) + "/") + sFile),
                callBackA:onLoadHelmComplete,
                avt:pAV,
                sES:"helm"
            });
        }
        public function onLoadHairComplete(e:Event):void{
            var AssetClass2:Class;
            var AssetClass:Class;
            trace("pMC.onLoadHairComplete >");
            if (pAV.objData.eqp.he == null){
                AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.ha.sLink) as Class);
                if (AssetClass == null){
                    AssetClass = (rootClass.loadermanager.getClass((pAV.objData.eqp.ha.sLink + strGender)) as Class);
                };
                if (AssetClass != null){
                    mcChar.head.mcHair.removeChildAt(0);
                    mcChar.head.mcHair.addChild(new (AssetClass)());
                    mcChar.head.mcHair.visible = true;
                };
            };
            AssetClass2 = (rootClass.loadermanager.getClass((pAV.objData.eqp.ha.sLink + "Back")) as Class);
            if (AssetClass2 == null){
                AssetClass2 = (rootClass.loadermanager.getClass(((pAV.objData.eqp.ha.sLink + "Back") + strGender)) as Class);
            };
            if (AssetClass2 != null){
                mcChar.backhair.removeChildAt(0);
                mcChar.backhair.visible = (((pAV.objData.eqp.he == null)) || (!((pAV.objData.eqp.he.sType == "Head"))));
                mcChar.backhair.addChild(new (AssetClass2)());
            }
            else {
                mcChar.backhair.visible = ((mcChar.head.mcHair.visible) && (bBackHair));
            };
            pAV.objData.eqp.ha.bLoaded = true;
            checkLoadComplete();
        }
        public function disablePNameMouse():void{
            mouseEnabled = false;
            pname.mouseEnabled = false;
            pname.mouseChildren = false;
            pname.removeEventListener(MouseEvent.CLICK, onClickHandler);
        }
        private function recursiveStop(mc:MovieClip):void{
            var i:int;
            var child:DisplayObject;
            i = 0;
            while (i < mc.numChildren) {
                child = mc.getChildAt(i);
                if ((child is MovieClip)){
                    MovieClip(child).stop();
                    recursiveStop(MovieClip(child));
                };
                i++;
            };
        }
        public function onLoadGlovesComplete(e:Event):void{
            var AssetClass:Class;
            var strSkinLinkage:String;
            var e:Event = e;
            strSkinLinkage = pAV.objData.eqp.gl.sLink;
            try {
                AssetClass = (rootClass.loadermanager.getClass(strSkinLinkage) as Class);
                mcChar.fronthand.removeChildAt(0);
                mcChar.fronthand.addChild(new (AssetClass)());
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "Back")) as Class);
                mcChar.backhand.removeChildAt(0);
                mcChar.backhand.addChild(new (AssetClass)());
            }
            catch(e:Error) {
            };
            pAV.objData.eqp.gl.bLoaded = true;
            checkLoadComplete();
        }
        public function FlyToGround():void{
            jumpOP = new Point(this.x, this.y);
            bLanding = false;
            jumpTS = new Date().getTime();
            this.addEventListener(Event.ENTER_FRAME, onJumpDownEnterFrame);
            bFlyTransition = true;
        }
        public function playAnim(anim:Object):void{
            var s:String;
            var e:String;
            var effectClass:Class;
            var cFX:MovieClip;
            var i:int;
            var tAvt:*;
            trace((">>>>>>>>>>>>>>>>>>>>>>>>>> " + anim.animStr));
            s = anim.animStr;
            e = anim.elmt;
            mcChar.gotoAndPlay(s);
            if (anim.cFX != null){
                effectClass = (getDefinitionByName(anim.cFX) as Class);
                cFX = new (effectClass)();
                if ((((anim.cFX == "EyeBeam")) || ((anim.cFX == "EyeBeamWavey")))){
                    tintElementColor(cFX, e);
                };
                mcChar.addChild(cFX);
            };
            if (((!((anim.tFX == null))) && ((anim.tAvts.length > 0)))){
                effectClass = (getDefinitionByName(anim.tFX) as Class);
                cFX = new (effectClass)();
                i = 0;
                while (i < anim.tAvts.length) {
                    tAvt = anim.tAvts[i];
                    tAvt.pMC.mcChar.addChild(cFX);
                    i++;
                };
            };
        }
        public function loadWeaponOff(sFile, sLink):void{
            world.queueLoad({
                strFile:(Game.serverFilePath + sFile),
                callBackA:onLoadWeaponOffComplete,
                avt:pAV,
                sES:"weapon"
            });
        }
        private function checkLoadComplete():void{
            var v:*;
            for (v in pAV.objData.eqp) {
                if (!pAV.objData.eqp[v].bLoaded){
                    return;
                };
            };
            this.gotoAndPlay("in1");
            updatePortrait();
        }
        public function scale(intScale:Number):void{
            var p:Point;
            trace(("AvatarMC.scale() > " + intScale));
            trace(this.mcChar);
            if ((this.mcChar.scaleX >= 0)){
                this.mcChar.scaleX = intScale;
            }
            else {
                this.mcChar.scaleX = -(intScale);
            };
            this.mcChar.scaleY = intScale;
            this.shadow.scaleX = (this.shadow.scaleY = intScale);
            p = this.mcChar.localToGlobal(headPoint);
            p = this.globalToLocal(p);
            this.pname.y = int(p.y);
            this.bubble.y = int((this.pname.y - this.bubble.height));
            this.ignore.y = int(((this.pname.y - this.ignore.height) - 2));
            drawHitBox();
        }
        public function loadBaldHair():void{
            var AssetClass:Class;
            AssetClass = rootClass.getAssetClass("BaldHair");
            mcChar.head.mcHair.removeChildAt(0);
            mcChar.head.mcHair.addChild(new (AssetClass)());
            mcChar.backhair.visible = false;
        }
        public function loadMouth():void{
            var AssetClass:*;
            AssetClass = (rootClass.loadermanager.getClass(rootClass.arrMouth[pAV.objData.iMouth]) as Class);
            mcChar.head.mcMouth.removeChildAt(0);
            mcChar.head.mcMouth.addChild(new (AssetClass)());
        }
        private function updatePortrait():void{
            if (rootClass.world != null){
                trace(">> updatePortrait >> ");
                if (pAV == rootClass.world.myAvatar){
                    rootClass.showPortrait(pAV);
                };
                if (pAV == rootClass.world.myAvatar.target){
                    rootClass.showPortraitTarget(pAV);
                };
            };
        }
        public function changeColor(mc:MovieClip, intColor:Number, strShade:String, op:String=""):void{
            var newCT:ColorTransform;
            newCT = new ColorTransform();
            if (op == ""){
                newCT.color = intColor;
            };
            switch (strShade.toUpperCase()){
                case "LIPS":
                    newCT.redOffset = (newCT.redOffset - 15);
                    newCT.greenOffset = (newCT.greenOffset - 86);
                    newCT.blueOffset = (newCT.blueOffset - 66);
                    break;
                case "LIGHT":
                    newCT.redOffset = (newCT.redOffset + 100);
                    newCT.greenOffset = (newCT.greenOffset + 100);
                    newCT.blueOffset = (newCT.blueOffset + 100);
                    break;
                case "DARK":
                    newCT.redOffset = (newCT.redOffset - 50);
                    newCT.greenOffset = (newCT.greenOffset - 50);
                    newCT.blueOffset = (newCT.blueOffset - 50);
                    break;
                case "DARKER":
                    newCT.redOffset = (newCT.redOffset - 125);
                    newCT.greenOffset = (newCT.greenOffset - 125);
                    newCT.blueOffset = (newCT.blueOffset - 125);
                    break;
            };
            if (op == "-"){
                newCT.redOffset = (newCT.redOffset * -1);
                newCT.greenOffset = (newCT.greenOffset * -1);
                newCT.blueOffset = (newCT.blueOffset * -1);
            };
            if ((((((op == "")) && (!((mc.transform.colorTransform.color == newCT.color))))) || (!((mc.transform.colorTransform.redOffset == newCT.redOffset))))){
                mc.transform.colorTransform = newCT;
            };
        }
        private function drawHitBox():void{
            var hbx:int;
            var hbw:int;
            var hby:int;
            var hbh:int;
            var g:Graphics;
            mcChar.hitbox.graphics.clear();
            hbx = -30;
            hbw = 55;
            hby = mcChar.head.y;
            hbh = (-(hby) * 0.8);
            hitboxR = new Rectangle(hbx, hby, hbw, hbh);
            g = mcChar.hitbox.graphics;
            g.lineStyle(0, 0xFFFFFF, 0);
            g.beginFill(0xAA00FF, 0);
            g.moveTo(hbx, hby);
            g.lineTo((hbx + hbw), hby);
            g.lineTo((hbx + hbw), (hby + hbh));
            g.lineTo(hbx, (hby + hbh));
            g.lineTo(hbx, hby);
            g.endFill();
        }
        public function get location():Point{
            return (new Point(this.x, this.y));
        }
        public function simulateTo(toX:int, toY:int, walkSpeed:int):Point{
            var mvPT:*;
            STAGE = MovieClip(parent.parent);
            this.xDep = this.x;
            this.yDep = this.y;
            this.xTar = toX;
            this.yTar = toY;
            this.walkSpeed = walkSpeed;
            this.nDuration = Math.round((Math.sqrt((Math.pow((this.xTar - this.x), 2) + Math.pow((this.yTar - this.y), 2))) / walkSpeed));
            mvPT = new Point();
            if (this.nDuration){
                this.nXStep = 0;
                this.nYStep = 0;
                if (!this.mcChar.onMove){
                    this.mcChar.onMove = true;
                };
                mvPT = simulateWalkLoop();
            }
            else {
                mvPT = null;
            };
            this.x = this.xDep;
            this.y = this.yDep;
            this.mcChar.onMove = false;
            return (mvPT);
        }
        public function idle():void{
            this.mcChar.gotoAndPlay((framePrefix + "Idle"));
        }
        public function loadNose():void{
            var AssetClass:*;
            AssetClass = (rootClass.loadermanager.getClass(rootClass.arrNose[pAV.objData.iNose]) as Class);
            mcChar.head.mcNose.removeChildAt(0);
            mcChar.head.mcNose.addChild(new (AssetClass)());
        }
        private function onJumpDownEnterFrame(e:Event):void{
            var now:Number;
            var f:Number;
            var deltaY:Number;
            var bCollision:Boolean;
            var r:Rectangle;
            var lookahead:Number;
            var i:*;
            now = new Date().getTime();
            f = (((now - jumpTS) * 24) / 1000);
            deltaY = (12 * this.mcChar.scaleY);
            if (!bLanding){
                bCollision = false;
                r = this.shadow.getBounds(stage);
                lookahead = (8 * deltaY);
                i = 0;
                while (i < STAGE.arrSolid.length) {
                    if (((STAGE.arrSolid[i].shadow.hitTestPoint(r.x, (r.y + lookahead))) || (STAGE.arrSolid[i].shadow.hitTestPoint(r.right, (r.y + lookahead))))){
                        bCollision = true;
                        break;
                    };
                    i++;
                };
                if (!bCollision){
                    this.mcChar.gotoAndPlay("Fly2Ground");
                    this.jumpTargetY = (this.y + lookahead);
                    if (world.map.cell.localToGlobal(new Point(0, this.jumpTargetY)).y >= 500){
                        this.jumpTargetY = world.map.cell.globalToLocal(new Point(0, 500)).y;
                    };
                    bLanding = true;
                };
            };
            this.y = (jumpOP.y + (f * deltaY));
            if (((bLanding) && ((this.y >= this.jumpTargetY)))){
                this.y = this.jumpTargetY;
                this.shadow.visible = true;
                this.removeEventListener(Event.ENTER_FRAME, onJumpDownEnterFrame);
                bFlyTransition = false;
                this.mcChar.gotoAndPlay("Fly2Ground2");
            };
            if (this.pAV.isMyAvatar){
                rootClass.world.mapScrollCheck();
            };
        }
        public function hideHPBar():void{
            this.hpBar.visible = false;
        }
        public function loadGloves(sFile, sLink):void{
            rootClass.loadermanager.queueLoad({
                strFile:((Game.serverFilePath + "items/glove/") + sFile),
                callBackA:onLoadGlovesComplete,
                avt:pAV,
                sES:"gl"
            });
        }
        public function loadHair():void{
            trace("pMC.loadHair >");
            rootClass.loadermanager.queueLoad({
                strFile:((Game.serverFilePath + "items/hair/") + pAV.objData.eqp.ha.sFile),
                callBackA:onLoadHairComplete,
                avt:pAV,
                sES:"hair"
            });
        }

    }
}//package 

