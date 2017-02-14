// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Shop

package {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class Shop extends MovieClip {

        public var popupSC:MovieClip;
        public var mcItemList:ItemList;
        public var tabInv:MovieClip;
        public var tabShop:MovieClip;
        public var strGold:TextField;
        public var txtBackPack:TextField;
        public var mcFame:MovieClip;
        public var mcCoin:MovieClip;
        public var popupFame:MovieClip;
        public var mcPreview:Preview;
        public var mcShopList:ItemList;
        public var strCoins:TextField;
        public var bg1:MovieClip;
        public var btnAddBagSpace:MovieClip;
        public var btnHelp:MovieClip;
        var rootClass;
        public var txtTitle:TextField;
        var bitShop:Boolean = true;

        public function Shop(){
            rootClass = MovieClip(parent.parent.parent);
            bitShop = true;
            super();
            popupFame.visible = false;
            popupSC.visible = false;
            mcCoin.addEventListener(MouseEvent.MOUSE_OVER, onMOver, false, 0, true);
            mcCoin.addEventListener(MouseEvent.MOUSE_OUT, onMOut, false, 0, true);
            mcFame.addEventListener(MouseEvent.MOUSE_OVER, onMOver, false, 0, true);
            mcFame.addEventListener(MouseEvent.MOUSE_OUT, onMOut, false, 0, true);
            mcPreview.btnDelete.visible = false;
            mcPreview.mcIconDelete.visible = false;
            mcPreview.btnAction.addEventListener(MouseEvent.CLICK, onActionClick, false, 0, true);
            btnHelp.addEventListener(MouseEvent.CLICK, onHelpClick, false, 0, true);
            bg1.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
            tabShop.addEventListener(MouseEvent.CLICK, onClickShop, false, 0, true);
            tabInv.addEventListener(MouseEvent.CLICK, onClickInv, false, 0, true);
            mcShopList.inventorySlot = rootClass.world.shopinfo.items.length;
            mcShopList.init(rootClass.world.shopinfo.items);
            mcItemList.inventorySlot = rootClass.world.items.length;
            mcItemList.init(rootClass.world.items);
            updateGoldCoin();
            onClickShop(null);
        }
        public function updateGoldCoin():void{
            txtBackPack.text = ((rootClass.world.items.length + "/") + rootClass.world.myAvatar.objData.iBagSlots);
            strGold.text = rootClass.world.myAvatar.objData.intGold;
            strCoins.text = rootClass.world.myAvatar.objData.intCoins;
        }
        public function refreshDetail():void{
            if (selectedItem == null){
                mcPreview.visible = false;
            }
            else {
                showItemDetail();
            };
        }
        public function buyRequest(params):void{
            if (params.accept){
                rootClass.world.sendBuyItemRequest(params.item);
            };
        }
        public function onPreviewClick(evt:Event){
            if (selectedItem != null){
                mcPreview.visible = !(mcPreview.visible);
                if (mcPreview.visible){
                    refreshDetail();
                };
            };
        }
        public function refreshList():void{
            mcItemList.inventorySlot = rootClass.world.items.length;
            mcItemList.init(rootClass.world.items);
        }
        public function onSellClick():void{
            var modal:*;
            var modalO:*;
            if (mcItemList.selectedItem.bEquip == 1){
                rootClass.MsgBox.notify("Item is currently equipped!");
            }
            else {
                if (mcItemList.selectedItem.bTemp == 1){
                    rootClass.MsgBox.notify("Temp Item cannot be sold!");
                }
                else {
                    if (mcItemList.selectedItem.bTemp == 0){
                        modal = new ModalMC();
                        modalO = {};
                        modalO.strBody = (('Are you sure you want to sell "' + mcItemList.selectedItem.sName) + '"?');
                        modalO.params = {};
                        modalO.params.item = mcItemList.selectedItem;
                        modalO.callback = sellRequest;
                        rootClass.ui.ModalStack.addChild(modal);
                        modal.init(modalO);
                    };
                };
            };
        }
        public function showItemDetail():void{
            var item:Object;
            var fontColor:*;
            var strCost:String;
            fontColor = "#40CAE5";
            strCost = "";
            if (bitShop){
                item = mcShopList.selectedItem;
                if ((((((item.bCoins == 0)) && ((item.iCost > rootClass.world.myAvatar.objData.intGold)))) || ((((item.bCoins == 1)) && ((item.iCost > rootClass.world.myAvatar.objData.intCoins)))))){
                    fontColor = "#CC0000";
                };
                if (item.bCoins == 0){
                    strCost = (((("<font size='14' color='" + fontColor) + "'><b>") + Number(item.iCost)) + " Fame</b></font>");
                }
                else {
                    strCost = (((("<font size='14' color='" + fontColor) + "'><b>") + Number(item.iCost)) + " SmashCoins</b></font>");
                };
                mcPreview.txtAction.text = "Buy";
            }
            else {
                item = mcItemList.selectedItem;
                if (item.bCoins == 0){
                    if (rootClass.world.myAvatar.objData.intGold > 2000000){
                        strCost = (("<font size='14' color='" + fontColor) + "'><b>0 Gold</b></font>");
                    }
                    else {
                        strCost = (((("<font size='14' color='" + fontColor) + "'><b>") + Math.ceil((item.iCost / 4))) + " Fame</b></font>");
                    };
                }
                else {
                    if (item.iHrs < 24){
                        strCost = (((("<font size='14' color='" + fontColor) + "'><b>") + Math.ceil(((item.iCost * 9) / 10))) + " SmashCoins</b></font>");
                    }
                    else {
                        strCost = (((("<font size='14' color='" + fontColor) + "'><b>") + Math.ceil((item.iCost / 4))) + " SmashCoins</b></font>");
                    };
                };
                mcPreview.txtAction.text = "Sell";
            };
            mcPreview.strInfo.htmlText = rootClass.getItemInfoString(item);
            mcPreview.strInfo.y = (mcPreview.strCost.y - mcPreview.strInfo.textHeight);
            mcPreview.mcCoin.visible = (item.bCoins == 1);
            mcPreview.mcUpgrade.visible = (item.bUpg == 1);
            if (!mcPreview.visible){
                mcPreview.visible = true;
            };
            mcPreview.showItemImage(item);
            mcPreview.strCost.htmlText = strCost;
        }
        function onClickInv(evt:Event){
            tabShop.gotoAndPlay("Off");
            tabInv.gotoAndPlay("On");
            mcShopList.visible = false;
            mcItemList.visible = true;
            txtTitle.text = "Inventory";
            bitShop = false;
            refreshDetail();
        }
        public function get selectedItem():Object{
            if (bitShop){
                return (mcShopList.selectedItem);
            };
            return (mcItemList.selectedItem);
        }
        private function onMOut(evt:MouseEvent){
            var e:*;
            var eName:*;
            e = evt.target;
            eName = e.name;
            switch (eName){
                case "mcCoin":
                    popupSC.visible = false;
                    break;
                case "mcFame":
                    popupFame.visible = false;
                    break;
            };
        }
        function onClickShop(evt:Event){
            tabShop.gotoAndPlay("On");
            tabInv.gotoAndPlay("Off");
            mcShopList.visible = true;
            mcItemList.visible = false;
            txtTitle.text = "Shop";
            bitShop = true;
            refreshDetail();
        }
        public function onBuyClick():void{
            var stackSizes:*;
            var modal:*;
            var modalO:*;
            if ((((((rootClass.world.shopinfo.bStaff == 1)) || ((mcShopList.selectedItem.bStaff == 1)))) && ((rootClass.world.myAvatar.objData.intAccessLevel < 40)))){
                rootClass.MsgBox.notify("Test Item.. cannot be purchased yet!");
            }
            else {
                if (((!((rootClass.world.shopinfo.sField == ""))) && (!((rootClass.world.getAchievement(rootClass.world.shopinfo.sField, rootClass.world.shopinfo.iIndex) == 1))))){
                    rootClass.MsgBox.notify("Item requires special requirement!");
                }
                else {
                    if ((((mcShopList.selectedItem.bUpg == 1)) && (!(rootClass.world.myAvatar.isUpgraded())))){
                        rootClass.showUpgradeWindow();
                    }
                    else {
                        if ((((mcShopList.selectedItem.FactionID > 1)) && ((rootClass.world.myAvatar.getRep(mcShopList.selectedItem.FactionID) < mcShopList.selectedItem.iReqRep)))){
                            rootClass.MsgBox.notify("Item Locked: Reputation Requirement not met.");
                        }
                        else {
                            if ((((mcShopList.selectedItem.iClass > 0)) && ((rootClass.world.myAvatar.getCPByID(mcShopList.selectedItem.iClass) < mcShopList.selectedItem.iReqCP)))){
                                rootClass.MsgBox.notify("Item Locked: Class Requirement not met.");
                            }
                            else {
                                if (((((rootClass.world.isItemInInventory(mcShopList.selectedItem.ItemID)) || (rootClass.world.isItemInBank(mcShopList.selectedItem.ItemID)))) && (rootClass.world.isItemStackMaxed(mcShopList.selectedItem.ItemID)))){
                                    stackSizes = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
                                    rootClass.MsgBox.notify((("You cannot have more than " + stackSizes[mcShopList.selectedItem.iStk]) + " of that item!"));
                                }
                                else {
                                    if ((((mcShopList.selectedItem.bCoins == 0)) && ((mcShopList.selectedItem.iCost > rootClass.world.myAvatar.objData.intGold)))){
                                        rootClass.MsgBox.notify("Insufficient Funds!");
                                    }
                                    else {
                                        if ((((mcShopList.selectedItem.bCoins == 1)) && ((mcShopList.selectedItem.iCost > rootClass.world.myAvatar.objData.intCoins)))){
                                            rootClass.showSmashCoinWindow();
                                        }
                                        else {
                                            if (rootClass.world.items.length >= rootClass.world.myAvatar.objData.iBagSlots){
                                                rootClass.MsgBox.notify("Item Inventory Full!");
                                            }
                                            else {
                                                modal = new ModalMC();
                                                modalO = {};
                                                modalO.strBody = (('Are you sure you want to buy "' + mcShopList.selectedItem.sName) + '"?');
                                                modalO.params = {};
                                                modalO.params.item = mcShopList.selectedItem;
                                                modalO.callback = buyRequest;
                                                rootClass.ui.ModalStack.addChild(modal);
                                                modal.init(modalO);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }
        private function onHelpClick(evt:MouseEvent){
            rootClass.world.loadMovieFront("interface/goldACMembers.swf");
            onCloseClick(null);
        }
        function onCloseClick(evt:Event){
            MovieClip(parent).onClose();
        }
        private function onMOver(evt:MouseEvent){
            var e:*;
            var eName:*;
            e = evt.target;
            eName = e.name;
            switch (eName){
                case "mcCoin":
                    popupSC.visible = true;
                    break;
                case "mcFame":
                    popupFame.visible = true;
                    break;
            };
        }
        public function onActionClick(evt:Event){
            if (bitShop){
                onBuyClick();
            }
            else {
                onSellClick();
            };
        }
        public function sellRequest(params):void{
            if (params.accept){
                rootClass.world.sendSellItemRequest(params.item);
            };
        }

    }
}//package 

