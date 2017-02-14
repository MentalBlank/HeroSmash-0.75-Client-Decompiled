// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Inventory

package {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class Inventory extends MovieClip {

        public var popupSC:MovieClip;
        public var mcItemList:ItemList;
        public var strGold:TextField;
        public var txtBackPack:TextField;
        public var mcFame:MovieClip;
        public var mcCoin:MovieClip;
        public var popupFame:MovieClip;
        public var mcPreview:Preview;
        public var strCoins:TextField;
        public var bg1:MovieClip;
        public var btnAddBagSpace:MovieClip;
        public var btnHelp:MovieClip;
        var rootClass:MovieClip;
        var arrItems:Array;

        public function Inventory(){
            rootClass = MovieClip(parent.parent.parent);
            super();
            popupFame.visible = false;
            popupSC.visible = false;
            mcCoin.addEventListener(MouseEvent.MOUSE_OVER, onMOver, false, 0, true);
            mcCoin.addEventListener(MouseEvent.MOUSE_OUT, onMOut, false, 0, true);
            mcFame.addEventListener(MouseEvent.MOUSE_OVER, onMOver, false, 0, true);
            mcFame.addEventListener(MouseEvent.MOUSE_OUT, onMOut, false, 0, true);
            bg1.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
            mcPreview.btnAction.addEventListener(MouseEvent.CLICK, onEquipClick, false, 0, true);
            mcPreview.btnDelete.addEventListener(MouseEvent.CLICK, onDeleteClick, false, 0, true);
            btnAddBagSpace.addEventListener(MouseEvent.CLICK, onAddSpaceClick, false, 0, true);
            btnHelp.addEventListener(MouseEvent.CLICK, onHelpClick, false, 0, true);
            refreshList();
            updateGoldCoin();
        }
        public function updateGoldCoin():void{
            strGold.text = rootClass.world.myAvatar.objData.intGold;
            strCoins.text = rootClass.world.myAvatar.objData.intCoins;
            txtBackPack.text = ((rootClass.world.items.length + "/") + rootClass.world.myAvatar.objData.iBagSlots);
        }
        function onAddSpaceClick(e:Event):void{
            rootClass.showAddSpaceInterface();
            onCloseClick(null);
        }
        public function refreshDetail():void{
            if (selectedItem == null){
                mcPreview.visible = false;
            }
            else {
                if (selectedItem.bEquip == 1){
                    mcPreview.txtAction.text = "Unequip";
                }
                else {
                    mcPreview.txtAction.text = "Equip";
                };
                mcPreview.strInfo.htmlText = rootClass.getItemInfoString(selectedItem);
                mcPreview.strInfo.y = (mcPreview.strCost.y - mcPreview.strInfo.textHeight);
                mcPreview.mcCoin.visible = (selectedItem.bCoins == 1);
                mcPreview.mcUpgrade.visible = (selectedItem.bUpg == 1);
                if (!mcPreview.visible){
                    mcPreview.visible = true;
                };
                mcPreview.showItemImage(mcItemList.selectedItem);
                updateCost();
            };
        }
        public function updateCost():void{
            var fontColor:*;
            var strCost:String;
            fontColor = "#40CAE5";
            strCost = "";
            if (selectedItem.bCoins == 0){
                if (rootClass.world.myAvatar.objData.intGold > 2000000){
                    strCost = (("<font size='14' color='" + fontColor) + "'><b>0 Gold</b></font>");
                }
                else {
                    strCost = (((("<font size='14' color='" + fontColor) + "'><b>") + Math.ceil((selectedItem.iCost / 4))) + " Fame</b></font>");
                };
            }
            else {
                if (selectedItem.iHrs < 24){
                    strCost = (((("<font size='14' color='" + fontColor) + "'><b>") + Math.ceil(((selectedItem.iCost * 9) / 10))) + " SmashCoins</b></font>");
                }
                else {
                    strCost = (((("<font size='14' color='" + fontColor) + "'><b>") + Math.ceil((selectedItem.iCost / 4))) + " SmashCoins</b></font>");
                };
            };
            mcPreview.strCost.htmlText = strCost;
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
        function refreshList():void{
            mcItemList.inventorySlot = rootClass.world.myAvatar.objData.iBagSlots;
            mcItemList.init(rootClass.world.items);
        }
        public function onDeleteClick(evt:Event):void{
            var modal:*;
            var modalO:*;
            rootClass.mixer.playSound("Click");
            if (selectedItem != null){
                if (mcItemList.selectedItem.bEquip == 1){
                    rootClass.MsgBox.notify("Item is currently equipped!");
                }
                else {
                    modal = new ModalMC();
                    modalO = {};
                    if (mcItemList.selectedItem.sES == "ar"){
                        modalO.strBody = (("Are you sure you want to delete '" + mcItemList.selectedItem.sName) + "' and the rank associated with it?");
                    }
                    else {
                        modalO.strBody = (("Are you sure you want to delete '" + mcItemList.selectedItem.sName) + "'?");
                    };
                    modalO.params = {};
                    modalO.callback = deleteRequest;
                    rootClass.ui.ModalStack.addChild(modal);
                    modal.init(modalO);
                };
            };
        }
        public function get selectedItem():Object{
            return (mcItemList.selectedItem);
        }
        public function deleteRequest(params):void{
            if (params.accept){
                rootClass.world.sendRemoveItemRequest(mcItemList.selectedItem);
            };
        }
        public function onEquipClick(evt:Event){
            var uoLeaf:*;
            rootClass.mixer.playSound("Click");
            uoLeaf = rootClass.world.getUoLeafById(rootClass.world.myAvatar.uid);
            if (selectedItem.sES == "None"){
                rootClass.MsgBox.notify("Item cannot be equipped!");
            }
            else {
                if (uoLeaf.intState != 1){
                    rootClass.MsgBox.notify("Action cannot be performed during combat!");
                }
                else {
                    if (mcItemList.selectedItem.bEquip == 1){
                        if (mcItemList.selectedItem.sType.toLowerCase() != "item"){
                            rootClass.world.sendUnequipItemRequest(mcItemList.selectedItem);
                        }
                        else {
                            rootClass.world.unequipUseableItem(mcItemList.selectedItem);
                        };
                    }
                    else {
                        if ((((mcItemList.selectedItem.sType == "Power")) && ((rootClass.world.getEquippedPowerCount() >= 5)))){
                            rootClass.MsgBox.notify("Maximum number of powers already equipped!");
                        }
                        else {
                            if ((((mcItemList.selectedItem.bUpg == 1)) && (!(rootClass.world.myAvatar.isUpgraded())))){
                                rootClass.showUpgradeWindow();
                            }
                            else {
                                if (int(mcItemList.selectedItem.iLvl) > int(rootClass.world.myAvatar.objData.intLevel)){
                                    rootClass.MsgBox.notify("Level requirement not met!");
                                }
                                else {
                                    if (mcItemList.selectedItem.sType.toLowerCase() != "item"){
                                        rootClass.world.sendEquipItemRequest(mcItemList.selectedItem);
                                    }
                                    else {
                                        rootClass.world.equipUseableItem(mcItemList.selectedItem);
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }
        public function toggleInventory():void{
            this.visible = !(this.visible);
        }
        private function onHelpClick(evt:MouseEvent){
            rootClass.world.loadMovieFront("interface/goldACMembers.swf");
            onCloseClick(null);
        }
        function onCloseClick(evt:Event){
            bg1.btnClose.removeEventListener(MouseEvent.CLICK, onCloseClick);
            mcPreview.btnAction.removeEventListener(MouseEvent.CLICK, onEquipClick);
            mcPreview.btnDelete.removeEventListener(MouseEvent.CLICK, onDeleteClick);
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

    }
}//package 

