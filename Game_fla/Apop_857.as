// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Game_fla.Apop_857

package Game_fla{
    import flash.display.MovieClip;

    public dynamic class Apop_857 extends MovieClip {

        public var npc:MovieClip;

        public function Apop_857(){
            addFrameScript(0, frame1, 1, frame2, 9, frame10, 27, frame28, 30, frame31, 37, frame38, 45, frame46, 53, frame54, 56, frame57, 63, frame64, 71, frame72);
        }
        function frame72(){
            gotoAndStop("hold");
        }
        function frame64(){
            gotoAndPlay("init");
        }
        function frame10(){
            npc.visible = true;
        }
        function frame1(){
            npc.visible = false;
        }
        function frame2(){
            stop();
        }
        function frame28(){
            stop();
        }
        function frame38(){
            gotoAndPlay("init");
        }
        function frame31(){
            npc.visible = true;
        }
        function frame46(){
            npc.visible = true;
        }
        function frame54(){
            stop();
        }
        function frame57(){
            npc.visible = true;
        }

    }
}//package Game_fla

