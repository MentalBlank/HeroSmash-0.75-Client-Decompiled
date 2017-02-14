// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//AvatarMCCopier

package {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.display.DisplayObject;

    public class AvatarMCCopier {

        private var objLinks:Object;
        private var loadedCount:Number = 0;
        private var mcChar:MovieClip;
        public var world;
        private var loadCharByIDCallback:Function;
        private var pAV:Avatar;
        private var npcData:Object;
        private var waitOnNum:Number = 0;
        public var rootClass:MovieClip;
        private var strGender:String;

        public function AvatarMCCopier(root:MovieClip):void{
            objLinks = {};
            waitOnNum = 0;
            loadedCount = 0;
            super();
            rootClass = root;
        }
        public function onLoadNPCCapeComplete(e:Event):void{
            var AssetClass:Class;
            trace(npcData.eqp.ba.sLink);
            AssetClass = (rootClass.loadermanager.getClass(npcData.eqp.ba.sLink) as Class);
            mcChar.cape.removeChildAt(0);
            mcChar.cape.mcCape = new (AssetClass)();
            mcChar.cape.addChild(mcChar.cape.mcCape);
            mcChar.cape.visible = true;
            isAllLoaded();
        }
        public function loadMouth():void{
            var AssetClass:*;
            AssetClass = (rootClass.loadermanager.getClass(rootClass.arrMouth[pAV.objData.iMouth]) as Class);
            mcChar.head.mcMouth.removeChildAt(0);
            mcChar.head.mcMouth.addChild(new (AssetClass)());
        }
        public function onLoadNPCHairComplete(e:Event){
            var strGender:*;
            var AssetClass2:Class;
            var AssetClass:Class;
            trace("pMC.onLoad NPC HairComplete >");
            strGender = npcData.strGender;
            if (npcData.eqp.he == null){
                AssetClass = (rootClass.loadermanager.getClass(npcData.eqp.ha.sLink) as Class);
                if (AssetClass == null){
                    AssetClass = (rootClass.loadermanager.getClass((npcData.eqp.ha.sLink + strGender)) as Class);
                }
                else {
                    loadBaldHair();
                };
                if (AssetClass != null){
                    mcChar.head.mcHair.removeChildAt(0);
                    mcChar.head.mcHair.addChild(new (AssetClass)());
                    mcChar.head.mcHair.visible = true;
                };
            };
            AssetClass2 = (rootClass.loadermanager.getClass((npcData.eqp.ha.sLink + "Back")) as Class);
            if (AssetClass2 == null){
                AssetClass2 = (rootClass.loadermanager.getClass(((npcData.eqp.ha.sLink + "Back") + strGender)) as Class);
            };
            if (AssetClass2 != null){
                mcChar.backhair.removeChildAt(0);
                mcChar.backhair.visible = true;
                mcChar.backhair.addChild(new (AssetClass2)());
            }
            else {
                mcChar.backhair.visible = false;
            };
            isAllLoaded();
        }
        public function onLoadHelmComplete(e:Event):void{
            var AssetClass:Class;
            trace("pMC.onLoadHelmComplete >");
            AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.he.sLink) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((pAV.objData.eqp.he.sLink + strGender)) as Class);
            };
            if (AssetClass != null){
                mcChar.head.mcHair.removeChildAt(0);
                mcChar.head.mcHair.addChild(new (AssetClass)());
                mcChar.head.mcHair.visible = true;
            }
            else {
                rootClass.chatF.pushMsg("warning", "Could not resolve Helm definition.", "SERVER", "", 0);
            };
        }
        public function loadArmorPieces(strSkinLinkage:String):void{
            var AssetClass:Class;
            var child:DisplayObject;
            var strSkinLinkage:String = strSkinLinkage;
            trace("Copier.loadArmorPieces");
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
        public function onLoadNPCMaskComplete(e:Event):void{
            var strGender:*;
            var AssetClass:Class;
            trace("pMC.onLoadMaskComplete >");
            strGender = npcData.strGender;
            AssetClass = (rootClass.loadermanager.getClass(npcData.eqp.ma.sLink) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((npcData.eqp.ma.sLink + strGender)) as Class);
            };
            if (AssetClass != null){
                if (mcChar.head.mcMask.numChildren > 0){
                    mcChar.head.mcMask.removeChildAt(0);
                };
                mcChar.head.mcMask.addChild(new (AssetClass)());
                mcChar.head.mcMask.visible = true;
            }
            else {
                rootClass.chatF.pushMsg("warning", "Could not resolve Mask definition.", "SERVER", "", 0);
            };
            isAllLoaded();
        }
        public function onLoadWeaponOffComplete(e:Event):void{
            var AssetClass:Class;
            var e:Event = e;
            trace("onLoadWeaponOffComplete >");
            mcChar.weaponOff.removeChildAt(0);
            try {
                AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.Weapon.sLink) as Class);
                mcChar.weaponOff.addChild(new (AssetClass)());
            }
            catch(err:Error) {
                trace(" weaponOff added to display list manually");
                mcChar.weaponOff.addChild(e.target.content);
            };
            mcChar.weaponOff.visible = true;
        }
        public function copyNPC():void{
            var killList:* = undefined;
            var i:* = undefined;
            var faceKillList:* = undefined;
            var j:* = undefined;
            var sES:* = undefined;
            var AssetClass:* = undefined;
            world = rootClass.world;
            strGender = npcData.strGender;
            killList = ["cape", "backhair", "robe", "backrobe", "weapon1", "weapon2"];
            for (i in killList) {
                if (typeof(mcChar[killList[i]]) != undefined){
                    mcChar[killList[i]].visible = false;
                };
            };
            faceKillList = ["mcMask", "mcHelm", "mcScar"];
            for (j in faceKillList) {
                if (typeof(mcChar.head[faceKillList[j]]) != undefined){
                    mcChar.head[faceKillList[j]].visible = false;
                };
            };
            try {
                AssetClass = (rootClass.loadermanager.getClass(("DefaultHead" + strGender)) as Class);
                mcChar.head.face.removeChildAt(0);
                mcChar.head.face.addChild(new (AssetClass)());
            }
            catch(e:Error) {
                trace(e.message);
            };
            if (npcData.eqp.ar == null){
                objLinks.ar = "Default";
                onLoadNPCArmorComplete(null);
            };
            loadMouth();
            loadNose();
            loadEyes();
            for (sES in npcData.eqp) {
                trace((sES + " sES on npc"));
                switch (sES){
                    case "ha":
                        rootClass.loadermanager.queueLoad({
                            strFile:((Game.serverFilePath + "items/hair/") + npcData.eqp.ha.sFile),
                            callBackA:onLoadNPCHairComplete,
                            avt:pAV,
                            sES:"hair"
                        });
                        break;
                    case "we":
                        rootClass.loadermanager.queueLoad({
                            strFile:((((Game.serverFilePath + "items/") + npcData.eqp.we.sType) + "/") + npcData.eqp.we.sFile),
                            callBackA:onLoadNPCWeaponComplete,
                            sES:"weapon"
                        });
                        break;
                    case "he":
                        rootClass.loadermanager.queueLoad({
                            strFile:((((Game.serverFilePath + "items/") + npcData.eqp.he.sType) + "/") + npcData.eqp.he.sFile),
                            callBackA:onLoadNPCHelmComplete,
                            sES:"helm"
                        });
                        break;
                    case "ma":
                        rootClass.loadermanager.queueLoad({
                            strFile:((((Game.serverFilePath + "items/") + npcData.eqp.ma.sType) + "/") + npcData.eqp.ma.sFile),
                            callBackA:onLoadNPCMaskComplete,
                            sES:"mask"
                        });
                        break;
                    case "sc":
                        rootClass.loadermanager.queueLoad({
                            strFile:((((Game.serverFilePath + "items/") + npcData.eqp.sc.sType) + "/") + npcData.eqp.sc.sFile),
                            callBackA:onLoadNPCScarComplete,
                            sES:"scar"
                        });
                        break;
                    case "ba":
                        rootClass.loadermanager.queueLoad({
                            strFile:((((Game.serverFilePath + "items/") + npcData.eqp.ba.sType) + "/") + npcData.eqp.ba.sFile),
                            callBackA:onLoadNPCCapeComplete,
                            sES:"cape"
                        });
                        break;
                    case "gl":
                        rootClass.loadermanager.queueLoad({
                            strFile:((Game.serverFilePath + "items/glove/") + npcData.eqp.gl.sFile),
                            callBackA:onLoadNPCGlovesComplete,
                            sES:"gl"
                        });
                        break;
                    case "ar":
                        objLinks.ar = npcData.eqp.ar.sLink;
                        rootClass.loadermanager.queueLoad({
                            strFile:((Game.serverFilePath + "items/armor/") + npcData.eqp.ar.sFile),
                            callBackA:onLoadNPCArmorComplete,
                            avt:pAV,
                            sES:"ar"
                        });
                        trace((npcData.eqp.ar.sLink + " equip array ++++-------------------------"));
                        break;
                };
            };
        }
        public function loadCharByID(mc:MovieClip, charID:Number, callback:Function):void{
            world = rootClass.world;
            mcChar = mc;
            loadCharByIDCallback = callback;
            world.sendGetCharDataByID(charID);
        }
        public function onLoadCapeComplete(e:Event):void{
            var AssetClass:Class;
            trace(pAV.objData.eqp.ba.sLink);
            AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.ba.sLink) as Class);
            mcChar.cape.removeChildAt(0);
            mcChar.cape.mcCape = new (AssetClass)();
            mcChar.cape.addChild(mcChar.cape.mcCape);
            mcChar.cape.visible = true;
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
        }
        public function onLoadNPCArmorComplete(e:Event){
            var strSkinLinkage:* = undefined;
            var AssetClass:Class;
            var child:DisplayObject;
            var e:Event = e;
            strSkinLinkage = objLinks.ar;
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
            if (npcData.eqp.gl == null){
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
            isAllLoaded();
        }
        public function onLoadNPCScarComplete(e:Event):void{
            var strGender:*;
            var AssetClass:Class;
            trace("pMC.onLoadScarComplete >");
            strGender = npcData.strGender;
            AssetClass = (rootClass.loadermanager.getClass(npcData.eqp.sc.sLink) as Class);
            if (AssetClass != null){
                if (mcChar.head.mcScar.numChildren > 0){
                    mcChar.head.mcScar.removeChildAt(0);
                };
                mcChar.head.mcScar.addChild(new (AssetClass)());
                mcChar.head.mcScar.visible = true;
            }
            else {
                rootClass.chatF.pushMsg("warning", "Could not resolve Scar definition.", "SERVER", "", 0);
            };
            isAllLoaded();
        }
        public function onLoadHairComplete(e:Event):void{
            var AssetClass2:Class;
            var AssetClass:Class;
            trace("pMC.onLoadHairComplete >");
            if (pAV.objData.eqp.he == null){
                AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.ha.sLink) as Class);
                if (AssetClass == null){
                    AssetClass = (rootClass.loadermanager.getClass((pAV.objData.eqp.ha.sLink + strGender)) as Class);
                }
                else {
                    loadBaldHair();
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
                mcChar.backhair.visible = true;
                mcChar.backhair.addChild(new (AssetClass2)());
            }
            else {
                mcChar.backhair.visible = false;
            };
        }
        public function onLoadArmorComplete(e:Event):void{
            loadArmorPieces(objLinks.ar);
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
        public function copyTo(_mcChar:MovieClip):void{
            var killList:* = undefined;
            var i:* = undefined;
            var faceKillList:* = undefined;
            var j:* = undefined;
            var sES:* = undefined;
            var AssetClass:* = undefined;
            var _mcChar:MovieClip = _mcChar;
            world = rootClass.world;
            mcChar = _mcChar;
            pAV = (MovieClip(mcChar.parent).pAV = world.myAvatar);
            strGender = pAV.objData.strGender;
            killList = ["cape", "backhair", "robe", "backrobe", "weapon1", "weapon2"];
            for (i in killList) {
                if (typeof(mcChar[killList[i]]) != undefined){
                    mcChar[killList[i]].visible = false;
                };
            };
            faceKillList = ["mcMask", "mcHelm", "mcScar"];
            for (j in faceKillList) {
                if (typeof(mcChar.head[faceKillList[j]]) != undefined){
                    mcChar.head[faceKillList[j]].visible = false;
                };
            };
            try {
                AssetClass = (rootClass.loadermanager.getClass(("DefaultHead" + strGender)) as Class);
                mcChar.head.face.removeChildAt(0);
                mcChar.head.face.addChild(new (AssetClass)());
            }
            catch(e:Error) {
                trace(e.message);
            };
            if (((!(pAV.dataLeaf.showHelm)) || (((!(("he" in pAV.objData.eqp))) && ((pAV.objData.eqp.he == null)))))){
                onLoadHairComplete(null);
            };
            if (world.myAvatar.objData.eqp.ar == null){
                objLinks.ar = "Default";
                onLoadArmorComplete(null);
            };
            for (sES in world.myAvatar.objData.eqp) {
                trace(sES);
                switch (sES){
                    case "we":
                        rootClass.loadermanager.queueLoad({
                            strFile:((((Game.serverFilePath + "items/") + pAV.objData.eqp.we.sType) + "/") + pAV.objData.eqp[sES].sFile),
                            callBackA:onLoadWeaponComplete,
                            avt:pAV,
                            sES:"weapon"
                        });
                        break;
                    case "he":
                        onLoadHelmComplete(null);
                        break;
                    case "ma":
                        onLoadMaskComplete(null);
                        break;
                    case "sc":
                        onLoadScarComplete(null);
                        break;
                    case "ba":
                        onLoadCapeComplete(null);
                        break;
                    case "gl":
                        onLoadGlovesComplete(null);
                        break;
                    case "ar":
                        objLinks.ar = pAV.objData.eqp.ar.sLink;
                        trace((pAV.objData.eqp.ar.sLink + " equip array ++++-------------------------"));
                        onLoadArmorComplete(null);
                        break;
                };
                loadMouth();
                loadNose();
                loadEyes();
            };
        }
        public function onLoadNPCWeaponComplete(e:Event){
            var AssetClass:Class;
            var e:Event = e;
            trace("onLoad NPC WeaponComplete >");
            try {
                AssetClass = (rootClass.loadermanager.getClass(npcData.eqp.we.sLink) as Class);
                mcChar.weapon1.removeChildAt(0);
                mcChar.weapon1.addChild(new (AssetClass)());
            }
            catch(err:Error) {
            };
            mcChar.weapon1.visible = true;
            mcChar.weapon2.visible = false;
            isAllLoaded();
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
                rootClass.chatF.pushMsg("warning", "Could not resolve Mask definition.", "SERVER", "", 0);
            };
        }
        private function showface():void{
            mcChar.head.mcEyes.visible = true;
            mcChar.head.mcNose.visible = true;
            mcChar.head.mcMouth.visible = true;
            mcChar.head.mcMask.visible = !((npcData.eqp.ma == null));
            mcChar.head.mcScar.visible = !((npcData.eqp.sc == null));
            mcChar.head.face.visible = true;
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
                mcChar.head.mcScar.visible = true;
            }
            else {
                rootClass.chatF.pushMsg("warning", "Could not resolve Scar definition.", "SERVER", "", 0);
            };
        }
        public function loadNose():void{
            var AssetClass:*;
            AssetClass = (rootClass.loadermanager.getClass(rootClass.arrNose[pAV.objData.iNose]) as Class);
            mcChar.head.mcNose.removeChildAt(0);
            mcChar.head.mcNose.addChild(new (AssetClass)());
        }
        public function loadEyes():void{
            var AssetClass:*;
            AssetClass = (rootClass.loadermanager.getClass((rootClass["arrEyes"][pAV.objData.iEye] + strGender)) as Class);
            mcChar.head.mcEyes.removeChildAt(0);
            mcChar.head.mcEyes.addChild(new (AssetClass)());
        }
        public function loadWeaponOff(sFile, sLink):void{
            rootClass.loadermanager.queueLoad({
                strFile:(Game.serverFilePath + sFile),
                callBackA:onLoadWeaponOffComplete,
                avt:pAV,
                sES:"weapon"
            });
        }
        public function onLoadNPCGlovesComplete(e:Event):void{
            var AssetClass:Class;
            var strSkinLinkage:String;
            var e:Event = e;
            strSkinLinkage = npcData.eqp.gl.sLink;
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
            isAllLoaded();
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
                };
                if (pAV == world.myAvatar){
                    rootClass.showPortrait(pAV);
                };
                if (pAV == world.myAvatar.target){
                    rootClass.showPortraitTarget(pAV);
                };
            };
        }
        public function onLoadNPCHelmComplete(e:Event){
            var AssetClass:Class;
            AssetClass = (rootClass.loadermanager.getClass(npcData.eqp.he.sLink) as Class);
            if (AssetClass == null){
                AssetClass = (rootClass.loadermanager.getClass((npcData.eqp.he.sLink + strGender)) as Class);
            };
            if (AssetClass != null){
                if (npcData.eqp.he.sType == "Head"){
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
            isAllLoaded();
        }
        public function onCharacterDataLoaded(objData:Object):void{
            var v:*;
            var ES:*;
            var j:*;
            var n:*;
            for (v in objData) {
                trace(((v + ": ") + objData[v]));
                for (j in objData[v]) {
                    trace((j + "-attribute Child"));
                    trace((((j + ":") + objData[v][j]) + " - objChild"));
                    for (n in objData[v][j]) {
                        trace((((n + ":") + objData[v][j][n]) + "-child of child"));
                    };
                };
            };
            npcData = objData;
            for (ES in npcData.eqp) {
                waitOnNum++;
            };
            trace((waitOnNum + "  wait onNum in data loaded"));
            mcChar.pAV = new Avatar();
            mcChar.pAV.objData = objData;
            pAV = mcChar.pAV;
            copyNPC();
        }
        public function isAllLoaded(){
            loadedCount++;
            trace(((loadedCount + " loaded Count for ") + mcChar));
            if (loadedCount >= waitOnNum){
                trace("Everything for this NPC has been loaded");
                loadCharByIDCallback();
            };
        }
        public function loadBaldHair():void{
            var AssetClass:Class;
            AssetClass = rootClass.getAssetClass("BaldHair");
            mcChar.head.mcHair.removeChildAt(0);
            mcChar.head.mcHair.addChild(new (AssetClass)());
            mcChar.backhair.visible = false;
        }

    }
}//package 

