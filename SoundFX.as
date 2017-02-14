// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//SoundFX

package {
    import flash.media.SoundTransform;
    import flash.utils.getDefinitionByName;

    public class SoundFX {

        private var arrSounds:Array;
        public var bSoundOn:Boolean = true;
        public var stf:SoundTransform;
        private var sfx:Object;

        public function SoundFX(){
            sfx = {};
            stf = new SoundTransform(0.7, 0);
            bSoundOn = true;
            arrSounds = ["Fire", "Ice", "Radiation", "Mental", "Energy", "Achievement", "Bad", "Click", "ClickBig", "ClickMagic", "Coins", "Evil", "Good", "Heal", "Hit1", "Hit2", "Hit3", "Miss", "VeryGood", "Water", "Wind", "Explosion", "SingleShot", "MultiShot"];
            super();
        }
        public function initSoundFX():void{
            var i:int;
            var AssetClass:Class;
            i = 0;
            while (i < arrSounds.length) {
                AssetClass = (getDefinitionByName(arrSounds[i]) as Class);
                sfx[arrSounds[i]] = new (AssetClass)();
                i++;
            };
        }
        public function soundOff():void{
            bSoundOn = false;
        }
        public function soundOn():void{
            bSoundOn = true;
        }
        public function playSound(strSound:String):void{
            if (((bSoundOn) && (!((sfx[strSound] == null))))){
                sfx[strSound].play(0, 0, stf);
            };
        }

    }
}//package 

