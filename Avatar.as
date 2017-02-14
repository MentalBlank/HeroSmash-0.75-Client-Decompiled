// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Avatar

package {
    import flash.display.MovieClip;
    import flash.text.TextFormat;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;

    public class Avatar {

        public var pMC:MovieClip;
        public var objData:Object;
        public var targets:Object;
        public var uid:int;
        public var target;
        public var bitData:Boolean = false;
        public var dataLeaf:Object;
        public var pnm:String;
        var rootClass;
        public var npcType:String = "player";
        public var strFrame:String = "";
        public var isMyAvatar:Boolean = false;

        public function Avatar(){
            npcType = "player";
            targets = {};
            isMyAvatar = false;
            bitData = false;
            strFrame = "";
            super();
            rootClass = MovieClip(Game.root);
        }
        public function healAnimation():void{
            rootClass.mixer.playSound("Heal");
        }
        public function isUpgraded():Boolean{
            return ((objData.iUpgDays >= 0));
        }
        public function showMC():void{
            if (pMC != null){
                if (rootClass.world.TRASH.contains(pMC)){
                    rootClass.world.CHARS.addChild(rootClass.world.TRASH.removeChild(pMC));
                }
                else {
                    rootClass.world.CHARS.addChild(pMC);
                };
            };
        }
        public function rankUp(strText:String, iRank:int):void{
            var mcRankUp:*;
            healAnimation();
            mcRankUp = pMC.addChild(new RankUpDisplay());
            mcRankUp.t.ti.text = ((strText + ", Rank ") + iRank);
            mcRankUp.x = pMC.mcChar.x;
            mcRankUp.y = (pMC.pname.y + 10);
        }
        public function isMASUpgraded():Boolean{
            return ((objData.iUpgMAS > 0));
        }
        public function isStaff():Boolean{
            return ((objData.intAccessLevel >= 40));
        }
        public function initAvatar(obj:Object){
            var world:*;
            var uoLeaf:*;
            var format:*;
            trace("** AVATAR initAvatar >");
            world = rootClass.world;
            uoLeaf = world.uoTree[pnm];
            objData = obj.data;
            objData.intHP = uoLeaf.intHP;
            objData.intMP = uoLeaf.intMP;
            if (("intGold" in objData)){
                objData.intGold = Number(objData.intGold);
            };
            if (("intCoins" in objData)){
                objData.intCoins = Number(objData.intCoins);
            };
            if (("dUpgExp" in objData)){
                objData.dUpgExp = rootClass.stringToDate(objData.dUpgExp);
            };
            if (("dMutedTill" in objData)){
                objData.dMutedTill = rootClass.stringToDate(objData.dMutedTill);
            };
            objData.iMouth = int(objData.iMouth);
            objData.iNose = int(objData.iNose);
            objData.iEye = int(objData.iEye);
            pMC.strGender = objData.strGender;
            format = new TextFormat();
            format.letterSpacing = 2.5;
            pMC.pname.ti.defaultTextFormat = format;
            if (isUpgraded()){
                pMC.pname.ti.textColor = 52377;
            };
            if (isStaff()){
                pMC.pname.ti.textColor = 16763955;
            };
            pMC.pname.filters = [new GlowFilter(0, 1, 2, 2, 5, BitmapFilterQuality.LOW)];
            pMC.updateName();
            pMC.ignore.visible = rootClass.chatF.isIgnored(obj.data.strUsername);
            pMC.init();
            bitData = true;
        }
        public function isVerified():Boolean{
            return ((((((objData.intAQ > 0)) || ((objData.intDF > 0)))) || ((objData.intMQ > 0))));
        }
        public function hasUpgraded():Boolean{
            return ((objData.iUpg > 0));
        }
        public function hideMC():void{
            if (pMC != null){
                if (rootClass.world.CHARS.contains(pMC)){
                    rootClass.world.TRASH.addChild(rootClass.world.CHARS.removeChild(pMC));
                }
                else {
                    rootClass.world.TRASH.addChild(pMC);
                };
            };
        }
        public function getItemByEquipSlot(slot:String):Object{
            if (((((!((objData == null))) && (!((objData.eqp == null))))) && (!((objData.eqp[slot] == null))))){
                return (objData.eqp[slot]);
            };
            return (null);
        }
        public function isEmailVerified():Boolean{
            return ((objData.intActivationFlag == 5));
        }
        public function levelUp():void{
            var mcLevelUp:*;
            healAnimation();
            mcLevelUp = pMC.addChild(new LevelUpDisplay());
            mcLevelUp.t.ti.text = objData.intLevel;
            mcLevelUp.x = pMC.mcChar.x;
            mcLevelUp.y = (pMC.pname.y + 10);
            rootClass.FB_showFeedDialog("Level Up!", (("reached Level " + objData.intLevel) + " in AQWorlds!"), "aqw-levelup.jpg");
        }

    }
}//package 

