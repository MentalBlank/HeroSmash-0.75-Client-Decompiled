// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//TempInventory

package {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class TempInventory extends MovieClip {

        public var mcItemList:ItemList;
        public var strGold:TextField;
        public var btnEquip:SimpleButton;
        public var strInfo:TextField;
        public var strCoins:TextField;
        public var txtEquip:TextField;
        public var bg1:MovieClip;
        var rootClass:MovieClip;

        public function TempInventory(){
            rootClass = MovieClip(parent.parent.parent);
            super();
            bg1.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
            btnEquip.addEventListener(MouseEvent.CLICK, onEquipClick, false, 0, true);
            txtEquip.mouseEnabled = false;
            init();
        }
        public function init():void{
            mcItemList.init(MovieClip(parent.parent.parent).world.myAvatar.tempitems);
            updateGold();
            refreshDetail();
        }
        public function refreshDetail():void{
            if (selectedItem == null){
                strInfo.htmlText = "Please select an item to view details.";
                btnEquip.visible = (txtEquip.visible = false);
            }
            else {
                if (selectedItem.bEquip == 1){
                    txtEquip.text = "Unequip";
                }
                else {
                    txtEquip.text = "Equip";
                };
                btnEquip.visible = (txtEquip.visible = (selectedItem.sES == "co"));
                strInfo.htmlText = getItemInfoString(selectedItem);
            };
        }
        public function onDeleteClick(evt:Event):void{
        }
        public function get selectedItem():Object{
            return (mcItemList.selectedItem);
        }
        public function toggleInventory():void{
            this.visible = !(this.visible);
        }
        public function onEquipClick(evt:Event){
            var uoLeaf:*;
            rootClass.mixer.playSound("Click");
            uoLeaf = rootClass.world.getUoLeafById(rootClass.world.myAvatar.uid);
            if (uoLeaf.intState != 1){
                rootClass.MsgBox.notify("Action cannot be performed during combat!");
            }
            else {
                if (mcItemList.selectedItem.bEquip == 1){
                    if ((((mcItemList.selectedItem.sES == "Weapon")) || ((mcItemList.selectedItem.sES == "ar")))){
                        rootClass.MsgBox.notify("Selected Item cannot be unequipped!");
                    }
                    else {
                        rootClass.world.sendUnequipItemRequest(mcItemList.selectedItem);
                    };
                }
                else {
                    if ((((mcItemList.selectedItem.bUpg == 1)) && (!(rootClass.world.myAvatar.isUpgraded())))){
                        rootClass.showUpgradeWindow();
                    }
                    else {
                        if (int(mcItemList.selectedItem.iEnhLvl) > int(rootClass.world.myAvatar.objData.intLevel)){
                            rootClass.MsgBox.notify("Level requirement not met!");
                        }
                        else {
                            if (((!((mcItemList.selectedItem.sES == "co"))) && (!((mcItemList.selectedItem.EnhID > 0))))){
                                rootClass.MsgBox.notify("Selected item requires enhancement!");
                            }
                            else {
                                rootClass.world.sendEquipItemRequest(mcItemList.selectedItem);
                            };
                        };
                    };
                };
            };
        }
        function onCloseClick(evt:Event){
            MovieClip(parent).onClose();
        }
        public function updateGold():void{
            strGold.text = MovieClip(parent.parent.parent).world.myAvatar.objData.intGold;
            strCoins.text = MovieClip(parent.parent.parent).world.myAvatar.objData.intCoins;
        }
        function getItemInfoString(obj:Object):String{
            var strItemInfo:*;
            var fontColor:*;
            var iDPS:Number;
            strItemInfo = (("<font size='14'><b>" + obj.sName) + "</b></font><br>");
            fontColor = "#009900";
            strItemInfo = (strItemInfo + ((("<font color='" + fontColor) + "'><b>") + obj.sType));
            if (obj.sES == "Weapon"){
                if (obj.iEnh > 0){
                    strItemInfo = (strItemInfo + ((", Lvl " + obj.iLvl) + "<br>"));
                    iDPS = (((Math.sqrt(obj.iLvl) * 20) * obj.iDPS) / 100);
                    strItemInfo = (strItemInfo + ((((Math.ceil(((iDPS * (100 - Number(obj.iRng))) / 100)) + " - ") + Math.ceil(((iDPS * (100 + Number(obj.iRng))) / 100))) + " ") + obj.sElmt));
                }
                else {
                    strItemInfo = (strItemInfo + " Design");
                };
            };
            strItemInfo = (strItemInfo + (("</b></font><br>" + obj.sDesc) + "<br>"));
            return (strItemInfo);
        }

    }
}//package 

