// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//MonsterMC

package {
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;
    import flash.utils.Timer;
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.text.TextFormat;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.display.Sprite;
    import flash.display.Graphics;

    public class MonsterMC extends MovieClip {

        var cbx;
        var cby:Number;
        var walkTS:Number;
        var py;
        var mcChar:MovieClip;
        var xTar;
        var px;
        var nDuration;
        public var isStatic:Boolean = false;
        var yTar:Number;
        var xDep;
        var tp:Point;
        var tx;
        var defaultCT:ColorTransform;
        var ty:Number;
        private var totalTransform:Object;
        public var bubble:MovieClip;
        public var pAV:Avatar;
        var yDep;
        public var pname:MovieClip;
        var nYStep:Number;
        public var shadow:MovieClip;
        public var isMonster:Boolean = true;
        public var hitbox:Rectangle;
        var WORLD:MovieClip;
        private var animQueue:Array;
        var walkD:Number;
        public var mc:MovieClip;
        var iniTimer:Timer;
        var nXStep;
        private var despawnTimer:Timer;
        var op:Point;
        public var hitboxDO:DisplayObject;
        var ox;
        public var spFX:Object;
        var oy;
        private var clampedTransform:ColorTransform;
        var ldr:Loader;

        public function MonsterMC(strName:String){
            var format:*;
            ldr = new Loader();
            defaultCT = MovieClip(this).transform.colorTransform;
            spFX = {};
            isMonster = true;
            isStatic = false;
            despawnTimer = new Timer(5000, 1);
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
            super();
            bubble.visible = false;
            bubble.t = "";
            format = new TextFormat();
            format.letterSpacing = 2.5;
            pname.ti.defaultTextFormat = format;
            pname.filters = [new GlowFilter(0, 1, 2, 2, 2, BitmapFilterQuality.LOW)];
            pname.ti.text = strName.toUpperCase();
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
        public function onClickHandler(e:MouseEvent){
            if (e.shiftKey){
                WORLD.onWalkClick();
            }
            else {
                if (e.ctrlKey){
                    if (WORLD.myAvatar.objData.intAccessLevel >= 40){
                        if (pAV.npcType == "monster"){
                            WORLD.rootClass.sfc.sendXtMessage("zm", "cmd", ["km", ("m:" + pAV.objData.MonMapID)], "str", 1);
                        };
                        if (pAV.npcType == "player"){
                            WORLD.rootClass.sfc.sendXtMessage("zm", "cmd", ["km", ("p:" + pAV.objData.unm.toLowerCase())], "str", 1);
                        };
                    };
                }
                else {
                    if (e.currentTarget.parent == this){
                        if (WORLD.myAvatar.target != pAV){
                            WORLD.setTarget(pAV);
                        }
                        else {
                            if (((!(WORLD.bPvP)) || ((((pAV.dataLeaf.react == null)) || ((pAV.dataLeaf.react[WORLD.myAvatar.dataLeaf.pvpTeam] == 0)))))){
                                WORLD.approachTarget();
                            };
                        };
                    };
                };
            };
        }
        public function walkTo(toX:int, toY:int, walkSpeed:int):void{
            var i:*;
            var dist:Number;
            var dx:Number;
            i = 0;
            while (i < WORLD.arrSolid.length) {
                if (this.shadow.hitTestObject(WORLD.arrSolid[i].shadow)){
                    return;
                };
                i++;
            };
            op = new Point(this.x, this.y);
            tp = new Point(toX, toY);
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
                    if (this.mcChar.currentLabel != "Walk"){
                        this.mcChar.gotoAndPlay("Walk");
                    };
                };
                this.addEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
            };
        }
        private function linearTween(t, b, c, d):Number{
            return ((((c * t) / d) + b));
        }
        public function die():void{
            animQueue = [];
            MovieClip(this.getChildAt(1)).gotoAndPlay("Die");
            mcChar.mouseEnabled = false;
            mcChar.mouseChildren = false;
            despawnTimer.reset();
            despawnTimer.start();
        }
        public function updateNamePlate():void{
            WORLD = MovieClip(parent.parent);
            if (((((((WORLD.bPvP) && (!((pAV.dataLeaf == null))))) && (!((pAV.dataLeaf.react == null))))) && ((pAV.dataLeaf.react[WORLD.myAvatar.dataLeaf.pvpTeam] == 1)))){
                pname.ti.textColor = 0xFFFFFF;
            };
        }
        public function turn(strDir:String):void{
            if (!isStatic){
                if ((((((strDir == "right")) && ((this.mcChar.scaleX < 0)))) || ((((strDir == "left")) && ((this.mcChar.scaleX > 0)))))){
                    this.mcChar.scaleX = (this.mcChar.scaleX * -1);
                };
            };
        }
        private function emoteLoopFrame():int{
            var a:Array;
            var i:int;
            a = mcChar.currentLabels;
            i = 0;
            while (i < a.length) {
                if (a[i].name == currentLabel){
                    return (a[i].frame);
                };
                i++;
            };
            return (8);
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
                bitCollision = false;
                n = 0;
                while (n < WORLD.arrSolid.length) {
                    if (this.shadow.hitTestObject(WORLD.arrSolid[n].shadow)){
                        bitCollision = true;
                        n = WORLD.arrSolid.length;
                    };
                    n++;
                };
                if (bitCollision){
                    nY = this.y;
                    this.y = vY;
                    bitCollision = false;
                    i = 0;
                    while (i < WORLD.arrSolid.length) {
                        if (this.shadow.hitTestObject(WORLD.arrSolid[i].shadow)){
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
                        while (j < WORLD.arrSolid.length) {
                            if (this.shadow.hitTestObject(WORLD.arrSolid[j].shadow)){
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
                if ((((((Math.round(vX) == Math.round(this.x))) && ((Math.round(vY) == Math.round(this.y))))) && ((now > (walkTS + 50))))){
                    this.stopWalking();
                };
            }
            else {
                this.stopWalking();
            };
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
        private function onDespawn(e:Event):void{
            this.alpha = (this.alpha - 0.05);
            if (this.alpha < 0){
                this.visible = false;
                this.alpha = 1;
                this.removeEventListener(Event.ENTER_FRAME, onDespawn);
            };
        }
        public function queueAnim(s:String):void{
            var world:MovieClip;
            var l:String;
            world = (MovieClip(stage.getChildAt(0)).world as MovieClip);
            l = mcChar.currentLabel;
            if (((((hasLabel(s)) && ((pAV.dataLeaf.intState > 0)))) && ((world.staticAnims.indexOf(l) == -1)))){
                if ((((world.combatAnims.indexOf(s) > -1)) && ((world.combatAnims.indexOf(l) > -1)))){
                    animQueue.push(s);
                }
                else {
                    mcChar.gotoAndPlay(s);
                };
            };
        }
        public function clearQueue():void{
            animQueue = [];
        }
        private function checkQueue(e:Event):Boolean{
            var world:MovieClip;
            var l:String;
            var f:int;
            if (animQueue.length > 0){
                world = (MovieClip(stage.getChildAt(0)).world as MovieClip);
                l = mcChar.currentLabel;
                f = emoteLoopFrame();
                if ((((world.combatAnims.indexOf(l) > -1)) && ((mcChar.currentFrame >= (f + 4))))){
                    mcChar.gotoAndPlay(animQueue[0]);
                    animQueue.shift();
                    return (true);
                };
            };
            return (false);
        }
        public function stopWalking():void{
            if (this.mcChar.onMove){
                this.mcChar.onMove = false;
                if (pAV.dataLeaf.intState != 2){
                    this.mcChar.gotoAndPlay("Idle");
                };
                this.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
            };
        }
        public function respawn():void{
            var world:*;
            despawnTimer.reset();
            this.removeEventListener(Event.ENTER_FRAME, onDespawn);
            if (MovieClip(this.getChildAt(1)).currentLabel != "Walk"){
                MovieClip(this.getChildAt(1)).gotoAndStop("Idle");
            };
            this.alpha = 1;
            this.visible = true;
            mcChar.mouseEnabled = true;
            mcChar.mouseChildren = true;
            world = MovieClip(stage.getChildAt(0)).world;
        }
        public function init(){
            WORLD = MovieClip(parent.parent);
            mcChar = MovieClip(this.getChildAt(1));
            mcChar.addEventListener(MouseEvent.CLICK, onClickHandler);
            pname.addEventListener(MouseEvent.CLICK, onClickHandler);
            despawnTimer.addEventListener(TimerEvent.TIMER, despawn);
            this.addEventListener(Event.ENTER_FRAME, checkQueue, false, 0, true);
            pname.mouseChildren = false;
            mcChar.buttonMode = true;
            pname.buttonMode = true;
            shadow.mouseEnabled = (shadow.mouseChildren = false);
            mcChar.cacheAsBitmap = true;
        }
        public function fClose(){
            var world:*;
            var CHARS:*;
            world = MovieClip(stage.getChildAt(0)).world;
            CHARS = world.CHARS;
            mcChar.removeEventListener(MouseEvent.CLICK, onClickHandler);
            pname.removeEventListener(MouseEvent.CLICK, onClickHandler);
            despawnTimer.removeEventListener(TimerEvent.TIMER, despawn);
            this.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
            this.removeEventListener(Event.ENTER_FRAME, onDespawn);
            this.removeEventListener(Event.ENTER_FRAME, checkQueue);
            if (world.CHARS.contains(this)){
                world.CHARS.removeChild(this);
            };
            if (world.TRASH.contains(this)){
                world.TRASH.removeChild(this);
            };
        }
        public function scale(intScale:Number):void{
            var p:Point;
            var globalP:Point;
            if ((this.mcChar.scaleX >= 0)){
                this.mcChar.scaleX = intScale;
            }
            else {
                this.mcChar.scaleX = -(intScale);
            };
            this.mcChar.scaleY = intScale;
            this.shadow.scaleX = (this.shadow.scaleY = intScale);
            this.bubble.y = (-(this.mcChar.height) - 10);
            this.pname.y = (-(this.mcChar.height) - 10);
            p = new Point(0, (-(this.mcChar.height) - 20));
            globalP = this.localToGlobal(p);
            if (globalP.y < 50){
                globalP.y = 50;
            };
            p = this.globalToLocal(globalP);
            this.pname.y = p.y;
            drawHitBox();
        }
        private function despawn(e:TimerEvent):void{
            var world:*;
            world = MovieClip(stage.getChildAt(0)).world;
            if (world.myAvatar.target == this.pAV){
                world.setTarget(null);
            };
            this.addEventListener(Event.ENTER_FRAME, onDespawn);
        }
        private function drawHitBox():void{
            var mcCharBounds:Rectangle;
            var tl:Point;
            var br:Point;
            var hbx:int;
            var hbw:int;
            var hby:int;
            var hbh:int;
            var hb:Sprite;
            var g:Graphics;
            if (hitboxDO != null){
                mcChar.removeChild(hitboxDO);
            };
            hitboxDO = null;
            mcCharBounds = mcChar.getBounds(stage);
            tl = mcCharBounds.topLeft;
            br = mcCharBounds.bottomRight;
            tl = mcChar.globalToLocal(tl);
            br = mcChar.globalToLocal(br);
            mcCharBounds = new Rectangle(tl.x, tl.y, (br.x - tl.x), (br.y - tl.y));
            hbx = (mcCharBounds.x + (mcCharBounds.width * 0.2));
            if (hbx > (shadow.x - shadow.width)){
                hbx = (shadow.x - shadow.width);
            };
            hbw = (mcCharBounds.width * 0.6);
            if (hbw < (2 * shadow.width)){
                hbw = (2 * shadow.width);
            };
            hby = (mcCharBounds.y + (mcCharBounds.height * 0.2));
            hbh = (mcCharBounds.height * 0.6);
            hitbox = new Rectangle(hbx, hby, hbw, hbh);
            hb = new Sprite();
            g = hb.graphics;
            g.lineStyle(0, 0xFFFFFF, 0);
            g.beginFill(0xAA00FF, 0);
            g.moveTo(hbx, hby);
            g.lineTo((hbx + hbw), hby);
            g.lineTo((hbx + hbw), (hby + hbh));
            g.lineTo(hbx, (hby + hbh));
            g.lineTo(hbx, hby);
            g.endFill();
            hitboxDO = mcChar.addChild(hb);
        }

    }
}//package 

