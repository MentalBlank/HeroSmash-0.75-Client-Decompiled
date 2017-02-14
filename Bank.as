// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Bank

package {
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class Bank extends MovieClip {

        public var btnAddBankSpace:MovieClip;
        public var mcUpgradeBank:MovieClip;
        public var mcItemList:ItemList;
        public var mcCoinBank:MovieClip;
        public var btnToInventory:SimpleButton;
        public var strGold:TextField;
        public var mcCoin:MovieClip;
        public var strCoins:TextField;
        public var strInfo:TextField;
        public var txtBagSlots:TextField;
        public var mcUpgrade:MovieClip;
        public var mcBankList:ItemList;
        public var bg1:MovieClip;
        var rootClass;
        public var btnAddBagSpace:MovieClip;
        public var txtBankSlots:TextField;
        public var btnBank:SimpleButton;
        public var btnFromInventory:SimpleButton;
        public var btnBankAC:SimpleButton;
        public var strNewInfo:TextField;

        public function Bank(){
            rootClass = MovieClip(root);
            super();
            btnAddBagSpace.addEventListener(MouseEvent.CLICK, onAddSpaceClick, false, 0, true);
            btnAddBankSpace.addEventListener(MouseEvent.CLICK, onAddSpaceClick, false, 0, true);
            bg1.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
            btnToInventory.addEventListener(MouseEvent.CLICK, bankToInv, false, 0, true);
            btnFromInventory.addEventListener(MouseEvent.CLICK, bankFromInv, false, 0, true);
            refreshInventory();
            refreshBank();
            updateGold();
            refreshDetail();
        }
        function onAddSpaceClick(e:Event):void{
            rootClass.showAddSpaceInterface();
            onCloseClick(null);
        }
        public function bankFromInv(evt:Event){
            rootClass.mixer.playSound("Click");
            if (mcItemList.selectedItem == null){
                rootClass.MsgBox.notify("Invalid Selection!");
            }
            else {
                if (mcItemList.selectedItem.bTemp == 1){
                    rootClass.MsgBox.notify("Temp Items cannot be stored in the bank!");
                }
                else {
                    if ((((mcItemList.selectedItem.bCoins == 0)) && ((rootClass.world.iBankCount >= rootClass.world.myAvatar.objData.iBankSlots)))){
                        rootClass.MsgBox.notify("Not Enough Bank Space!");
                    }
                    else {
                        if (mcItemList.selectedItem.bEquip == 1){
                            rootClass.MsgBox.notify("Item is currently equipped!");
                        }
                        else {
                            rootClass.world.bankFromInvRequest(mcItemList.selectedItem);
                        };
                    };
                };
            };
        }
        public function refreshDetail():void{
            if (mcItemList.selectedItem == null){
                mcCoin.visible = (mcUpgrade.visible = false);
                strInfo.htmlText = "Please select an item to view details.";
            }
            else {
                strInfo.htmlText = rootClass.getItemInfoString(mcItemList.selectedItem);
                mcCoin.visible = (mcItemList.selectedItem.bCoins == 1);
                mcUpgrade.visible = (mcItemList.selectedItem.bUpg == 1);
            };
            if (mcBankList.selectedItem == null){
                mcCoinBank.visible = (mcUpgradeBank.visible = false);
                strNewInfo.htmlText = "Please select an item to view details.";
            }
            else {
                strNewInfo.htmlText = rootClass.getItemInfoString(mcBankList.selectedItem);
                mcCoinBank.visible = (mcBankList.selectedItem.bCoins == 1);
                mcUpgradeBank.visible = (mcBankList.selectedItem.bUpg == 1);
            };
        }
        public function bankToInv(evt:Event){
            rootClass.mixer.playSound("Click");
            if (mcBankList.selectedItem == null){
                rootClass.MsgBox.notify("Invalid Selection!");
            }
            else {
                if (rootClass.world.items.length >= rootClass.world.myAvatar.objData.iBagSlots){
                    rootClass.MsgBox.notify("Item Inventory Full!");
                }
                else {
                    rootClass.world.bankToInvRequest(mcBankList.selectedItem);
                };
            };
        }
        function onCloseClick(evt:Event){
            MovieClip(parent).onClose();
        }
        public function refreshBank():void{
            txtBankSlots.text = ((rootClass.world.iBankCount + "/") + rootClass.world.myAvatar.objData.iBankSlots);
            mcBankList.inventorySlot = rootClass.world.myAvatar.objData.iBankSlots;
            mcBankList.init(rootClass.world.bank);
        }
        public function refreshInventory():void{
            txtBagSlots.text = ((rootClass.world.items.length + "/") + rootClass.world.myAvatar.objData.iBagSlots);
            mcItemList.inventorySlot = rootClass.world.myAvatar.objData.iBagSlots;
            mcItemList.init(rootClass.world.items);
        }
        public function updateGold():void{
            strGold.text = MovieClip(root).world.myAvatar.objData.intGold;
            strCoins.text = MovieClip(root).world.myAvatar.objData.intCoins;
        }

    }
}//package 

