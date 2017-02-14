// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//ItemList

package {
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
    import flash.geom.Rectangle;

    public class ItemList extends MovieClip {

        public var mcScrollBar:MovieClip;
        public var btnUp:SimpleButton;
        public var btnDown:SimpleButton;
        var strSortBy:String;
        public var mcSort:MovieClip;
        var itemList:Array;
        var sortedList:Array;
        var inventorySlot:Number = 20;
        var intSelected:Number = -1;
        var rootClass:MovieClip;
        var intPlacement:Number = 0;

        public function ItemList(){
            var i:int;
            var mcItem:MovieClip;
            rootClass = MovieClip(Game.root);
            inventorySlot = 20;
            intSelected = -1;
            intPlacement = 0;
            super();
            mcScrollBar.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
            btnUp.addEventListener(MouseEvent.CLICK, onBtnClickHandler, false, 0, true);
            btnDown.addEventListener(MouseEvent.CLICK, onBtnClickHandler, false, 0, true);
            i = 0;
            while (i < 12) {
                mcItem = new InventoryItem();
                mcItem.name = ("mcInventoryItem" + i);
                mcItem.y = (28 * i);
                mcItem.strIndex.text = "";
                mcItem.strName.text = "";
                mcItem.strLevel.text = "";
                mcItem.intIndex = -1;
                this.addChild(mcItem);
                mcItem.addEventListener(MouseEvent.CLICK, onItemSelect, false, 0, true);
                i++;
            };
            mcSort.btnall.addEventListener(MouseEvent.CLICK, onSortClick, false, 0, true);
            mcSort.btnarmor.addEventListener(MouseEvent.CLICK, onSortClick, false, 0, true);
            mcSort.btnweapon.addEventListener(MouseEvent.CLICK, onSortClick, false, 0, true);
            mcSort.btnhelm.addEventListener(MouseEvent.CLICK, onSortClick, false, 0, true);
            mcSort.btnback.addEventListener(MouseEvent.CLICK, onSortClick, false, 0, true);
            mcSort.btngloves.addEventListener(MouseEvent.CLICK, onSortClick, false, 0, true);
            mcSort.btnitem.addEventListener(MouseEvent.CLICK, onSortClick, false, 0, true);
            mcSort.btntemp.addEventListener(MouseEvent.CLICK, onSortClick, false, 0, true);
            mcSort.btnpower.addEventListener(MouseEvent.CLICK, onSortClick, false, 0, true);
            strSortBy = "all";
            mcSort.btnall.gotoAndStop("Off");
        }
        function mouseUpHandler(evt:Event):void{
            mcScrollBar.mcSlider.stopDrag();
            stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        }
        public function getESIcon(sES:String):String{
            switch (sES){
                case "Weapon":
                    return ("iwsword");
                case "he":
                    return ("iihelm");
                case "ba":
                    return ("iicape");
                case "pe":
                    return ("iipet");
                case "ar":
                    return ("iiclass");
                case "co":
                    return ("iwarmor");
                case "ho":
                    return ("ihhouse");
                default:
                    return ("none");
            };
        }
        public function refreshList():void{
            var i:int;
            var objItem:Object;
            var mcItem:MovieClip;
            var fontColor:* = undefined;
            var aw:* = undefined;
            var ah:* = undefined;
            var bw:* = undefined;
            var bh:* = undefined;
            var AssetClass:Class;
            var iconShapeMC:* = undefined;
            var iRank:Number;
            i = 0;
            while (i < 12) {
                objItem = sortedList[(i + intPlacement)];
                mcItem = MovieClip(this.getChildByName(("mcInventoryItem" + i)));
                mcItem.strIndex.text = ((i + intPlacement) + 1);
                if (intSelected == (i + intPlacement)){
                    mcItem.select();
                }
                else {
                    mcItem.reset();
                };
                mcItem.intIndex = (i + intPlacement);
                if (objItem == null){
                    mcItem.clearText();
                    mcItem.unequip();
                    mcItem.mcCoin.visible = false;
                    mcItem.mcMember.visible = false;
                }
                else {
                    if (objItem.sType == "Enhancement"){
                        objItem.sIcon = getESIcon(objItem.sES);
                        objItem.EnhLvl = objItem.iLvl;
                    };
                    fontColor = "#E6E2DB";
                    if (objItem.bUpg == 1){
                        fontColor = "#FFB817";
                    };
                    mcItem.strName.htmlText = (((("<font color='" + fontColor) + "'>") + objItem.sName) + "</font>");
                    mcItem.strLevel.text = ("Lvl " + objItem.iLvl);
                    if (objItem.bEquip == 1){
                        mcItem.equip();
                    }
                    else {
                        mcItem.unequip();
                    };
                    aw = 21;
                    ah = 19;
                    bw = aw;
                    bh = ah;
                    mcItem.icon.removeAllChildren();
                    if (((((!((objItem.sIcon == null))) && (!((objItem.sIcon == ""))))) && (!((objItem.sIcon == "none"))))){
                        try {
                            AssetClass = (getDefinitionByName(objItem.sIcon) as Class);
                            iconShapeMC = mcItem.icon.addChild(new (AssetClass)());
                            bw = iconShapeMC.width;
                            bh = iconShapeMC.height;
                            if (bw > bh){
                                iconShapeMC.scaleX = (iconShapeMC.scaleY = (aw / bw));
                            }
                            else {
                                iconShapeMC.scaleX = (iconShapeMC.scaleY = (ah / bh));
                            };
                            mcItem.icon.visible = true;
                        }
                        catch(err:Error) {
                        };
                    };
                    if ((((objItem.sES == "ar")) && ((objItem.EnhID > 0)))){
                        iRank = rootClass.getRankFromPoints(objItem.iQty);
                        mcItem.strName.htmlText = (mcItem.strName.htmlText + ((" <font color='#999999'>(Rank " + iRank) + ")</font>"));
                    };
                    if (objItem.iStk > 1){
                        mcItem.strName.htmlText = (mcItem.strName.htmlText + ((" <font color='#999999'>x" + objItem.iQty) + "</font>"));
                    };
                    mcItem.mcCoin.visible = (objItem.bCoins == 1);
                    mcItem.mcMember.visible = (objItem.bUpg == 1);
                };
                i = (i + 1);
            };
        }
        public function init(items:Array):void{
            if (items == null){
                return;
            };
            itemList = items;
            mcScrollBar.mcSlider.visible = (intScrollCount > 0);
            sort();
        }
        private function onBtnClickHandler(evt:Event):void{
            if (evt.currentTarget.name == "btnUp"){
                if (intPlacement > 0){
                    intPlacement--;
                };
            }
            else {
                if (evt.currentTarget.name == "btnDown"){
                    if (intPlacement < intScrollCount){
                        intPlacement++;
                    };
                };
            };
            refreshList();
            mcScrollBar.mcSlider.y = Math.ceil(((intPlacement * 203) / intScrollCount));
        }
        private function onItemSelect(e:Event):void{
            var intIndex:int;
            var mcItem:*;
            var mcLastItem:*;
            rootClass.mixer.playSound("Click");
            intIndex = e.currentTarget.intIndex;
            if (intIndex == -1){
                return;
            };
            if (((((intSelected - intPlacement) >= 0)) && (((intSelected - intPlacement) < 12)))){
                mcLastItem = MovieClip(this.getChildByName(("mcInventoryItem" + (intSelected - intPlacement))));
                mcLastItem.reset();
            };
            intSelected = intIndex;
            mcItem = MovieClip(this.getChildByName(("mcInventoryItem" + (intSelected - intPlacement))));
            mcItem.select();
            MovieClip(parent).refreshDetail();
        }
        function get selectedItem():Object{
            if (itemList == null){
                return (null);
            };
            return (sortedList[intSelected]);
        }
        function mouseDownHandler(evt:Event):void{
            mcScrollBar.mcSlider.startDrag(false, new Rectangle(0, 0, 0, 203));
            stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false, 0, true);
        }
        private function onSortClick(e:Event):void{
            mcSort[("btn" + strSortBy)].gotoAndStop("On");
            e.currentTarget.gotoAndStop("Off");
            switch (e.currentTarget.name){
                case "btnall":
                    sortBy("all");
                    break;
                case "btnhelm":
                    sortBy("helm");
                    break;
                case "btnarmor":
                    sortBy("armor");
                    break;
                case "btnback":
                    sortBy("back");
                    break;
                case "btngloves":
                    sortBy("gloves");
                    break;
                case "btnweapon":
                    sortBy("weapon");
                    break;
                case "btnitem":
                    sortBy("item");
                    break;
                case "btnpower":
                    sortBy("power");
                    break;
                case "btntemp":
                    sortBy("temp");
                    break;
            };
        }
        public function reset():void{
            clearSelection();
            refreshList();
        }
        function mouseMoveHandler(evt:Event):void{
            var intNum:int;
            intNum = ((mcScrollBar.mcSlider.y * intScrollCount) / 203);
            if ((((intNum >= 0)) && ((intNum <= intScrollCount)))){
                intPlacement = intNum;
            };
            refreshList();
        }
        public function sortBy(strSort:String):void{
            var arrSort:Array;
            var i:int;
            var objItem:Object;
            strSortBy = strSort.toLowerCase();
            arrSort = new Array();
            i = 0;
            while (i < itemList.length) {
                objItem = itemList[i];
                switch (strSort.toLowerCase()){
                    case "all":
                        arrSort.push(objItem);
                        break;
                    case "armor":
                        if (objItem.sES == "ar"){
                            arrSort.push(objItem);
                        };
                        break;
                    case "weapon":
                        if (objItem.sES == "we"){
                            arrSort.push(objItem);
                        };
                        break;
                    case "helm":
                        if ((((((((objItem.sES == "he")) || ((objItem.sES == "ha")))) || ((objItem.sES == "ma")))) || ((objItem.sES == "sc")))){
                            arrSort.push(objItem);
                        };
                        break;
                    case "back":
                        if (objItem.sES == "ba"){
                            arrSort.push(objItem);
                        };
                        break;
                    case "gloves":
                        if (objItem.sES == "gl"){
                            arrSort.push(objItem);
                        };
                        break;
                    case "item":
                        if (objItem.sES == "None"){
                            arrSort.push(objItem);
                        };
                        break;
                    case "power":
                        if (objItem.sES == "po"){
                            arrSort.push(objItem);
                        };
                        break;
                    case "nonac":
                        if (objItem.bCoins == 0){
                            arrSort.push(objItem);
                        };
                        break;
                    case "ac":
                        if (objItem.bCoins == 1){
                            arrSort.push(objItem);
                        };
                        break;
                    case "temp":
                        arrSort = rootClass.world.tempitems;
                        break;
                    default:
                        arrSort.push(objItem);
                };
                i++;
            };
            inventorySlot = arrSort.length;
            sortedList = arrSort;
            reset();
        }
        public function sort():void{
            sortBy(strSortBy);
        }
        public function isEnhanceable(sES:String):Boolean{
            var arrES:Array;
            arrES = ["Weapon", "he", "ba", "pe", "ar"];
            return ((arrES.indexOf(sES) >= 0));
        }
        public function clearSelection():void{
            var mcItem:*;
            mcItem = MovieClip(this.getChildByName(("mcInventoryItem" + (intSelected - intPlacement))));
            if (mcItem != null){
                mcItem.reset();
            };
            intSelected = -1;
            if (intPlacement != 0){
                intPlacement = 0;
                mcScrollBar.mcSlider.y = 0;
            };
            MovieClip(parent).refreshDetail();
        }
        private function get intScrollCount():Number{
            return ((inventorySlot - 12));
        }

    }
}//package 

