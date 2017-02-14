// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.adobe.serialization.json.JSONToken

package com.adobe.serialization.json{
    public class JSONToken {

        private var _value:Object;
        private var _type:int;

        public function JSONToken(type:int=-1, value:Object=null){
            _type = type;
            _value = value;
        }
        public function set value(v:Object):void{
            _value = v;
        }
        public function get value():Object{
            return (_value);
        }
        public function set type(value:int):void{
            _type = value;
        }
        public function get type():int{
            return (_type);
        }

    }
}//package com.adobe.serialization.json

