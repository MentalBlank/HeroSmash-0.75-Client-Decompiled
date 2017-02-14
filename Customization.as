// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Customization

package {
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import fl.controls.ColorPicker;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import fl.events.ColorPickerEvent;

    public class Customization extends MovieClip {

        public var btnEyesLeft:SimpleButton;
        public var btnClose:SimpleButton;
        public var btnNoseRight:SimpleButton;
        private var arrSkinHairColors;
        public var cpAccessory:ColorPicker;
        public var btnMouthRight:SimpleButton;
        public var submit:SimpleButton;
        public var cpTrim:ColorPicker;
        private var backData:Object;
        public var bg:MovieClip;
        private var arrColors;
        public var cpEye:ColorPicker;
        public var btnMouthLeft:SimpleButton;
        private var arrAccessoryColors;
        public var cpSkin:ColorPicker;
        private var arrEyeColors;
        private var rootClass:MovieClip;
        public var cpBase:ColorPicker;
        private var avt:Avatar;
        public var btnEyesRight:SimpleButton;
        public var cpHair:ColorPicker;
        public var btnNoseLeft:SimpleButton;

        public function Customization():void{
            arrSkinHairColors = [65793, 0xFFFFFF, 12767958, 9673634, 8556972, 5398908, 4478310, 2500663, 3422539, 4541285, 6182021, 3618922, 2102889, 8476790, 9319279, 4928583, 14188924, 2436920, 6593232, 4817850, 3366536, 3559294, 1977414, 9622526, 10074585, 13557484, 5220272, 7715142, 5674563, 5668932, 4808462, 4020272, 3560001, 4421735, 5405282, 3433818, 3033928, 3753268, 14019773, 10540396, 0xFFCC00, 14922046, 11509315, 11040791, 13597462, 14515004, 10900510, 16777164, 16777113, 16509316, 13026702, 8488053, 0x990000, 0x660000, 4786437, 15230291, 13382701, 12927265, 10234126, 10053171, 7753511, 9322016, 7746331, 8601921, 6041135, 4465190, 13088131, 9602663, 8218929, 15388042, 14658389, 15982797, 15121555, 14460011, 14121559, 13001261, 3157797, 13092792, 5197887, 7497554, 4008995, 6178103, 8542790, 7027237, 3678742, 5977124, 9265949, 5127967, 10000828, 0xFFFF, 3381657, 26367, 2635172, 91294, 13158, 0xFFFF00, 16777062, 0xFF9900, 0xFF00, 39219, 7065902, 0xFF0000, 11046487, 4536088, 0x993300, 16724940, 16724869, 10432464, 4925009, 0x6600CC];
            arrEyeColors = [65793, 0xFFFFFF, 10000828, 8556972, 5398908, 0xFFFF, 3381657, 10074585, 4817850, 3366536, 3559294, 26367, 2635172, 91294, 2500663, 1977414, 0xFFFF00, 16777062, 14922046, 11040791, 0xFF9900, 0xFFCC00, 0xFF00, 39219, 7065902, 5674563, 4808462, 3753268, 0xFF0000, 0x990000, 8601921, 6041135, 4465190, 11046487, 4536088, 10053171, 7753511, 9322016, 7746331, 0x993300, 0x660000, 16724940, 10432464, 4925009, 0x6600CC];
            arrColors = [65793, 0xFFFFFF, 12767958, 9673634, 8556972, 5398908, 4478310, 2500663, 3422539, 4541285, 6182021, 3618922, 2102889, 8476790, 9319279, 4928583, 14188924, 2436920, 6593232, 4817850, 3366536, 3559294, 1977414, 9622526, 10074585, 13557484, 5220272, 7715142, 5674563, 5668932, 4808462, 4020272, 3560001, 4421735, 5405282, 3433818, 3033928, 3753268, 14019773, 10540396, 0xFFCC00, 14922046, 11509315, 11040791, 13597462, 14515004, 10900510, 16777164, 16777113, 16509316, 13026702, 8488053, 0x990000, 0x660000, 4786437, 15230291, 13382701, 12927265, 10234126, 10053171, 7753511, 9322016, 7746331, 8601921, 6041135, 4465190, 13088131, 9602663, 8218929, 15388042, 14658389, 15982797, 15121555, 14460011, 14121559, 13001261, 3157797, 13092792, 5197887, 7497554, 4008995, 6178103, 8542790, 7027237, 3678742, 5977124, 9265949, 5127967, 0x1A1A1A, 6165524];
            arrAccessoryColors = [65793, 0xFFFFFF, 12767958, 9673634, 8556972, 5398908, 4478310, 2500663, 3422539, 4541285, 6182021, 3618922, 2102889, 8476790, 9319279, 4928583, 14188924, 2436920, 6593232, 4817850, 3366536, 3559294, 1977414, 9622526, 10074585, 13557484, 5220272, 7715142, 5674563, 5668932, 4808462, 4020272, 3560001, 4421735, 5405282, 3433818, 3033928, 3753268, 14019773, 10540396, 0xFFCC00, 14922046, 11509315, 11040791, 13597462, 14515004, 10900510, 16777164, 16777113, 16509316, 13026702, 8488053, 0x990000, 0x660000, 4786437, 15230291, 13382701, 12927265, 10234126, 10053171, 7753511, 9322016, 7746331, 8601921, 6041135, 4465190, 13088131, 9602663, 8218929, 15388042, 14658389, 15982797, 15121555, 14460011, 14121559, 13001261, 3157797, 13092792, 5197887, 7497554, 4008995, 6178103, 8542790, 7027237, 3678742, 5977124, 9265949, 5127967, 10000828, 0xFFFF, 3381657, 26367, 2635172, 91294, 0xFFFF00, 16777062, 0xFF9900, 0xFF00, 39219, 7065902, 0xFF0000, 11046487, 4536088, 0x993300, 16724940, 10432464, 4925009, 0x6600CC];
            super();
            addFrameScript(19, frame20, 35, frame36);
            rootClass = MovieClip(stage.getChildAt(0));
            avt = rootClass.world.myAvatar;
            backData = {};
            backData.iMouth = avt.objData.iMouth;
            backData.iNose = avt.objData.iNose;
            backData.iEye = avt.objData.iEye;
            backData.intColorSkin = avt.objData.intColorSkin;
            backData.intColorHair = avt.objData.intColorHair;
            backData.intColorEye = avt.objData.intColorEye;
            backData.intColorBase = avt.objData.intColorBase;
            backData.intColorTrim = avt.objData.intColorTrim;
            backData.intColorAccessory = avt.objData.intColorAccessory;
            btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
            submit.addEventListener(MouseEvent.CLICK, onSaveClick, false, 0, true);
            btnMouthLeft.addEventListener(MouseEvent.CLICK, nextMouth, false, 0, true);
            btnMouthRight.addEventListener(MouseEvent.CLICK, nextMouth, false, 0, true);
            btnNoseLeft.addEventListener(MouseEvent.CLICK, nextNose, false, 0, true);
            btnNoseRight.addEventListener(MouseEvent.CLICK, nextNose, false, 0, true);
            btnEyesLeft.addEventListener(MouseEvent.CLICK, nextEyes, false, 0, true);
            btnEyesRight.addEventListener(MouseEvent.CLICK, nextEyes, false, 0, true);
            cpSkin.addEventListener(Event.CHANGE, onColorSelect, false, 0, true);
            cpEye.addEventListener(Event.CHANGE, onColorSelect, false, 0, true);
            cpHair.addEventListener(Event.CHANGE, onColorSelect, false, 0, true);
            cpSkin.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, onItemRollOver, false, 0, true);
            cpEye.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, onItemRollOver, false, 0, true);
            cpHair.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, onItemRollOver, false, 0, true);
            cpSkin.addEventListener(ColorPickerEvent.ITEM_ROLL_OUT, onItemRollOut, false, 0, true);
            cpEye.addEventListener(ColorPickerEvent.ITEM_ROLL_OUT, onItemRollOut, false, 0, true);
            cpHair.addEventListener(ColorPickerEvent.ITEM_ROLL_OUT, onItemRollOut, false, 0, true);
            cpBase.addEventListener(Event.CHANGE, onColorSelect, false, 0, true);
            cpBase.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, onItemRollOver, false, 0, true);
            cpBase.addEventListener(ColorPickerEvent.ITEM_ROLL_OUT, onItemRollOut, false, 0, true);
            cpTrim.addEventListener(Event.CHANGE, onColorSelect, false, 0, true);
            cpTrim.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, onItemRollOver, false, 0, true);
            cpTrim.addEventListener(ColorPickerEvent.ITEM_ROLL_OUT, onItemRollOut, false, 0, true);
            cpAccessory.addEventListener(Event.CHANGE, onColorSelect, false, 0, true);
            cpAccessory.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, onItemRollOver, false, 0, true);
            cpAccessory.addEventListener(ColorPickerEvent.ITEM_ROLL_OUT, onItemRollOut, false, 0, true);
            cpBase.colors = arrColors;
            cpBase.selectedColor = avt.objData.intColorBase;
            cpBase.setStyle("columnCount", 10);
            cpTrim.colors = arrColors;
            cpTrim.selectedColor = avt.objData.intColorTrim;
            cpTrim.setStyle("columnCount", 10);
            cpAccessory.colors = arrAccessoryColors;
            cpAccessory.selectedColor = avt.objData.intColorAccessory;
            cpAccessory.setStyle("columnCount", 10);
            cpSkin.colors = arrSkinHairColors;
            cpSkin.selectedColor = avt.objData.intColorSkin;
            cpSkin.setStyle("columnCount", 10);
            cpHair.colors = arrSkinHairColors;
            cpHair.selectedColor = avt.objData.intColorHair;
            cpHair.setStyle("columnCount", 10);
            cpEye.colors = arrEyeColors;
            cpEye.selectedColor = avt.objData.intColorEye;
            cpEye.setStyle("columnCount", 10);
            __setProp_cpHair_mcCustomizeArmor_Chcptabs_1();
            __setProp_cpBase_mcCustomizeArmor_cptabs_1();
            __setProp_cpTrim_mcCustomizeArmor_cptabs_1();
            __setProp_cpEye_mcCustomizeArmor_Chcptabs_1();
            __setProp_cpAccessory_mcCustomizeArmor_cptabs_1();
            __setProp_cpSkin_mcCustomizeArmor_Chcptabs_1();
        }
        function onSaveClick(evt:Event){
            if (((((((((((((((((!((backData.iEye == avt.objData.iEye))) || (!((backData.iNose == avt.objData.iNose))))) || (!((backData.iMouth == avt.objData.iMouth))))) || (!((backData.intColorSkin == avt.objData.intColorSkin))))) || (!((backData.intColorHair == avt.objData.intColorHair))))) || (!((backData.intColorEye == avt.objData.intColorEye))))) || (!((backData.intColorBase == avt.objData.intColorBase))))) || (!((backData.intColorTrim == avt.objData.intColorTrim))))) || (!((backData.intColorAccessory == avt.objData.intColorAccessory))))){
                rootClass.world.sendCustomizeRequest(avt.objData.iEye, avt.objData.iMouth, avt.objData.iNose, avt.objData.intColorSkin, avt.objData.intColorHair, avt.objData.intColorEye, avt.objData.intColorBase, avt.objData.intColorTrim, avt.objData.intColorAccessory);
            };
            rootClass.mixer.playSound("Click");
            gotoAndPlay("out");
        }
        function nextEyes(e:Event):void{
            var iArrLength:int;
            iArrLength = rootClass["arrEyes"].length;
            if (e.currentTarget.name == "btnEyesRight"){
                avt.objData.iEye = ((avt.objData.iEye + 1) % iArrLength);
            }
            else {
                if (e.currentTarget.name == "btnEyesLeft"){
                    avt.objData.iEye = (((avt.objData.iEye + iArrLength) - 1) % iArrLength);
                };
            };
            avt.pMC.loadEyes();
        }
        function __setProp_cpBase_mcCustomizeArmor_cptabs_1(){
            try {
                cpBase["componentInspectorSetting"] = true;
            }
            catch(e:Error) {
            };
            cpBase.enabled = true;
            cpBase.selectedColor = 0;
            cpBase.showTextField = false;
            cpBase.visible = true;
            try {
                cpBase["componentInspectorSetting"] = false;
            }
            catch(e:Error) {
            };
        }
        function __setProp_cpTrim_mcCustomizeArmor_cptabs_1(){
            try {
                cpTrim["componentInspectorSetting"] = true;
            }
            catch(e:Error) {
            };
            cpTrim.enabled = true;
            cpTrim.selectedColor = 0;
            cpTrim.showTextField = false;
            cpTrim.visible = true;
            try {
                cpTrim["componentInspectorSetting"] = false;
            }
            catch(e:Error) {
            };
        }
        function frame20(){
            stop();
        }
        function nextNose(e:Event):void{
            var iArrLength:int;
            iArrLength = rootClass.arrNose.length;
            if (e.currentTarget.name == "btnNoseRight"){
                avt.objData.iNose = ((avt.objData.iNose + 1) % iArrLength);
            }
            else {
                if (e.currentTarget.name == "btnNoseLeft"){
                    avt.objData.iNose = (((avt.objData.iNose + iArrLength) - 1) % iArrLength);
                };
            };
            avt.pMC.loadNose();
        }
        function __setProp_cpEye_mcCustomizeArmor_Chcptabs_1(){
            try {
                cpEye["componentInspectorSetting"] = true;
            }
            catch(e:Error) {
            };
            cpEye.enabled = true;
            cpEye.selectedColor = 0;
            cpEye.showTextField = false;
            cpEye.visible = true;
            try {
                cpEye["componentInspectorSetting"] = false;
            }
            catch(e:Error) {
            };
        }
        function frame36(){
            MovieClip(parent).gotoAndPlay("init");
        }
        function onItemRollOut(evt:Event):void{
            avt.pMC.updateColor();
        }
        function __setProp_cpHair_mcCustomizeArmor_Chcptabs_1(){
            try {
                cpHair["componentInspectorSetting"] = true;
            }
            catch(e:Error) {
            };
            cpHair.enabled = true;
            cpHair.selectedColor = 0;
            cpHair.showTextField = false;
            cpHair.visible = true;
            try {
                cpHair["componentInspectorSetting"] = false;
            }
            catch(e:Error) {
            };
        }
        function nextMouth(e:Event):void{
            var iArrLength:int;
            iArrLength = rootClass.arrMouth.length;
            if (e.currentTarget.name == "btnMouthRight"){
                avt.objData.iMouth = ((avt.objData.iMouth + 1) % iArrLength);
            }
            else {
                if (e.currentTarget.name == "btnMouthLeft"){
                    avt.objData.iMouth = (((avt.objData.iMouth + iArrLength) - 1) % iArrLength);
                };
            };
            avt.pMC.loadMouth();
        }
        private function onCloseClick(evt:Event){
            avt.objData.iMouth = backData.iMouth;
            avt.objData.iNose = backData.iNose;
            avt.objData.iEye = backData.iEye;
            avt.objData.intColorSkin = backData.intColorSkin;
            avt.objData.intColorHair = backData.intColorHair;
            avt.objData.intColorEye = backData.intColorEye;
            if (((((!((backData.intColorBase == avt.objData.intColorBase))) || (!((backData.intColorTrim == avt.objData.intColorTrim))))) || (!((backData.intColorAccessory == avt.objData.intColorAccessory))))){
                avt.objData.intColorBase = backData.intColorBase;
                avt.objData.intColorTrim = backData.intColorTrim;
                avt.objData.intColorAccessory = backData.intColorAccessory;
            };
            avt.pMC.updateColor();
            rootClass.mixer.playSound("Click");
            gotoAndPlay("out");
        }
        function onItemRollOver(evt:Event):void{
            var objDummy:*;
            objDummy = new Object();
            objDummy.intColorSkin = avt.objData.intColorSkin;
            objDummy.intColorHair = avt.objData.intColorHair;
            objDummy.intColorEye = avt.objData.intColorEye;
            objDummy.intColorBase = avt.objData.intColorBase;
            objDummy.intColorTrim = avt.objData.intColorTrim;
            objDummy.intColorAccessory = avt.objData.intColorAccessory;
            switch (evt.target.name){
                case "cpSkin":
                    objDummy.intColorSkin = evt.target.selectedColor;
                    break;
                case "cpEye":
                    objDummy.intColorEye = evt.target.selectedColor;
                    break;
                case "cpHair":
                    objDummy.intColorHair = evt.target.selectedColor;
                    break;
                case "cpBase":
                    objDummy.intColorBase = evt.target.selectedColor;
                    break;
                case "cpTrim":
                    objDummy.intColorTrim = evt.target.selectedColor;
                    break;
                case "cpAccessory":
                    objDummy.intColorAccessory = evt.target.selectedColor;
                    break;
            };
            avt.pMC.updateColor(objDummy);
        }
        function __setProp_cpSkin_mcCustomizeArmor_Chcptabs_1(){
            try {
                cpSkin["componentInspectorSetting"] = true;
            }
            catch(e:Error) {
            };
            cpSkin.enabled = true;
            cpSkin.selectedColor = 0;
            cpSkin.showTextField = false;
            cpSkin.visible = true;
            try {
                cpSkin["componentInspectorSetting"] = false;
            }
            catch(e:Error) {
            };
        }
        function __setProp_cpAccessory_mcCustomizeArmor_cptabs_1(){
            try {
                cpAccessory["componentInspectorSetting"] = true;
            }
            catch(e:Error) {
            };
            cpAccessory.enabled = true;
            cpAccessory.selectedColor = 0;
            cpAccessory.showTextField = false;
            cpAccessory.visible = true;
            try {
                cpAccessory["componentInspectorSetting"] = false;
            }
            catch(e:Error) {
            };
        }
        function onColorSelect(evt:Event):void{
            switch (evt.target.name){
                case "cpSkin":
                    avt.objData.intColorSkin = evt.target.selectedColor;
                    break;
                case "cpEye":
                    avt.objData.intColorEye = evt.target.selectedColor;
                    break;
                case "cpHair":
                    avt.objData.intColorHair = evt.target.selectedColor;
                    break;
                case "cpBase":
                    avt.objData.intColorBase = evt.target.selectedColor;
                    break;
                case "cpTrim":
                    avt.objData.intColorTrim = evt.target.selectedColor;
                    break;
                case "cpAccessory":
                    avt.objData.intColorAccessory = evt.target.selectedColor;
                    break;
            };
            avt.pMC.updateColor();
        }

    }
}//package 

