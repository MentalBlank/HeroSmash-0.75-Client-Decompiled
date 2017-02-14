// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.adobe.serialization.json.JSONTokenizer

package com.adobe.serialization.json{
    public class JSONTokenizer {

        private var loc:int;
        private var ch:String;
        private var obj:Object;
        private var jsonString:String;

        public function JSONTokenizer(s:String){
            jsonString = s;
            loc = 0;
            nextChar();
        }
        private function skipComments():void{
            if (ch == "/"){
                nextChar();
                switch (ch){
                    case "/":
                        do  {
                            nextChar();
                        } while (((!((ch == "\n"))) && (!((ch == "")))));
                        nextChar();
                        break;
                    case "*":
                        nextChar();
                        while (true) {
                            if (ch == "*"){
                                nextChar();
                                if (ch == "/"){
                                    nextChar();
                                    break;
                                };
                            }
                            else {
                                nextChar();
                            };
                            if (ch == ""){
                                parseError("Multi-line comment not closed");
                            };
                        };
                        break;
                    default:
                        parseError((("Unexpected " + ch) + " encountered (expecting '/' or '*' )"));
                };
            };
        }
        private function isDigit(ch:String):Boolean{
            return ((((ch >= "0")) && ((ch <= "9"))));
        }
        private function readNumber():JSONToken{
            var token:JSONToken;
            var input:String;
            var num:Number;
            token = new JSONToken();
            token.type = JSONTokenType.NUMBER;
            input = "";
            if (ch == "-"){
                input = (input + "-");
                nextChar();
            };
            if (!isDigit(ch)){
                parseError("Expecting a digit");
            };
            if (ch == "0"){
                input = (input + ch);
                nextChar();
                if (isDigit(ch)){
                    parseError("A digit cannot immediately follow 0");
                };
            }
            else {
                while (isDigit(ch)) {
                    input = (input + ch);
                    nextChar();
                };
            };
            if (ch == "."){
                input = (input + ".");
                nextChar();
                if (!isDigit(ch)){
                    parseError("Expecting a digit");
                };
                while (isDigit(ch)) {
                    input = (input + ch);
                    nextChar();
                };
            };
            if ((((ch == "e")) || ((ch == "E")))){
                input = (input + "e");
                nextChar();
                if ((((ch == "+")) || ((ch == "-")))){
                    input = (input + ch);
                    nextChar();
                };
                if (!isDigit(ch)){
                    parseError("Scientific notation number needs exponent value");
                };
                while (isDigit(ch)) {
                    input = (input + ch);
                    nextChar();
                };
            };
            num = Number(input);
            if (((isFinite(num)) && (!(isNaN(num))))){
                token.value = num;
                return (token);
            };
            parseError((("Number " + num) + " is not valid!"));
            return (null);
        }
        private function nextChar():String{
            return ((ch = jsonString.charAt(loc++)));
        }
        public function getNextToken():JSONToken{
            var token:JSONToken;
            var _local2:String;
            var _local3:String;
            var _local4:String;
            token = new JSONToken();
            skipIgnored();
            switch (ch){
                case "{":
                    token.type = JSONTokenType.LEFT_BRACE;
                    token.value = "{";
                    nextChar();
                    break;
                case "}":
                    token.type = JSONTokenType.RIGHT_BRACE;
                    token.value = "}";
                    nextChar();
                    break;
                case "[":
                    token.type = JSONTokenType.LEFT_BRACKET;
                    token.value = "[";
                    nextChar();
                    break;
                case "]":
                    token.type = JSONTokenType.RIGHT_BRACKET;
                    token.value = "]";
                    nextChar();
                    break;
                case ",":
                    token.type = JSONTokenType.COMMA;
                    token.value = ",";
                    nextChar();
                    break;
                case ":":
                    token.type = JSONTokenType.COLON;
                    token.value = ":";
                    nextChar();
                    break;
                case "t":
                    _local2 = ((("t" + nextChar()) + nextChar()) + nextChar());
                    if (_local2 == "true"){
                        token.type = JSONTokenType.TRUE;
                        token.value = true;
                        nextChar();
                    }
                    else {
                        parseError(("Expecting 'true' but found " + _local2));
                    };
                    break;
                case "f":
                    _local3 = (((("f" + nextChar()) + nextChar()) + nextChar()) + nextChar());
                    if (_local3 == "false"){
                        token.type = JSONTokenType.FALSE;
                        token.value = false;
                        nextChar();
                    }
                    else {
                        parseError(("Expecting 'false' but found " + _local3));
                    };
                    break;
                case "n":
                    _local4 = ((("n" + nextChar()) + nextChar()) + nextChar());
                    if (_local4 == "null"){
                        token.type = JSONTokenType.NULL;
                        token.value = null;
                        nextChar();
                    }
                    else {
                        parseError(("Expecting 'null' but found " + _local4));
                    };
                    break;
                case '"':
                    token = readString();
                    break;
                default:
                    if (((isDigit(ch)) || ((ch == "-")))){
                        token = readNumber();
                    }
                    else {
                        if (ch == ""){
                            return (null);
                        };
                        parseError((("Unexpected " + ch) + " encountered"));
                    };
            };
            return (token);
        }
        private function skipWhite():void{
            while (isWhiteSpace(ch)) {
                nextChar();
            };
        }
        private function isWhiteSpace(ch:String):Boolean{
            return ((((((ch == " ")) || ((ch == "\t")))) || ((ch == "\n"))));
        }
        public function parseError(message:String):void{
            throw (new JSONParseError(message, loc, jsonString));
        }
        private function skipIgnored():void{
            skipWhite();
            skipComments();
            skipWhite();
        }
        private function isHexDigit(ch:String):Boolean{
            var uc:String;
            uc = ch.toUpperCase();
            return (((isDigit(ch)) || ((((uc >= "A")) && ((uc <= "F"))))));
        }
        private function readString():JSONToken{
            var token:JSONToken;
            var string:String;
            var _local3:String;
            var i:int;
            token = new JSONToken();
            token.type = JSONTokenType.STRING;
            string = "";
            nextChar();
            while (((!((ch == '"'))) && (!((ch == ""))))) {
                if (ch == "\\"){
                    nextChar();
                    switch (ch){
                        case '"':
                            string = (string + '"');
                            break;
                        case "/":
                            string = (string + "/");
                            break;
                        case "\\":
                            string = (string + "\\");
                            break;
                        case "b":
                            string = (string + "\b");
                            break;
                        case "f":
                            string = (string + "\f");
                            break;
                        case "n":
                            string = (string + "\n");
                            break;
                        case "r":
                            string = (string + "\r");
                            break;
                        case "t":
                            string = (string + "\t");
                            break;
                        case "u":
                            _local3 = "";
                            i = 0;
                            while (i < 4) {
                                if (!isHexDigit(nextChar())){
                                    parseError((" Excepted a hex digit, but found: " + ch));
                                };
                                _local3 = (_local3 + ch);
                                i++;
                            };
                            string = (string + String.fromCharCode(parseInt(_local3, 16)));
                            break;
                        default:
                            string = (string + ("\\" + ch));
                    };
                }
                else {
                    string = (string + ch);
                };
                nextChar();
            };
            if (ch == ""){
                parseError("Unterminated string literal");
            };
            nextChar();
            token.value = string;
            return (token);
        }

    }
}//package com.adobe.serialization.json

