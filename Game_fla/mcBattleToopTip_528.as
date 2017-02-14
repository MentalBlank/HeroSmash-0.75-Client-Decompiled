// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.mcBattleToopTip_528

package Game_fla{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public dynamic class mcBattleToopTip_528 extends MovieClip {

        public var mcBottom:MovieClip;
        public var ti:TextField;
        public var mcMid:MovieClip;
        public var mcTop:MovieClip;

        public function mcBattleToopTip_528(){
            addFrameScript(0, frame1);
        }
        function frame1(){
            ti.autoSize = "left";
        }
        public function hide():void{
            this.visible = false;
        }
        public function show(str:String):void{
            var heightdiff:*;
            this.visible = true;
            ti.htmlText = str;
            heightdiff = (ti.textHeight - 54.6);
            mcMid.height = ((49.9 + heightdiff) + 5);
            mcBottom.y = (mcMid.y + mcMid.height);
        }

    }
}//package Game_fla

