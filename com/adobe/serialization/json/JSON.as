// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.adobe.serialization.json.JSON

package com.adobe.serialization.json{
    public class JSON {

        public static function decode(s:String){
            var decoder:JSONDecoder;
            decoder = new JSONDecoder(s);
            return (decoder.getValue());
        }
        public static function encode(o:Object):String{
            var encoder:JSONEncoder;
            encoder = new JSONEncoder(o);
            return (encoder.getString());
        }

    }
}//package com.adobe.serialization.json

