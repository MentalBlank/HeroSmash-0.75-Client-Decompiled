// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//SmashEvent

package {
    import flash.events.Event;

    public class SmashEvent extends Event {

        public static const CUSTOM:String = "custom";

        public var arg;

        public function SmashEvent(type:String, customArg=null, bubbles:Boolean=false, cancelable:Boolean=false){
            super(type, bubbles, cancelable);
            this.arg = customArg;
        }
        override public function toString():String{
            return (formatToString("SmashEvent", "type", "arg", "bubbles", "cancelable", "eventPhase"));
        }
        override public function clone():Event{
            return (new SmashEvent(type, arg, bubbles, cancelable));
        }

    }
}//package 

