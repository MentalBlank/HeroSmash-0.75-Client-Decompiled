// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//fl.managers.IFocusManagerComponent

package fl.managers{
    public interface IFocusManagerComponent {

        function set focusEnabled(_arg1:Boolean):void;
        function drawFocus(_arg1:Boolean):void;
        function setFocus():void;
        function get focusEnabled():Boolean;
        function get tabEnabled():Boolean;
        function get tabIndex():int;
        function get mouseFocusEnabled():Boolean;

    }
}//package fl.managers

