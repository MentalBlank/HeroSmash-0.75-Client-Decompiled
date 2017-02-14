// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Preview

package {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.display.Loader;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.IOErrorEvent;
    import flash.geom.Rectangle;
    import flash.utils.*;
    import flash.geom.*;

    public class Preview extends MovieClip {

        var mcChar:MovieClip;
        public var itemDisplay:MovieClip;
        public var bg:MovieClip;
        public var strInfo:TextField;
        var pAV:Avatar;
        var isLoading:Boolean = false;
        public var txtAction:TextField;
        public var itemLoaded:Boolean = true;
        public var btnClose:SimpleButton;
        public var mcLabel:MovieClip;
        var item:Object;
        public var btnDelete:SimpleButton;
        public var mcCoin:MovieClip;
        var curItem:String;
        public var strCost:TextField;
        public var mcUpgrade:MovieClip;
        public var btnAction:SimpleButton;
        var rootClass:MovieClip;
        public var mcIconDelete:MovieClip;
        var ldr:Loader;

        public function Preview(){
            ldr = new Loader();
            isLoading = false;
            itemLoaded = true;
            super();
            rootClass = MovieClip(stage.getChildAt(0));
            curItem = null;
            btnClose.addEventListener(MouseEvent.CLICK, xClick, false, 0, true);
            pAV = rootClass.world.myAvatar;
            this.visible = false;
            if (MovieClip(parent).name == "mcInventory"){
                trace("Inventory");
            };
            txtAction.mouseEnabled = false;
        }
        public function onLoadFloorComplete(e:Event):void{
            var link:String;
            var floorMC:MovieClip;
            var AssetClass:Class;
            var e:Event = e;
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    link = item.sLink;
                    floorMC = new MovieClip();
                    try {
                        AssetClass = (rootClass.loadermanager.getClass(link) as Class);
                        itemDisplay.addChild(floorMC);
                        floorMC.addChild(new (AssetClass)());
                        floorMC.scaleX = (floorMC.scaleY = calculateScale(floorMC));
                        floorMC.x = calculateX(floorMC);
                        floorMC.y = calculateY(floorMC);
                    }
                    catch(err:Error) {
                    };
                }
                catch(e:Error) {
                };
            };
        }
        public function onLoadWeaponComplete(e:Event):void{
            var weaponSize:* = undefined;
            var strSkinLinkage:String;
            var weaponMC:MovieClip;
            var AssetClass:Class;
            var e:Event = e;
            trace("onLoadWeaponComplete >");
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    weaponSize = 0.4;
                    strSkinLinkage = item.sLink;
                    weaponMC = new MovieClip();
                    try {
                        AssetClass = (rootClass.loadermanager.getClass(strSkinLinkage) as Class);
                        itemDisplay.addChild(weaponMC);
                        weaponMC.addChild(new (AssetClass)());
                        weaponMC.scaleX = (weaponMC.scaleY = weaponSize);
                        weaponMC.x = calculateX(weaponMC);
                        weaponMC.y = calculateY(weaponMC);
                    }
                    catch(err:Error) {
                    };
                }
                catch(e:Error) {
                };
            };
        }
        public function onLoadMaskComplete(e:Event):void{
            var maskSize:* = undefined;
            var strSkinLinkage:String;
            var maskMC:MovieClip;
            var headMC:MovieClip;
            var strGender:* = undefined;
            var AssetClass:Class;
            var e:Event = e;
            trace("pMC.onLoadMaskComplete >");
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    maskSize = 1.8;
                    strSkinLinkage = item.sLink;
                    maskMC = new MovieClip();
                    strGender = rootClass.world.myAvatar.objData.strGender;
                    itemDisplay.addChild(maskMC);
                    loadDefaultHead(maskMC);
                    headMC = (maskMC.getChildAt(0) as MovieClip);
                    headMC.pAV = pAV;
                    AssetClass = (rootClass.loadermanager.getClass(strSkinLinkage) as Class);
                    if (AssetClass == null){
                        AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + strGender)) as Class);
                    };
                    if (AssetClass != null){
                        headMC.head.mcMask.removeChildAt(0);
                        headMC.head.mcMask.addChild(new (AssetClass)());
                        headMC.head.mcMask.visible = true;
                    }
                    else {
                        trace("Could not resolve mask definition.");
                    };
                    maskMC.scaleX = (maskMC.scaleY = maskSize);
                    maskMC.x = calculateX(maskMC);
                    maskMC.y = calculateY(maskMC);
                }
                catch(e:Error) {
                };
            };
        }
        public function onLoadArmorComplete(e:Event):void{
            var evt:* = undefined;
            var bodySize:* = undefined;
            var strSkinLinkage:String;
            var bodyMC:MovieClip;
            var strGender:* = undefined;
            var AssetClass:Class;
            var e:Event = e;
            trace("pMC.loadArmorComplete >");
            evt = e.currentTarget;
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                clearLoader();
                bodySize = 1.4;
                strSkinLinkage = item.sLink;
                bodyMC = new MovieClip();
                strGender = rootClass.world.myAvatar.objData.strGender;
                itemDisplay.addChild(bodyMC);
                loadDefaultBody(bodyMC);
                mcChar = (bodyMC.getChildAt(0) as MovieClip);
                mcChar.pAV = pAV;
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
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "LowerArmFront")) as Class);
                mcChar.fronthand.removeChildAt(0);
                mcChar.fronthand.addChild(new (AssetClass)());
                AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "LowerArmBack")) as Class);
                mcChar.backhand.removeChildAt(0);
                mcChar.backhand.addChild(new (AssetClass)());
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
                bodyMC.scaleX = (bodyMC.scaleY = bodySize);
                bodyMC.x = calculateX(bodyMC);
                bodyMC.y = calculateY(bodyMC);
                trace("Body Loaded Complete");
                onLoadAvatarHairComplete(null);
            };
        }
        public function loadScar(sFile, sLink):void{
            trace("pMC.loadScar >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/scar/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadScarComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function onLoadHelmComplete(e:Event):void{
            var strSkinLinkage:String;
            var strGender:* = undefined;
            var helmMC:MovieClip;
            var helmSize:Number;
            var AssetClass:Class;
            var AssetClass2:Class;
            var e:Event = e;
            trace("pMC.onLoadHelmComplete >");
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    strSkinLinkage = item.sLink;
                    strGender = rootClass.world.myAvatar.objData.strGender;
                    helmMC = new MovieClip();
                    helmSize = 0.45;
                    itemDisplay.addChild(helmMC);
                    AssetClass = (rootClass.loadermanager.getClass(strSkinLinkage) as Class);
                    if (AssetClass == null){
                        AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + strGender)) as Class);
                    };
                    AssetClass2 = (rootClass.loadermanager.getClass((strSkinLinkage + "Back")) as Class);
                    if (AssetClass2 == null){
                        AssetClass2 = (rootClass.loadermanager.getClass(((strSkinLinkage + "Back") + strGender)) as Class);
                    };
                    if (AssetClass != null){
                        if (AssetClass2 != null){
                            helmMC.addChild(new (AssetClass2)());
                        };
                        helmMC.addChild(new (AssetClass)());
                        helmMC.scaleX = (helmMC.scaleY = helmSize);
                        helmMC.x = calculateX(helmMC);
                        helmMC.y = calculateY(helmMC);
                    }
                    else {
                        trace("Could not resolve Helm definition.");
                    };
                }
                catch(e:Error) {
                };
            };
        }
        public function loadWeapon(sFile, sLink):void{
            var wType:*;
            trace("pMC.loadWeapon >");
            wType = item.sType.toLowerCase();
            trace((((((rootClass.sFilePath + "items/") + wType) + "/") + sFile) + " - character loaded"));
            ldr.load(new URLRequest(((((rootClass.sFilePath + "items/") + wType) + "/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadWeaponComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function loadDefaultBody(mc:MovieClip){
            var AssetClass:Class;
            var strGender:*;
            var addedMC:MovieClip;
            trace("Load Default Body");
            strGender = rootClass.world.myAvatar.objData.strGender;
            AssetClass = (rootClass.loadermanager.getClass("prevBody") as Class);
            mc.addChild(new (AssetClass)());
            addedMC = (mc.getChildAt(0) as MovieClip);
            if (strGender == "F"){
                AssetClass = (rootClass.loadermanager.getClass(("DefaultHead" + strGender)) as Class);
                addedMC.head.face.removeChildAt(0);
                addedMC.head.face.addChild(new (AssetClass)());
                AssetClass = (rootClass.loadermanager.getClass(("DefaultChest" + strGender)) as Class);
                addedMC.chest.removeChildAt(0);
                addedMC.chest.addChild(new (AssetClass)());
                AssetClass = (rootClass.loadermanager.getClass("EYES1aF") as Class);
                addedMC.head.mcEyes.removeChildAt(0);
                addedMC.head.mcEyes.addChild(new (AssetClass)());
            };
            addedMC.backhair.visible = false;
            addedMC.head.mcMask.visible = false;
            addedMC.head.mcHair.visible = false;
            addedMC.head.mcScar.visible = false;
            addedMC.head.mcHelm.visible = false;
            addedMC.weapon1.visible = false;
            addedMC.weapon2.visible = false;
            addedMC.cape.visible = false;
        }
        public function clearLoader(){
            if (ldr.hasEventListener(Event.COMPLETE)){
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadScarComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadScarComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadHairComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadCapeComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadHeadComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadHelmComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadArmorComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadMaskComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadWeaponComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadHouseComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadWallComplete);
                }
                catch(e:Error) {
                };
                try {
                    ldr.removeEventListener(Event.COMPLETE, onLoadFloorComplete);
                }
                catch(e:Error) {
                };
            };
            ldr.unload();
            ldr = null;
            ldr = new Loader();
        }
        public function loadFloor(sFile, sLink):void{
            trace("pMC.loadHouse >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/house/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadFloorComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function loadQuestItem(){
            var iMC:MovieClip;
            var AssetClass:*;
            isLoading = false;
            iMC = new MovieClip();
            itemDisplay.addChild(iMC);
            AssetClass = (rootClass.loadermanager.getClass("iiqitem") as Class);
            iMC.addChild(new (AssetClass)());
            iMC.scaleX = (iMC.scaleY = 3);
            iMC.x = calculateX(iMC);
            iMC.y = calculateY(iMC);
        }
        public function loadCape(sFile, sLink):void{
            trace("pMC.loadCape >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/cape/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadCapeComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function onLoadScarComplete(e:Event):void{
            var scarSize:* = undefined;
            var strSkinLinkage:String;
            var scarMC:MovieClip;
            var headMC:MovieClip;
            var strGender:* = undefined;
            var AssetClass:Class;
            var e:Event = e;
            trace("pMC.onLoadScarComplete >");
            clearLoader();
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    scarSize = 1.8;
                    strSkinLinkage = item.sLink;
                    scarMC = new MovieClip();
                    strGender = rootClass.world.myAvatar.objData.strGender;
                    itemDisplay.addChild(scarMC);
                    loadDefaultHead(scarMC);
                    headMC = (scarMC.getChildAt(0) as MovieClip);
                    headMC.pAV = pAV;
                    AssetClass = (rootClass.loadermanager.getClass(strSkinLinkage) as Class);
                    if (AssetClass != null){
                        if (headMC.head.mcScar.numChildren > 0){
                            headMC.head.mcScar.removeChildAt(0);
                        };
                        headMC.head.mcScar.addChild(new (AssetClass)());
                        headMC.head.mcScar.visible = true;
                    }
                    else {
                        trace("Could not resolve Scar definition.");
                    };
                    scarMC.scaleX = (scarMC.scaleY = scarSize);
                    scarMC.x = calculateX(scarMC);
                    scarMC.y = calculateY(scarMC);
                }
                catch(e:Error) {
                };
            };
        }
        public function loadPowerUpItem(){
            var iMC:MovieClip;
            var AssetClass:*;
            isLoading = false;
            iMC = new MovieClip();
            itemDisplay.addChild(iMC);
            AssetClass = (rootClass.loadermanager.getClass("iipower") as Class);
            iMC.addChild(new (AssetClass)());
            iMC.scaleX = (iMC.scaleY = 3);
            iMC.x = calculateX(iMC);
            iMC.y = calculateY(iMC);
        }
        public function loadMask(sFile, sLink):void{
            trace("pMC.loadMask >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/mask/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadMaskComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function loadDefaultHead(mc:MovieClip){
            var AssetClass:Class;
            var strGender:*;
            var addedMC:MovieClip;
            trace("Load DefaultHead");
            strGender = rootClass.world.myAvatar.objData.strGender;
            AssetClass = (rootClass.loadermanager.getClass("prevHead") as Class);
            mc.addChild(new (AssetClass)());
            addedMC = (mc.getChildAt(0) as MovieClip);
            addedMC.backhair.visible = false;
            if (strGender == "F"){
                AssetClass = (rootClass.loadermanager.getClass(("DefaultHead" + strGender)) as Class);
                addedMC.head.face.removeChildAt(0);
                addedMC.head.face.addChild(new (AssetClass)());
                AssetClass = (rootClass.loadermanager.getClass("EYES1aF") as Class);
                addedMC.head.mcEyes.removeChildAt(0);
                addedMC.head.mcEyes.addChild(new (AssetClass)());
                addedMC.head.mcMask.visible = false;
                addedMC.head.mcHair.visible = false;
                addedMC.head.mcScar.visible = false;
                addedMC.head.mcHelm.visible = false;
            };
        }
        public function onLoadHouseComplete(e:Event):void{
            var link:String;
            var houseMC:MovieClip;
            var AssetClass:Class;
            var e:Event = e;
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    link = item.sLink;
                    houseMC = new MovieClip();
                    try {
                        AssetClass = (rootClass.loadermanager.getClass(link) as Class);
                        itemDisplay.addChild(houseMC);
                        houseMC.addChild(new (AssetClass)());
                        houseMC.x = calculateX(houseMC);
                        houseMC.y = calculateY(houseMC);
                    }
                    catch(err:Error) {
                    };
                }
                catch(e:Error) {
                };
            };
        }
        public function loadItem(){
            var iMC:MovieClip;
            var AssetClass:*;
            isLoading = false;
            iMC = new MovieClip();
            itemDisplay.addChild(iMC);
            AssetClass = (rootClass.loadermanager.getClass("iiitem") as Class);
            iMC.addChild(new (AssetClass)());
            iMC.scaleX = (iMC.scaleY = 3);
            iMC.x = calculateX(iMC);
            iMC.y = calculateY(iMC);
        }
        public function onLoadWallComplete(e:Event):void{
            var link:String;
            var wallMC:MovieClip;
            var AssetClass:Class;
            var e:Event = e;
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    link = item.sLink;
                    wallMC = new MovieClip();
                    try {
                        AssetClass = (rootClass.loadermanager.getClass(link) as Class);
                        itemDisplay.addChild(wallMC);
                        wallMC.addChild(new (AssetClass)());
                        wallMC.scaleX = (wallMC.scaleY = calculateScale(wallMC));
                        wallMC.x = calculateX(wallMC);
                        wallMC.y = calculateY(wallMC);
                    }
                    catch(err:Error) {
                    };
                }
                catch(e:Error) {
                };
            };
        }
        public function onLoadCapeComplete(e:Event):void{
            var strSkinLinkage:String;
            var capeSize:Number;
            var capeMC:MovieClip;
            var AssetClass:Class;
            var e:Event = e;
            trace("pMC.loadCapeComplete >");
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    strSkinLinkage = item.sLink;
                    capeSize = 0.5;
                    capeMC = new MovieClip();
                    try {
                        itemDisplay.addChild(capeMC);
                        AssetClass = (rootClass.loadermanager.getClass(strSkinLinkage) as Class);
                        capeMC.addChild(new (AssetClass)());
                        capeMC.scaleX = (capeMC.scaleY = capeSize);
                        capeMC.x = calculateX(capeMC);
                        capeMC.y = calculateY(capeMC);
                    }
                    catch(e:Error) {
                        trace("Cape definition could not be resolved!");
                    };
                }
                catch(e:Error) {
                };
            };
        }
        public function onLoadHeadComplete(e:Event):void{
            var strSkinLinkage:String;
            var strGender:* = undefined;
            var helmMC:MovieClip;
            var helmSize:Number;
            var AssetClass:Class;
            var e:Event = e;
            trace("pMC.onLoadHeadComplete >");
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    strSkinLinkage = item.sLink;
                    strGender = rootClass.world.myAvatar.objData.strGender;
                    helmMC = new MovieClip();
                    helmSize = 0.45;
                    itemDisplay.addChild(helmMC);
                    AssetClass = (rootClass.loadermanager.getClass(strSkinLinkage) as Class);
                    if (AssetClass == null){
                        AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + strGender)) as Class);
                    };
                    if (AssetClass != null){
                        helmMC.addChild(new (AssetClass)());
                        helmMC.scaleX = (helmMC.scaleY = helmSize);
                        helmMC.x = calculateX(helmMC);
                        helmMC.y = calculateY(helmMC);
                    }
                    else {
                        trace("Could not resolve Helm definition.");
                    };
                }
                catch(e:Error) {
                };
            };
        }
        public function loadHelm(sFile, sLink):void{
            trace("pMC.loadHelm >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/helm/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadHelmComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function onLoadHairComplete(e:Event):void{
            var hairSize:* = undefined;
            var strSkinLinkage:String;
            var hairMC:MovieClip;
            var headMC:MovieClip;
            var strGender:* = undefined;
            var AssetClass:Class;
            var AssetClass2:Class;
            var e:Event = e;
            trace("pMC.onLoadHairComplete >");
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    hairSize = 1.8;
                    strSkinLinkage = item.sLink;
                    hairMC = new MovieClip();
                    strGender = rootClass.world.myAvatar.objData.strGender;
                    itemDisplay.addChild(hairMC);
                    loadDefaultHead(hairMC);
                    headMC = (hairMC.getChildAt(0) as MovieClip);
                    headMC.pAV = pAV;
                    AssetClass = (rootClass.loadermanager.getClass(strSkinLinkage) as Class);
                    if (AssetClass == null){
                        AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + strGender)) as Class);
                    };
                    AssetClass2 = (rootClass.loadermanager.getClass((strSkinLinkage + "Back")) as Class);
                    if (AssetClass2 == null){
                        AssetClass2 = (rootClass.loadermanager.getClass(((strSkinLinkage + "Back") + strGender)) as Class);
                    };
                    if (AssetClass != null){
                        headMC.head.mcHair.removeChildAt(0);
                        headMC.head.mcHair.addChild(new (AssetClass)());
                        headMC.head.mcHair.visible = true;
                        if (AssetClass2 != null){
                            headMC.backhair.removeChildAt(0);
                            headMC.backhair.visible = true;
                            headMC.backhair.addChild(new (AssetClass2)());
                        };
                    }
                    else {
                        trace("Could not resolve Hair definition.");
                    };
                    hairMC.scaleX = (hairMC.scaleY = hairSize);
                    hairMC.x = calculateX(hairMC);
                    hairMC.y = calculateY(hairMC);
                }
                catch(e:Error) {
                };
            };
        }
        public function onLoadGlovesComplete(e:Event):void{
            var strSkinLinkage:String;
            var gloveSize:Number;
            var gloveFront:* = undefined;
            var gloveBack:* = undefined;
            var gloveMC:MovieClip;
            var AssetClass:Class;
            var e:Event = e;
            trace("pMC.loadGlovesComplete >");
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            }
            else {
                try {
                    clearLoader();
                    strSkinLinkage = item.sLink;
                    gloveSize = 0.7;
                    gloveMC = new MovieClip();
                    try {
                        itemDisplay.addChild(gloveMC);
                        AssetClass = (rootClass.loadermanager.getClass((strSkinLinkage + "Back")) as Class);
                        gloveBack = gloveMC.addChild(new (AssetClass)());
                        gloveBack.x = 80;
                        AssetClass = (rootClass.loadermanager.getClass(strSkinLinkage) as Class);
                        gloveFront = gloveMC.addChild(new (AssetClass)());
                        gloveMC.scaleX = gloveSize;
                        gloveMC.scaleY = gloveSize;
                        gloveMC.x = calculateX(gloveMC);
                        gloveMC.y = calculateY(gloveMC);
                        gloveMC.rotation = -35;
                    }
                    catch(e:Error) {
                    };
                }
                catch(e:Error) {
                };
            };
        }
        public function onError(evt:IOErrorEvent){
            trace(("Error Handler" + evt));
            isLoading = false;
            if (item.sLink != curItem){
                showItemImage(item);
            };
        }
        public function onLoadAvatarHairComplete(e:Event):void{
            var strGender:*;
            var AssetClass:Class;
            var AssetClass2:Class;
            trace((mcChar + "-pMC.onLoadAvatarHairComplete >"));
            if (mcChar != null){
                clearLoader();
                strGender = pAV.objData.strGender;
                trace((strGender + "Str Gender"));
                trace((pAV.objData.eqp + " Up to eqp"));
                trace((pAV.objData.eqp.ha + " Up to Hair"));
                if (pAV.objData.eqp.ha == null){
                    AssetClass = (rootClass.loadermanager.getClass("BaldHair") as Class);
                }
                else {
                    AssetClass = (rootClass.loadermanager.getClass(pAV.objData.eqp.ha.sLink) as Class);
                    if (AssetClass == null){
                        AssetClass = (rootClass.loadermanager.getClass((pAV.objData.eqp.ha.sLink + strGender)) as Class);
                    };
                };
                if (AssetClass != null){
                    mcChar.head.mcHair.removeChildAt(0);
                    mcChar.head.mcHair.addChild(new (AssetClass)());
                    mcChar.head.mcHair.visible = true;
                };
                if (pAV.objData.eqp.ha != null){
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
                else {
                    mcChar.backhair.visible = false;
                };
            };
        }
        public function calculateScale(mc:MovieClip):Number{
            var maxHeight:*;
            var maxWidth:*;
            var scaleXPct:*;
            var scaleYPct:*;
            maxHeight = 165;
            maxWidth = 165;
            if ((((mc.width <= maxWidth)) && ((mc.height <= maxHeight)))){
                return (1);
            };
            scaleXPct = (maxWidth / mc.width);
            scaleYPct = (maxHeight / mc.height);
            trace((((((((scaleXPct + ":") + scaleYPct) + ":") + maxWidth) + ":") + maxHeight) + "-xpct,ypct,w,h"));
            return ((((scaleXPct)<scaleYPct) ? scaleXPct : scaleYPct));
        }
        public function showItemImage(it:Object):void{
            item = it;
            if ((((curItem == null)) || (((!((curItem == item.sLink))) && (!(isLoading)))))){
                isLoading = true;
                if (itemDisplay.numChildren > 0){
                    itemDisplay.removeChildAt(0);
                };
                clearLoader();
                curItem = item.sLink;
                switch (item.sType){
                    case "Head":
                        trace("Call Head-------------------");
                        loadHead(item.sFile, item.sLink);
                        break;
                    case "Helm":
                        trace("Call Helm-------------------");
                        loadHelm(item.sFile, item.sLink);
                        break;
                    case "Gloves":
                        trace("Call Gloves-------------------");
                        loadGloves(item.sFile, item.sLink);
                        break;
                    case "Hair":
                        trace("Call Hair-------------------");
                        loadHair(item.sFile, item.sLink);
                        break;
                    case "Scar":
                        trace("Call Scar-------------------");
                        loadScar(item.sFile, item.sLink);
                        break;
                    case "Cape":
                        trace("Call Cape-------------------");
                        loadCape(item.sFile, item.sLink);
                        break;
                    case "Mask":
                        trace("Call Mask-------------------");
                        loadMask(item.sFile, item.sLink);
                        break;
                    case "Armor":
                        trace("Call Armor-------------------");
                        loadArmor(item.sFile, item.sLink);
                        break;
                    case "Gun":
                    case "Axe":
                    case "Sword":
                    case "Mace":
                    case "Dagger":
                    case "Polearm":
                    case "Staff":
                    case "Wand":
                        trace("Call Weapon-------------------");
                        loadWeapon(item.sFile, item.sLink);
                        break;
                    case "QuestItem":
                        loadQuestItem();
                        break;
                    case "Item":
                        loadItem();
                        break;
                    case "Power":
                        loadPowerUpItem();
                        break;
                    case "House":
                        loadHouse(item.sLink, item.sLink);
                        break;
                    case "Floor Item":
                        loadFloor(item.sFile, item.sLink);
                        break;
                    case "Wall Item":
                        loadWall(item.sFile, item.sLink);
                        break;
                };
            };
        }
        public function calculateY(obj:Object):Number{
            var itemY:Number;
            var myCenter:*;
            var rect:Rectangle;
            var objCenter:*;
            var alignY:Number;
            myCenter = ((bg.height / 2) - (bg.height / 16));
            rect = obj.getBounds(itemDisplay);
            objCenter = (obj.height / 2);
            alignY = ((rect.y * -1) - objCenter);
            itemY = (myCenter + alignY);
            return (itemY);
        }
        public function calculateX(obj:Object):Number{
            var itemX:Number;
            var myCenter:*;
            var rect:Rectangle;
            var objCenter:*;
            var alignX:Number;
            myCenter = ((bg.width + bg.x) / 2);
            rect = obj.getBounds(itemDisplay);
            objCenter = (obj.width / 2);
            alignX = ((rect.x * -1) - objCenter);
            itemX = (myCenter + alignX);
            return (itemX);
        }
        public function loadGloves(sFile, sLink):void{
            trace("pMC.loadGloves >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/glove/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadGlovesComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function loadWall(sFile, sLink):void{
            trace("pMC.loadHouse >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/house/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadWallComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function loadHouse(sFile, sLink):void{
            trace("pMC.loadHouse >");
            ldr.load(new URLRequest((((rootClass.sFilePath + "maps/houses/") + sFile) + ".swf")), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadHouseComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function loadHead(sFile, sLink):void{
            trace("pMC.loadHead >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/head/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadHeadComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        public function loadHair(sFile, sLink):void{
            trace("pMC.loadHair >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/hair/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadHairComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }
        private function xClick(e:MouseEvent){
            this.visible = false;
        }
        public function loadArmor(sFile, sLink):void{
            trace("pMC.loadArmor >");
            ldr.load(new URLRequest(((rootClass.sFilePath + "items/armor/") + sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadArmorComplete);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        }

    }
}//package 

