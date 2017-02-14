﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.adobe.serialization.json.JSONEncoder

package com.adobe.serialization.json{
    import flash.utils.describeType;

    public class JSONEncoder {

        private var jsonString:String;

        public function JSONEncoder(value){
            jsonString = convertToString(value);
        }
        private function arrayToString(a:Array):String{
            var s:String;
            var i:int;
            s = "";
            i = 0;
            while (i < a.length) {
                if (s.length > 0){
                    s = (s + ",");
                };
                s = (s + convertToString(a[i]));
                i++;
            };
            return ((("[" + s) + "]"));
        }
        private function convertToString(value):String{
            if ((value is String)){
                return (escapeString((value as String)));
            };
            if ((value is Number)){
                return (((isFinite((value as Number))) ? value.toString() : "null"));
            };
            if ((value is Boolean)){
                return (((value) ? "true" : "false"));
            };
            if ((value is Array)){
                return (arrayToString((value as Array)));
            };
            if ((((value is Object)) && (!((value == null))))){
                return (objectToString(value));
            };
            return ("null");
        }
        private function escapeString(str:String):String{
            var s:String;
            var ch:String;
            var len:Number;
            var i:int;
            var hexCode:String;
            var zeroPad:String;
            s = "";
            len = str.length;
            i = 0;
            while (i < len) {
                ch = str.charAt(i);
                switch (ch){
                    case '"':
                        s = (s + '\\"');
                        break;
                    case "\\":
                        s = (s + "\\\\");
                        break;
                    case "\b":
                        s = (s + "\\b");
                        break;
                    case "\f":
                        s = (s + "\\f");
                        break;
                    case "\n":
                        s = (s + "\\n");
                        break;
                    case "\r":
                        s = (s + "\\r");
                        break;
                    case "\t":
                        s = (s + "\\t");
                        break;
                    default:
                        if (ch < " "){
                            hexCode = ch.charCodeAt(0).toString(16);
                            zeroPad = (((hexCode.length == 2)) ? "00" : "000");
                            s = (s + (("\\u" + zeroPad) + hexCode));
                        }
                        else {
                            s = (s + ch);
                        };
                };
                i++;
            };
            return ((('"' + s) + '"'));
        }
        private function objectToString(o:Object):String{
            var s:String;
            var classInfo:XML;
            var value:Object;
            var key:String;
            var v:XML;
            var o:Object = o;
            s = "";
            classInfo = describeType(o);
            if (classInfo.@name.toString() == "Object"){
                for (key in o) {
                    value = o[key];
                    if ((value is Function)){
                    }
                    else {
                        if (s.length > 0){
                            s = (s + ",");
                        };
                        s = (s + ((escapeString(key) + ":") + convertToString(value)));
                    };
                };
            }
            else {
                for each (v in classInfo..*.(((name() == "variable")) || ((name() == "accessor")))) {
                    if (s.length > 0){
                        s = (s + ",");
                    };
                    s = (s + ((escapeString(v.@name.toString()) + ":") + convertToString(o[v.@name])));
                };
            };
            return ((("{" + s) + "}"));
        }
        public function getString():String{
            return (jsonString);
        }

    }
}//package com.adobe.serialization.json

