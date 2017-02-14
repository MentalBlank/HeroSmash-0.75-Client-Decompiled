// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//Chat

package {
    import flash.filters.GlowFilter;
    import flash.utils.Timer;
    import flash.net.SharedObject;
    import flash.display.MovieClip;
    import flash.filters.BitmapFilterQuality;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.geom.ColorTransform;
    import flash.text.TextFieldAutoSize;
    import flash.display.DisplayObject;
    import flash.events.TextEvent;
    import flash.text.TextFieldType;
    import flash.text.TextField;
    import flash.geom.Rectangle;
    import flash.filters.BevelFilter;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;
    import flash.text.*;

    public class Chat {

        private var silentMute = 0;
        public var markChars = "~!@#$%^&*()_+-=:\"<>?,.;'\\";
        public var mute;
        private var BlackGlow:GlowFilter;
        private var t1Shorty:int = -148;
        private var lineLimit:int = 100;
        public var myMsgsI:int = 0;
        public var illegalStrings;
        public var panelIndex:int = 0;
        public var windowTimer:Timer;
        private var t1Tally:int = -378;
        private var tfHeight:int = 141;
        private var BlueGlow:GlowFilter;
        var pmMode = 0;
        private var t2Arr;
        var xmlCannedOptions:XML;
        public var strictComparisonCharsB = "~!#%^&()_+-=:\"<>?,.;'\\ÇüéâäåçêëèïîìÄÅæÆôöòûùÿ֣¥áíóúñ?£ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß";
        public var strictComparisonChars = "~!@#$%^&*()_+-=:\"<>?,.;'\\ÇüéâäåçêëèïîìÄÅæÆôöòûùÿ֣¥áíóúñ?£ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß";
        private var tfdH:int;
        public var emailWarning:String = "WARNING: Never give your email or password to anyone else. Moderators have gold names. If a player does not have a gold name they are NOT a moderator or staff member.";
        public var iChat:int = 0;
        public var muteData:SharedObject;
        private var msgID:int = 0;
        public var t:Timer;
        private var tl:MovieClip;
        public var unsendable;
        public var regExpE:RegExp;
        public var regExpA:RegExp;
        public var regExpI:RegExp;
        public var regExpU:RegExp;
        public var legalCharsStrict:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        public var ignoreList:SharedObject;
        private var mci:MovieClip;
        public var modWhisperCheckList:Array;
        private var profanityA:Array;
        private var msgFields;
        private var profanityC:Array;
        public var pmNm:String = "";
        public var regExpSPACE:RegExp;
        private var profanityF:int = 0;
        private var profanityB:Array;
        public var legalChars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_+-=:\"<>?,./;'\\|ÇüéâäåçêëèïîìÄÅæÆôöòûùÿ֣¥áíóúñ£ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß ";
        private var RedGlow:GlowFilter;
        public var regExpO:RegExp;
        public var chn;
        public var rootClass;
        public var pmSourceA;
        private var drawnA:Array;
        private var whichField = 0;
        public var myMsgs;
        private var chatArray:Array;
        private var t1Arr;
        private var mcCannedChat:MovieClip;
        public var pmI:int = 0;

        public function Chat(){
            iChat = 0;
            pmMode = 0;
            chatArray = [];
            t1Arr = [];
            t2Arr = [];
            silentMute = 0;
            profanityF = 0;
            lineLimit = 100;
            pmSourceA = [];
            pmI = 0;
            pmNm = "";
            ignoreList = SharedObject.getLocal("ignoreList");
            muteData = SharedObject.getLocal("muteData");
            mute = {
                ts:0,
                cd:0,
                timer:new Timer(0, 1)
            };
            myMsgs = [];
            myMsgsI = 0;
            chn = new Object();
            emailWarning = "WARNING: Never give your email or password to anyone else. Moderators have gold names. If a player does not have a gold name they are NOT a moderator or staff member.";
            legalChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_+-=:\"<>?,./;'\\|ÇüéâäåçêëèïîìÄÅæÆôöòûùÿ֣¥áíóúñ£ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß ";
            legalCharsStrict = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            markChars = "~!@#$%^&*()_+-=:\"<>?,.;'\\";
            strictComparisonChars = "~!@#$%^&*()_+-=:\"<>?,.;'\\ÇüéâäåçêëèïîìÄÅæÆôöòûùÿ֣¥áíóúñ?£ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß";
            strictComparisonCharsB = "~!#%^&()_+-=:\"<>?,.;'\\ÇüéâäåçêëèïîìÄÅæÆôöòûùÿ֣¥áíóúñ?£ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß";
            illegalStrings = ["&#", "www", "http", "ftp", ".com", ".net", ".org", ".de", ".ru", ".sg", ".ph", ".tk", "dotcom", "freegold", "freecoins", "freeadventurecoins", "freelevels", "freeitems", "freeupgrades", "gmail", "yahoo", "hotmail", "aol", "formfacil", "email", "password"];
            modWhisperCheckList = ["trade", "free", "acs", "member", "pass", "login", "user", "imamod", "iamamod", "i'mamod", "account"];
            regExpA = /(a{2,})/gi;
            regExpE = /(e{2,})/gi;
            regExpI = /(i{2,})/gi;
            regExpO = /(o{2,})/gi;
            regExpU = /(u{2,})/gi;
            regExpSPACE = /(\s{2,})/gi;
            unsendable = ["@"];
            whichField = 0;
            msgFields = ["t1:", "t2:say,zone,trade,moderator"];
            RedGlow = new GlowFilter(0x990000, 1, 3, 3, 10, BitmapFilterQuality.LOW);
            BlueGlow = new GlowFilter(21359, 1, 3, 3, 10, BitmapFilterQuality.LOW);
            BlackGlow = new GlowFilter(0, 1, 3, 3, 10, BitmapFilterQuality.LOW);
            drawnA = [];
            tfHeight = 141;
            t1Shorty = -148;
            t1Tally = -378;
            tfdH = Math.abs((t1Tally - t1Shorty));
            panelIndex = 0;
            msgID = 0;
            xmlCannedOptions = <CannedChat>
	<l1 display="Emotes">
		<l2 id="emote" display="Dance" text="dance"/>
		<l2 id="emote" display="Laugh" text="laugh"/>
		<l2 id="emote" display="Cry" text="cry"/>
		<l2 id="emote" display="Point" text="point"/>
		<l2 id="emote" display="Feign" text="feign"/>
		<l2 id="emote" display="Sleep" text="sleep"/>
		<l2 id="emote" display="Jump" text="jump"/>
		<l2 id="emote" display="Punt" text="punt"/>
		<l2 id="emote" display="Wave" text="wave"/>
		<l2 id="emote" display="Bow" text="bow"/>
		<l2 id="emote" display="Backflip" text="backflip"/>
		<l2 id="emote" display="Facepalm" text="facepalm"/>
		<l2 id="emote" display="Air Guitar" text="airguitar"/>
		<l2 id="emote" display="Stern" text="stern"/>
	</l1>
	<l1 display="Greetings">
		<l2 id="ba" display="Hello!" text="Hello!"/>
		<l2 id="bb" display="Hi!" text="Hi!"/>
		<l2 id="bc" display="Well met!" text="Well met!"/>
		<l2 id="bd" display="Welcome!" text="Welcome!"/>
		<l2 id="be" display="Welcome back!" text="Welcome back!"/>
		<l2 id="bf" display="How are you today?" text="How are you today?"/>
	</l1>
	<l1 display="Farewells">
		<l2 id="ca" display="Bye!" text="Bye!"/>
		<l2 id="cb" display="See you later." text="See you later."/>
		<l2 id="cc" display="AFK" text="I'm going AFK"/>
		<l2 id="cd" display="I have to go now." text="I have to go now."/>
		<l2 id="ce" display="Logging out now" text="Logging out now."/>
		<l2 id="cf" display="brb" text="brb"/>
		<l2 id="cg" display="Farewell" text="Farewell"/>
	</l1>
	<l1 display="Questions">
		<l2 id="da" display="Can I add you">
			<l3 id="ea" display="to my Friends list" text="Can I add you to my Friends list?"/>
			<l3 id="eb" display="to my Party" text="Can I add you to my Party?"/>
		</l2>
		<l2 id="db" display="Do you want to battle together?" text="Do you want to battle together?"/>
	    <l2 id="dc" display="Is that a Member only...">
			<l3 id="fa" display="Helm" text=" Is that a Member only helm?"/>
			<l3 id="fb" display="Cape" text=" Is that a Member only cape?"/>
			<l3 id="fc" display="Armor" text=" Is that a Member only armor?"/>
			<l3 id="fd" display="Weapon" text=" Is that a Member only weapon?"/>
		</l2>
		<l2 id="dd" display="Where are you?" text="Where are you?"/>
		<l2 id="de" display="Are you sure?" text="Are you sure?"/>
		<l2 id="df" display="Can I help you?" text="Can I help you?"/>
		<l2 id="dg" display="What is your alignment?" text="What is your alignment?"/>
		<l2 id="dh" display="Where did you get that ...">
			<l3 id="ga" display="Helm" text="Where did you get that helm?"/>
			<l3 id="gb" display="Cape" text="Where did you get that cape?"/>
			<l3 id="gc" display="Armor" text="Where did you get that armor?"/>
			<l3 id="gd" display="Weapon" text="Where did you get that weapon?"/>
			<l3 id="ge" display="Pet" text="Where did you get that pet?"/>
		</l2>
		<l2 id="di" display="Are you a...">
			<l3 id="ha" display="Guardian" text="Are you a Guardian?"/>
			<l3 id="hb" display="DragonLord" text="Are you a DragonLord?"/>
			<l3 id="hc" display="StarCaptain" text="Are you a StarCaptain?"/>
		</l2>
		<l2 id="dj" display="Do you play...">
			<l3 id="ia" display="AdventureQuest" text="Do you play AdventureQuest?"/>
			<l3 id="ib" display="DragonFable" text="Do you play DragonFable?"/>
			<l3 id="ic" display="MechQuest" text="Do you play MechQuest?"/>
		</l2>
		<l2 id="dl" display="What are you doing?" text="What are you doing?"/>
	</l1>
	<l1 display="Answers">
		<l2 id="ja" display="thanks/welcome">
			<l3 id="ka" display="Thanks!" text="Thanks!"/>
			<l3 id="kb" display="Thank you!" text="Thank you!"/>
			<l3 id="kc" display="Thanks for helping me." text="Thanks for helping me."/>
			<l3 id="kd" display="I owe you one." text="I owe you one.."/>
			<l3 id="ke" display="No problem!" text="No problem!"/>
			<l3 id="kf" display="You're welcome!" text="You're welcome!"/>
		</l2>
		<l2 id="jn" display="I am doing/trying to..">
			<l3 id="ma" display="Quest" text="I am doing a quest."/>
			<l3 id="mb" display="Farming" text="I am farming."/>
			<l3 id="mc" display="New" text="I am playing the new release."/>
			<l3 id="md" display="Level up." text="I am trying to level up."/>
			<l3 id="me" display="Rank up." text="I am trying to rank up."/>
		</l2>
		<l2 id="jb" display="I'm fine, thanks." text="I'm fine, thanks."/>	
		<l2 id="jc" display="Could be better." text="Could be better."/>
		<l2 id="jd" display="I don't think so." text="I don't think so."/>
		<l2 id="je" display="I don't know." text="I don't know."/>
		<l2 id="jf" display="Indeed." text="Indeed."/>
		<l2 id="jg" display="Pleased to meet you." text="Pleased to meet you."/>
		<l2 id="jh" display="Good." text="I am Good."/>
		<l2 id="ji" display="Evil." text="I am Evil."/>
		<l2 id="jj" display="Me too!" text="Me too!"/>
		<l2 id="jk" display="I got it...">
			<l3 id="la" display="as a drop." text="I got it as a drop."/>
			<l3 id="lb" display="from a shop." text="I got it from a shop."/>
		</l2>
		<l2 id="jl" display="Check the Wiki..." text="You can check the Wiki for the location."/>
		<l2 id="jm" display="Your Book of Lore will know that" text="Your Book of Lore will know that."/>
		<l2 id="jo" display="I can only use Canned Chat." text="I can only use Canned Chat."/>
	</l1>
	<l1 display="Meeting up">
		<l2 id="na" display="Follow me!" text="Follow me!"/>
		<l2 id="nb" display="Over here!" text="Over here!"/>
		<l2 id="nc" display="Goto me." text="Goto me."/>
		<l2 id="nd" display="I'll follow you." text="I'll follow you."/>
		<l2 id="ne" display="Maybe some other time." text="Maybe some other time."/>
		<l2 id="nf" display="Ok, let's go." text="Ok, let's go."/>
		<l2 id="ng" display="Come back here." text="Come back here."/>
		<l2 id="nh" display="I need to finish this first." text="I need to finish this first."/>
		<l2 id="ni" display="Seriously?" text="Seriously?"/>
		<l2 id="nj" display="*I'm going to...">
			<l3 id="oa" display="Artix" text="I'm going to the Artix Server."/>
			<l3 id="ob" display="Galanoth" text="I'm going to the Galanoth Server."/>
			<l3 id="oc" display="Safiria" text="I'm going to the Safiria Server."/>
			<l3 id="od" display="Nythera" text="I'm going to the Nythera Server."/>
			<l3 id="oe" display="Cysero" text="I'm going to the Cysero Server."/>
			<l3 id="of" display="Minimal" text="I'm going to the Minimal Server."/>
			<l3 id="og" display="Zhoom" text="I'm going to the Zhoom Server."/>
			<l3 id="oh" display="Sir Ver" text="I'm going to Sir Ver."/>
			<l3 id="oi" display="Twig" text="I'm going to the Twig server."/>
			<l3 id="oj" display="Twilly" text="I'm going to the Twilly server."/>
			<l3 id="ok" display="Zorbak" text="I'm going to the Zorbak server."/>
		</l2>
		<l2 id="nk" display="Sorry, I'm busy." text="Sorry, I'm busy."/>
	</l1>
	<l1 display="In Battle">
		<l2 id="pa" display="Can you..">
			<l3 id="qa" display="help with battle" text="Can you help me with this battle?"/>
			<l3 id="qb" display="help with Boss" text="Can you help me with the Boss?"/>
		</l2>
		<l2 id="pb" display="Planning...">
			<l3 id="ra" display="Let's attack now!" text="Let's attack now!"/>
			<l3 id="rb" display="I'll attack first." text="I'll attack first."/>
			<l3 id="rc" display="You go first." text="You go first."/>
			<l3 id="rd" display="I need to rest." text="I need to rest."/>
		</l2>
		<l2 id="pc" display="During the battle">
			<l3 id="sa" display="Heal, please!" text="Heal, please!"/>
			<l3 id="sb" display="MEDIC!" text="MEDIC!"/>
			<l3 id="sc" display="Help!" text="Help!"/>
			<l3 id="sd" display="I'm out of Mana." text="I'm out of Mana."/>
			<l3 id="se" display="Use your special attacks!" text="Use your special attacks!"/>
			<l3 id="sf" display="This monster is strong!" text="This monster is strong!"/>
			<l3 id="sg" display="Slay that monster!" text="Slay that monster!"/>
			<l3 id="sh" display="This is hard." text="This hard."/>
			<l3 id="si" display="This is easy." text="This easy."/>
			<l3 id="sj" display="Run away!" text="Run away!"/>
		</l2>
		<l2 id="pd" display="After battle">
			<l3 id="ta" display="Yes! I got the drop!" text="Yes! I got the drop!"/>
			<l3 id="tb" display="We did it!" text="We did it!"/>
			<l3 id="tc" display="You fight well." text="You fight well."/>
			<l3 id="td" display="Nooo! I died!" text="Nooo! I died!"/>
			<l3 id="tf" display="Let's try again!" text="Let's try again!"/>
		</l2>
	</l1>
	<l1 display="Exclamations">
		<l2 id="ua" display="Battle on!" text="Battle on!"/>
		<l2 id="uc" display="OMG!" text="OMG!"/>
		<l2 id="ud" display="lol" text="lol"/>
		<l2 id="uf" display="Woot!" text="Woot!"/>
		<l2 id="ug" display="Wow!" text="Wow"/>
		<l2 id="uh" display="High Five!" text="High Five!"/>
		<l2 id="ui" display="Congrats!" text="Congrats!"/>
		<l2 id="uj" display="Level up!" text="Level up!"/>
		<l2 id="uk" display="Rank up!" text="Rank up!"/>
		<l2 id="ul" display="LONG UN-LIVE THE SHADOWSCYTHE!!" text="LONG UN-LIVE THE SHADOWSCYTHE!!"/>
		<l2 id="um" display="Long live King Alteon the Good!!" text="Long live King Alteon the Good!!"/>
		<l2 id="un" display="This rocks!" text="This rocks!"/>
		<l2 id="uo" display="This is awesome!" text="This is awesome!"/>
		<l2 id="up" display="This is fun." text="This is fun."/>
		<l2 id="uq" display="That is really cool." text="That is really cool."/>
		<l2 id="ur" display="Cheer up!" text="Cheer up!"/>
		<l2 id="ut" display="Great!" text="Great!"/>
		<l2 id="uu" display="HaHa" text="HaHa"/>
	</l1>
	<l1 display="Stop">
		<l2 id="va" display="following me" text="Please stop following me."/>
		<l2 id="vb" display="doing that" text="Please stop doing that."/>
		<l2 id="vc" display="PMing me" text="Please stop PMing me."/>
	</l1>
	<l1 display="Smilies">
		<l2 id="wa" display=":)" text=":)"/>
		<l2 id="wb" display=":(" text=":("/>
		<l2 id="wc" display=":/" text=":/"/>
		<l2 id="wd" display=":|" text=":|"/>
		<l2 id="we" display=":O" text=":O"/>
		<l2 id="wf" display="D:" text="D:"/>
	</l1>
	<l1 id="x" display="Yes." text="Yes."/>
	<l1 id="y" display="No." text="No."/>
	<l1 id="z" display="OK." text="OK."/>
</CannedChat>
            ;
            profanityA = new Array("@$$", "anal", "arse", "ass", "a55", "a5s", "as5", "a$$", "a$s", "as$", "a5$", "a$5", "a*s", "*ss", "a**", "as*", "assclown", "assface", "asshole", "asswipe", "bastard", "beating the meat", "beef curtains", "beef flaps", "biatch", "bich", "b1ch", "b!ch", "blch", "b|ch", "bitch", "b1tch", "b!tch", "bltch", "b|tch", "bizzach", "blowjob", "boobies", "boobs", "buggery", "bullshit", "butt", "carpet muncher", "carpet munchers", "carpetlicker", "carpetlickers", "chode", "clit", "cocaine", "cock", "c0ck", "co*k", "c*ck", "cocksucker", "condom", "cracka", "cum", "cunt", "c*nt", "cu*t", "*unt", "cun*", "damn", "dick", "di*k", "d*ck", "d**k", "dildo", "dumbass", "dyke", "ejaculate", "ekrem", "f*ck", "f@g", "fag", "faggot", "fatass", "felcher", "ffeg", "foreskin", "fuk", "fck", "fu*k", "fuck", "fuuck", "fuuk", "fcuk", "fvck", "fvk", "fvvck", "fvvk", "fock", "fux0r", "fucken", "fucker", "fucking", "fudgepacker", "ganja", "gay", "gey", "g*y", "h0r", "h*re", "hentai", "heroin", "homo", "horny", "injun", "jack off", "jerk off", "jism", "jizz", "kanker", "kawk", "kike", "klootzak", "knulle", "kraut", "kuk", "kuksuger", "kurac", "kurwa", "kusi", "kyrpa", "l3+ch", "l3i+ch", "lesbian", "lesbo", "lez", "mamhoon", "marijuana", "masturbate", "meat puppet", "merd", "mibun", "milf", "motherfucker", "mouliwop", "muie", "mulkku", "nads", "nazi", "nigga", "nigger", "nutsack", "orospu", "p0rn", "paska", "penis", "perse", "phuck", "picka", "pierdol", "pillu", "pimmel", "pimpios", "piss", "poontsee", "porn", "pr0n", "preteen", "pron", "prostitute", "pussy", "puta", "puto", "queef", "rape", "raped", "rapi", "rapist", "rautenberg", "retard", "rimjob", "schaffer", "schencter", "schiess", "schlampe", "screw", "scrotum", "secks", "sex", "s*x", "se*", "shaor", "sharmuta", "sharmute", "shipal", "shit", "sh1t", "sh!t", "shlt", "sh|t", "shiz", "sh1z", "sh!z", "shlz", "sh|z", "shiit", "shi!t", "sh!it", "shilt", "shlit", "sh||t", "shi|t", "sh|it", "shiiz", "s hit", "shi t", "sh*t", "s*it", "s**t", "shi*", "s***", "shlong", "skank", "skribz", "skurwysyn", "slut", "sl*t", "s**t", "smartass", "smut", "spierdalaj", "splooge", "threesome", "tit", "tits", "titties", "twat", "vagina", "wank", "weed", "wetback", "whack off", "whore", "wh*r", "wh*re", "wichser", "zabourah");
            profanityB = [];
            profanityC = ["bitch", "b1tch", "b!tch", "bltch", "b|tch", "damn", "dick", "fag", "fuk", "fvk", "fvck", "fuck", "pussy", "shit", "sh1t", "sh!t", "shlt", "sh|t"];
            t = new Timer(500, 1);
            windowTimer = new Timer(60000, 1);
            super();
            chn.cur = {};
            chn.lastPublic = {};
            chn.xt = "zm";
            chn.zone = {};
            chn.trade = {};
            chn.moderator = {};
            chn.warning = {};
            chn.server = {};
            chn.event = {};
            chn.whisper = {};
            chn.party = {};
            chn.zone.col = "CCCCCC";
            chn.trade.col = "D2FD94";
            chn.moderator.col = "ECC85B";
            chn.warning.col = "FFFFFF";
            chn.server.col = "FFFFFF";
            chn.event.col = "00FF00";
            chn.whisper.col = "D0BAEB";
            chn.party.col = "#6CC86F";
            chn.zone.str = "zone";
            chn.trade.str = "trade";
            chn.moderator.str = "moderator";
            chn.warning.str = "warning";
            chn.server.str = "server";
            chn.event.str = "event";
            chn.whisper.str = "whisper";
            chn.party.str = "party";
            chn.zone.typ = "message";
            chn.trade.typ = "message";
            chn.moderator.typ = "whisper";
            chn.warning.typ = "server";
            chn.server.typ = "server";
            chn.event.typ = "event";
            chn.whisper.typ = "whisper";
            chn.party.typ = "message";
            chn.zone.tag = "";
            chn.trade.tag = "";
            chn.moderator.tag = "Moderator";
            chn.warning.tag = "";
            chn.server.tag = "";
            chn.whisper.tag = "Whisper";
            chn.event.tag = "";
            chn.party.tag = "Party";
            chn.zone.rid = 0;
            chn.trade.rid = 0;
            chn.moderator.rid = 0;
            chn.warning.rid = 0;
            chn.server.rid = 0;
            chn.event.rid = 0;
            chn.whisper.rid = 0;
            chn.party.rid = 32123;
            chn.zone.act = 1;
            chn.trade.act = 0;
            chn.moderator.act = 1;
            chn.warning.act = 1;
            chn.server.act = 1;
            chn.event.act = 1;
            chn.whisper.act = 1;
            chn.party.act = 0;
            chn.cur = chn.zone;
            chn.lastPublic = chn.cur;
            if (ignoreList.data.users == undefined){
                ignoreList.data.users = new Array();
            };
        }
        public function cleanChars(str:String):String{
            var i:int;
            i = 0;
            while (i < str.length) {
                if (legalChars.indexOf(str.charAt(i)) < 0){
                    str = str.replace(str.charAt(i), "?");
                };
                i++;
            };
            return (str);
        }
        public function pushMsg(typ, msg, unm, rnm, org, doModWhisperCheck:Boolean=false){
            var isModSpoof:Boolean;
            var itemOpen:String;
            var itemClose:String;
            var silentMute:int;
            var msgT:*;
            var profanityResult:Object;
            var i:*;
            var t:*;
            var m:*;
            var s:*;
            var r:*;
            var o:*;
            var mi:*;
            var fa:*;
            var fb:*;
            var fc:*;
            var tag:*;
            var u:*;
            var su:*;
            var warningTT:String;
            trace(((("msg> " + msg) + " ?> ") + unm));
            isModSpoof = false;
            if (((!((ignoreList.data.users == null))) && ((ignoreList.data.users.indexOf(unm) > -1)))){
                return;
            };
            if (unm != "SERVER"){
                silentMute = 0;
                msgT = rootClass.stripWhite(msg.toLowerCase());
                profanityResult = profanityCheck(msg.toLowerCase());
                if (unm.toLowerCase() != rootClass.sfc.myUserName){
                    if (((strContains(msgT, illegalStrings)) || (strContains(msgT, unsendable)))){
                        silentMute = 1;
                    };
                    msgT = rootClass.stripWhiteStrict(msg.toLowerCase());
                    if (strContains(msgT, ["email", "password"])){
                        silentMute = 1;
                    };
                    if ((((profanityResult.code == 1)) || ((profanityResult.code == 2)))){
                        silentMute = 1;
                    };
                    if ((((((typ == "whisper")) && (doModWhisperCheck))) && ((modWhisperCheck(msg) > 0)))){
                        isModSpoof = true;
                    };
                    if (silentMute){
                        return;
                    };
                };
                if (profanityResult.code == 3){
                    msg = rootClass.maskStringBetween(msg, profanityResult.indeces);
                };
            };
            itemOpen = "$({";
            itemClose = "})$";
            startWindowTimer();
            if (isChannel(typ)){
                checkFieldsVPos();
                chatArray.push([typ, msg, unm, rnm, org, msgID]);
                msgID++;
                if (chatArray.length > lineLimit){
                    chatArray.splice(0, (chatArray.length - lineLimit));
                };
                html2Fields("", "=", "server", 0);
                t1Arr = [];
                i = 0;
                while (i < chatArray.length) {
                    t = chatArray[i][0];
                    m = chatArray[i][1];
                    s = chatArray[i][2];
                    r = chatArray[i][3];
                    o = chatArray[i][4];
                    mi = int(chatArray[i][5]);
                    fa = '<b><font color="#';
                    fb = '">';
                    fc = "</font></b>";
                    tag = (((chn[t].tag)=="") ? "" : (("[" + chn[t].tag) + "] "));
                    u = s;
                    if (((!((s == null))) && (!((s == "SERVER"))))){
                        su = ((((itemOpen + "user,") + u) + itemClose) + ": ");
                    };
                    if (s == "SERVER"){
                        su = "";
                    };
                    if (t != "whisper"){
                        if (t != "event"){
                            html2Fields((((((((fa + chn[t].col) + fb) + tag) + su) + m) + fc) + "<br>"), "+=", t, mi);
                        }
                        else {
                            html2Fields((((((((((((((((fa + "CCCCCC") + fb) + "*") + fa) + "FFFFFF") + fb) + u) + fc) + fa) + "CCCCCC") + fb) + " ") + m) + fc) + "*<br>"), "+=", t, mi);
                        };
                        if (((((((!((t == "event"))) && (!((t == "warning"))))) && (!((t == "server"))))) && (!((t == "moderator"))))){
                            if (i == (chatArray.length - 1)){
                                popBubble(("u:" + s), m, t);
                            };
                        };
                    }
                    else {
                        if ((((s == rootClass.sfc.myUserName)) || (isMyModHandle(s)))){
                            if (o == 0){
                                html2Fields((((((((((('<b><font color="#' + rootClass.modColor(chn[t].col, "333333", "-")) + '">') + "To ") + itemOpen) + "user,") + r.toUpperCase()) + itemClose) + ": ") + m) + "</font></b><br>"), "+=", t, mi);
                            }
                            else {
                                html2Fields(((((('<b><font color="#' + chn[t].col) + '">From ') + su) + m) + "</font></b><br>"), "+=", t, mi);
                            };
                        }
                        else {
                            html2Fields(((((('<b><font color="#' + chn[t].col) + '">From ') + su) + m) + "</font></b><br>"), "+=", t, mi);
                        };
                    };
                    i++;
                };
                setFieldsVPos();
                writeText(panelIndex);
            };
            if (isModSpoof){
                pushMsg("warning", (("<font color='#FFFFFF'>" + unm) + "</font> IS NOT A MODERATOR.  DO NOT GIVE ACCOUNT INFORMATION TO OTHER PLAYERS."), "SERVER", "", 0);
                warningTT = (("<font color='#FF0000'>WARNING</font><br/><font color='#FFFFFF'>" + unm.toUpperCase()) + "</font><font color='#FFFFFF'> IS NOT A MODERATOR.<br/>Do not give account information to other players.<font>");
                warningTT = (warningTT + "<br/><a href='event:link::http://aq.com/safety.asp'><font color='#66CCFF'><u>Click here</u></font></a> to learn more.");
                rootClass.ui.ToolTip.openWith({
                    str:warningTT,
                    lowerright:true,
                    invert:true,
                    closein:10000
                });
            };
        }
        function init(){
            mci = rootClass.ui.mcInterface;
            chatArray = [];
            t1Arr = [];
            drawnA = [];
            msgID = 0;
            panelIndex = 0;
            tfHeight = 141;
            t1Shorty = -148;
            t1Tally = -378;
            tfdH = Math.abs((t1Tally - t1Shorty));
            initProfanity();
            if (muteData.data != null){
                mute.ts = muteData.data.ts;
                mute.cd = muteData.data.cd;
            };
            mute.timer.addEventListener(TimerEvent.TIMER, unmuteMe, false, 0, true);
            if (mcCannedChat == null){
                mcCannedChat = initCannedChat(xmlCannedOptions.children());
            };
            mci.tt.mouseEnabled = false;
            tl = (mci.textLine as MovieClip);
            tl.ti.htmlText = "";
            tl.ti.autoSize = "left";
            tl.visible = false;
            mci.bMinMax.buttonMode = true;
            mci.bMinMax.filters = [rootClass.GlowFilterBlue];
            mci.te.text = "";
            mci.te.visible = false;
            mci.tt.text = "";
            mci.tt.visible = false;
            mci.te.maxChars = 150;
            mci.bCannedChat.removeEventListener(MouseEvent.CLICK, onCannedChatClick);
            mci.bsend.removeEventListener(MouseEvent.CLICK, chat_btnSend);
            mci.tebg.removeEventListener(MouseEvent.CLICK, chat_tebgClick);
            mci.bMinMax.removeEventListener(MouseEvent.MOUSE_OVER, bMinMaxMouseOver);
            mci.bMinMax.removeEventListener(MouseEvent.MOUSE_OUT, bMinMaxMouseOut);
            mci.bMinMax.bMinus.removeEventListener(MouseEvent.CLICK, bMinusClick);
            mci.bMinMax.bPlus.removeEventListener(MouseEvent.CLICK, bPlusClick);
            mci.bMinMax.bClose.removeEventListener(MouseEvent.CLICK, bCloseClick);
            mci.bMinMax.bMinus.removeEventListener(MouseEvent.MOUSE_OVER, bMinMaxMouseOver);
            mci.bMinMax.bPlus.removeEventListener(MouseEvent.MOUSE_OVER, bMinMaxMouseOver);
            mci.bMinMax.bClose.removeEventListener(MouseEvent.MOUSE_OVER, bMinMaxMouseOver);
            mci.bMinMax.bMinus.removeEventListener(MouseEvent.MOUSE_OUT, bMinMaxMouseOut);
            mci.bMinMax.bPlus.removeEventListener(MouseEvent.MOUSE_OUT, bMinMaxMouseOut);
            mci.bMinMax.bClose.removeEventListener(MouseEvent.MOUSE_OUT, bMinMaxMouseOut);
            rootClass.stage.removeEventListener(KeyboardEvent.KEY_DOWN, rootClass.key_StageLogin);
            rootClass.stage.removeEventListener(KeyboardEvent.KEY_DOWN, rootClass.key_StageGame);
            mci.te.removeEventListener(KeyboardEvent.KEY_DOWN, rootClass.key_ChatEntry);
            mci.te.removeEventListener(Event.CHANGE, checkMsgType);
            rootClass.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelEvent);
            mcCannedChat.removeEventListener(MouseEvent.MOUSE_OVER, onCannedChatOver);
            mcCannedChat.removeEventListener(MouseEvent.MOUSE_OUT, onCannedChatOut);
            t.removeEventListener(TimerEvent.TIMER, closeCannedChatTimer);
            windowTimer.removeEventListener(TimerEvent.TIMER, timedWindowHide);
            mci.bCannedChat.addEventListener(MouseEvent.CLICK, onCannedChatClick);
            mci.bsend.addEventListener(MouseEvent.CLICK, chat_btnSend);
            mci.tebg.addEventListener(MouseEvent.CLICK, chat_tebgClick);
            mci.bMinMax.fx.mouseEnabled = false;
            mci.bMinMax.fx.mouseChildren = false;
            mci.bMinMax.bMinus.addEventListener(MouseEvent.CLICK, bMinusClick);
            mci.bMinMax.bPlus.addEventListener(MouseEvent.CLICK, bPlusClick);
            mci.bMinMax.bClose.addEventListener(MouseEvent.CLICK, bCloseClick);
            mci.bMinMax.bMinus.addEventListener(MouseEvent.MOUSE_OVER, bMinMaxMouseOver);
            mci.bMinMax.bPlus.addEventListener(MouseEvent.MOUSE_OVER, bMinMaxMouseOver);
            mci.bMinMax.bClose.addEventListener(MouseEvent.MOUSE_OVER, bMinMaxMouseOver);
            mci.bMinMax.bMinus.addEventListener(MouseEvent.MOUSE_OUT, bMinMaxMouseOut);
            mci.bMinMax.bPlus.addEventListener(MouseEvent.MOUSE_OUT, bMinMaxMouseOut);
            mci.bMinMax.bClose.addEventListener(MouseEvent.MOUSE_OUT, bMinMaxMouseOut);
            rootClass.stage.addEventListener(KeyboardEvent.KEY_DOWN, rootClass.key_StageGame);
            mci.te.addEventListener(KeyboardEvent.KEY_DOWN, rootClass.key_ChatEntry);
            mci.te.addEventListener(Event.CHANGE, checkMsgType);
            rootClass.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelEvent);
            rootClass.ui.mouseEnabled = false;
            mci.mouseEnabled = false;
            mci.t1.mouseEnabled = false;
            mci.addChild(mcCannedChat);
            mcCannedChat.addEventListener(MouseEvent.MOUSE_OVER, onCannedChatOver);
            mcCannedChat.addEventListener(MouseEvent.MOUSE_OUT, onCannedChatOut);
            mcCannedChat.y = (-(mcCannedChat.numChildren) * 23);
            mcCannedChat.visible = false;
            t.addEventListener(TimerEvent.TIMER, closeCannedChatTimer);
            windowTimer.addEventListener(TimerEvent.TIMER, timedWindowHide);
            mci.te.addEventListener(FocusEvent.FOCUS_IN, onFocusIn, false, 0, true);
            mci.te.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut, false, 0, true);
        }
        private function chat_btnSend(e:MouseEvent){
            submitMsg(mci.te.text, chn.cur.typ, pmNm);
            rootClass.stage.focus = null;
        }
        private function onMouseClick(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            if (btn.id == "emote"){
                rootClass.world.myAvatar.pMC.mcChar.gotoAndPlay(rootClass.strToProperCase(btn.strMsg));
                rootClass.sfc.sendXtMessage("zm", "emotea", [btn.strMsg], "str", 1);
            }
            else {
                rootClass.sfc.sendXtMessage("zm", "cc", [btn.id], "str", 1);
            };
            closeCannedChat();
        }
        public function cleanStr(str:String, inBound:Boolean=true, outBound:Boolean=false){
            str = str.split("&#").join("");
            str = str.split("#038:#").join("");
            if (outBound){
                str = removeHTML(str);
            };
            if (((outBound) && ((str.indexOf("%") > -1)))){
                str = str.split("%").join("#037:");
            };
            if (((inBound) && ((str.indexOf("#037:") > -1)))){
                str = str.split("#037:").join("%");
            };
            if (((outBound) && ((str.indexOf("&") > -1)))){
                str = str.split("&").join("#038:");
            };
            if (((inBound) && ((str.indexOf("#038:") > -1)))){
                str = str.split("#038:").join("&");
            };
            if (((outBound) && ((str.indexOf("<") > -1)))){
                str = str.split("<").join("#060:");
            };
            if (((inBound) && ((str.indexOf("#060:") > -1)))){
                str = str.split("#060:").join("&lt;");
            };
            if (((outBound) && ((str.indexOf(">") > -1)))){
                str = str.split(">").join("#062:");
            };
            if (((inBound) && ((str.indexOf("#062:") > -1)))){
                str = str.split("#062:").join("&gt;");
            };
            if (inBound){
                str = removeHTML(str);
            };
            return (str);
        }
        private function onFocusIn(event:FocusEvent):void{
            mci.tebg.ring.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 120, 120, 120, 0);
        }
        private function checkMsgType(e:Event){
            var cs:*;
            var ca:*;
            var c:*;
            var uoNm:*;
            var a:*;
            var pa:*;
            cs = mci.te.text;
            ca = cs.split(" ");
            if (ca.length > 1){
                c = ca[0];
                uoNm = "";
                if (c.charAt(0) == "/"){
                    switch (c.substr(1)){
                        case "1":
                        case "s":
                        case "say":
                            if (chn.zone.act){
                                chn.cur = chn.zone;
                                chn.lastPublic = chn.zone;
                                mci.te.text = mci.te.text.substr((c.substr(1).length + 2));
                            };
                            formatMsgEntry("");
                            updateMsgEntry();
                            break;
                        case "2":
                            if (chn.trade.act){
                                chn.cur = chn.trade;
                                chn.lastPublic = chn.trade;
                                mci.te.text = mci.te.text.substr(3);
                            };
                            formatMsgEntry("");
                            updateMsgEntry();
                            break;
                        case "p":
                            if (chn.party.act){
                                chn.cur = chn.party;
                                chn.lastPublic = chn.party;
                                mci.te.text = mci.te.text.substr(3);
                            };
                            formatMsgEntry("");
                            updateMsgEntry();
                            break;
                        case "r":
                            if (pmSourceA.length){
                                pmMode = 1;
                                chn.cur = chn.whisper;
                                mci.te.text = mci.te.text.substr(3);
                                formatMsgEntry(pmSourceA[0]);
                                updateMsgEntry();
                            };
                            break;
                        case "tell":
                        case "w":
                            if (ca.length > 2){
                                pmMode = 1;
                                chn.cur = chn.whisper;
                                mci.te.text = mci.te.text.substr(((ca[0].length + ca[1].length) + 1));
                                formatMsgEntry(ca[1]);
                                updateMsgEntry();
                            };
                            break;
                        case "c":
                            pmMode = 2;
                            chn.cur = chn.whisper;
                            mci.te.text = mci.te.text.substr(((ca[0].length + ca[1].length) + 1));
                            formatMsgEntry(pmSourceA[0]);
                            updateMsgEntry();
                            break;
                    };
                };
                if (c.charAt(0) == ">"){
                    if (pmSourceA.length){
                        pmMode = 1;
                        chn.cur = chn.whisper;
                        mci.te.text = mci.te.text.substr(2);
                        formatMsgEntry(pmSourceA[0]);
                        updateMsgEntry();
                    };
                };
                a = [];
                if ((((cs.indexOf(" > ") > 1)) && ((((cs.indexOf("<") == -1)) || ((cs.indexOf(" > ") < cs.indexOf("<"))))))){
                    pa = cs.split(">");
                    while (pa[0].charAt((pa[0].length - 1)) == " ") {
                        pa[0] = pa[0].substr(0, (pa[0].length - 1));
                    };
                    pmMode = 1;
                    chn.cur = chn.whisper;
                    mci.te.text = pa[1];
                    formatMsgEntry(pa[0]);
                    updateMsgEntry();
                };
            };
        }
        private function bMinMaxMouseOut(e:MouseEvent){
            var bm:MovieClip;
            bm = (e.currentTarget as MovieClip);
            bm.filters = [];
        }
        public function isUnsendable(s:String):Boolean{
            var i:*;
            i = 0;
            while (i < unsendable.length) {
                if (s.toLowerCase().indexOf(unsendable[i]) > -1){
                    return (true);
                };
                i++;
            };
            return (false);
        }
        public function profanityCheck(str:String):Object{
            var s:String;
            var i:int;
            var o:Object;
            var originalIndex:Array;
            var cleaned:String;
            var j:int;
            i = 0;
            o = {
                code:0,
                term:"",
                index:-1,
                indeces:[]
            };
            s = ((" " + removeHTML(cleanStr(str.toLowerCase()))) + " ");
            s = rootClass.stripMarks(s);
            s = rootClass.stripDuplicateVowels(s);
            i = 0;
            while (i < profanityA.length) {
                o.index = s.indexOf(((" " + profanityA[i]) + " "));
                if (o.index > -1){
                    o.term = profanityA[i];
                    o.code = 1;
                    return (o);
                };
                i++;
            };
            s = rootClass.stripDuplicateVowels(removeHTML(cleanStr(str.toLowerCase())));
            s = rootClass.stripWhiteStrict(s);
            i = 0;
            while (i < profanityB.length) {
                o.index = s.indexOf(profanityB[i]);
                if (o.index > -1){
                    o.term = profanityB[i];
                    trace(("profanityB[i] = " + profanityB[i]));
                    o.code = 2;
                    return (o);
                };
                i++;
            };
            s = rootClass.stripDuplicateVowels(removeHTML(cleanStr(str.toLowerCase())));
            s = rootClass.stripWhiteStrictB(s);
            i = 0;
            while (i < profanityB.length) {
                o.index = s.indexOf(profanityB[i]);
                if (o.index > -1){
                    o.term = profanityB[i];
                    trace(("profanityB[i] = " + profanityB[i]));
                    o.code = 2;
                    return (o);
                };
                i++;
            };
            originalIndex = [];
            cleaned = "";
            j = 0;
            while (j < str.length) {
                if (legalCharsStrict.indexOf(str.charAt(j)) > -1){
                    if ((((cleaned.length == 0)) || (!((str.charAt(j) == cleaned.charAt((cleaned.length - 1))))))){
                        cleaned = (cleaned + str.charAt(j));
                        originalIndex.push(j);
                    };
                };
                j++;
            };
            i = 0;
            while (i < profanityC.length) {
                o.index = cleaned.indexOf(profanityC[i]);
                if (o.index > -1){
                    o.code = 3;
                    o.indeces.push(originalIndex[o.index]);
                    o.indeces.push(((originalIndex[o.index] + profanityC[i].length) - 1));
                };
                i++;
            };
            return (o);
        }
        public function submitMsg(msg:String, typ, unm, isMulti:Boolean=false){
            var msgOK:Boolean;
            var warningModal:Boolean;
            var strEmail:String;
            var tuo:* = undefined;
            var uName:String;
            var rmId:int;
            var tuoNm:String;
            var parta:* = undefined;
            var partb:String;
            var i:int;
            var multiO:Object;
            var str:* = undefined;
            var strPassword:* = undefined;
            var uoData:* = undefined;
            var modal:* = undefined;
            var modalO:* = undefined;
            var strA:String;
            var ei:int;
            var xtArr:* = undefined;
            var cmd:* = undefined;
            var params:* = undefined;
            var paramStr:* = undefined;
            var uVars:* = undefined;
            var puNam:* = undefined;
            var puVal:* = undefined;
            var emStr:* = undefined;
            var index:int;
            var profanityResult:Object;
            var myAvatar:Avatar;
            var iDiff:Number;
            var iHrs:int;
            var iMins:int;
            var msg:String = msg;
            var typ:* = typ;
            var unm:* = unm;
            var isMulti:Boolean = isMulti;
            msg = cleanChars(msg);
            msgOK = true;
            warningModal = true;
            strEmail = null;
            if (rootClass.loginInfo.strPassword != null){
                strPassword = rootClass.loginInfo.strPassword.toLowerCase();
                if (msg.toLowerCase().indexOf(strPassword) > -1){
                    msgOK = false;
                };
            };
            if (((!((rootClass.world == null))) && (!((rootClass.world.myAvatar == null))))){
                if (rootClass.world.items == null){
                    msgOK = false;
                    warningModal = false;
                    pushMsg("warning", "Character is still being loaded, please wait a moment.", "SERVER", "", 0);
                    return;
                };
                if (rootClass.world.myAvatar.objData != null){
                    uoData = rootClass.world.myAvatar.objData;
                    if (uoData.strEmail != null){
                        strEmail = uoData.strEmail.toLowerCase();
                    };
                    if (((!((strEmail == null))) && ((strEmail.length > 5)))){
                        if (msg.toLowerCase().indexOf(strEmail) > -1){
                            msgOK = false;
                        };
                    };
                };
            };
            if (((!(msgOK)) && (warningModal))){
                modal = new ModalMC();
                modalO = {};
                modalO.strBody = "Never give your password or email to anyone. Please note that AQWorlds staff will never ask for your password or email. We do not need that information to look up your account.";
                modalO.callback = null;
                modalO.btns = "mono";
                rootClass.ui.ModalStack.addChild(modal);
                modal.init(modalO);
                strA = "";
                ei = 0;
                if (strEmail != null){
                    if (msg.indexOf(strEmail) > -1){
                        ei = 0;
                        while (ei < strEmail.length) {
                            strA = (strA + (((ei)==0) ? strEmail.charAt(0) : "*"));
                            ei = (ei + 1);
                        };
                        msg = msg.split(strEmail).join(strA);
                    };
                };
                ei = 0;
                strA = "";
                if (msg.indexOf(strPassword) > -1){
                    ei = 0;
                    while (ei < strPassword.length) {
                        strA = (strA + (((ei)==0) ? strPassword.charAt(0) : "*"));
                        ei = (ei + 1);
                    };
                    msg = msg.split(strPassword).join(strA);
                };
                pushMsg("warning", msg, "SERVER", "", 0);
                closeMsgEntry();
                return;
            };
            i = 0;
            str = rootClass.stripWhite(msg);
            if (str.length){
                myMsgs.push(msg);
                xtArr = [];
                cmd = "";
                if (msg.substr(0, 1) == "/"){
                    params = msg.substr(1).split(" ");
                    paramStr = params[0].toLowerCase();
                    switch (paramStr){
                        case "multi":
                            msg = ("/" + msg.substr(7));
                            submitMsg(msg, typ, unm, true);
                            return;
                        case "reload":
                            cmd = null;
                            if (rootClass.world.myAvatar.isStaff()){
                                rootClass.world.reloadCurrentMap();
                            };
                            break;
                        case "cell":
                            cmd = null;
                            if (rootClass.world.myAvatar.objData.intAccessLevel >= 40){
                                if (params.length > 1){
                                    parta = params[1];
                                }
                                else {
                                    parta = "none";
                                };
                                if (params.length > 2){
                                    partb = params[2];
                                }
                                else {
                                    partb = "none";
                                };
                                if (parta != "none"){
                                    rootClass.world.moveToCell(parta, partb);
                                };
                            };
                            break;
                        case "shop":
                            cmd = null;
                            if (rootClass.world.myAvatar.objData.intAccessLevel >= 40){
                                if (params.length > 1){
                                    parta = int(params[1]);
                                }
                                else {
                                    parta = 1;
                                };
                                rootClass.world.sendLoadShopRequest(parta);
                            };
                            break;
                        case "sound":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                if (params[1] == "off"){
                                    rootClass.mixer.bSoundOn = false;
                                }
                                else {
                                    if (params[1] == "on"){
                                        rootClass.mixer.bSoundOn = true;
                                    };
                                };
                            };
                            break;
                        case "ignore":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                tuoNm = params.slice(1).join(" ");
                                if (tuoNm.toLowerCase() != rootClass.sfc.myUserName){
                                    cmd = "cmd";
                                    ignore(tuoNm);
                                    msg = ("You are now ignoring user " + tuoNm);
                                    pushMsg("server", msg, "SERVER", "", 0);
                                }
                                else {
                                    msg = "You cannot ignore yourself!";
                                    pushMsg("warning", msg, "SERVER", "", 0);
                                };
                            };
                            break;
                        case "unignore":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                tuoNm = params.slice(1).join(" ");
                                cmd = "cmd";
                                unignore(tuoNm);
                                msg = (("User " + tuoNm) + " is no longer being ignored");
                                pushMsg("server", msg, "SERVER", "", 0);
                            };
                            break;
                        case "ignoreclear":
                            cmd = null;
                            ignoreList.data.users = new Array();
                            pushMsg("warning", "Ignore List Cleared!", "SERVER", "", 0);
                            rootClass.sfc.sendXtMessage("zm", "cmd", ["ignoreList", "$clearAll"], "str", 1);
                            break;
                        case "report":
                        case "reportlang":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                tuoNm = params.slice(1).join(" ");
                                rootClass.ui.mcPopup.fOpen("Report", {unm:tuoNm});
                            };
                            break;
                        case "reporthack":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                parta = params.split(":")[0];
                                partb = params.split(":")[1];
                                tuoNm = parta.slice(1).join(" ");
                                cmd = "cmd";
                                xtArr.push("reporthack");
                                xtArr.push(tuoNm);
                                xtArr.push(partb);
                            };
                            break;
                        case "modon":
                        case "modoff":
                            cmd = "cmd";
                            xtArr.push(params[0]);
                            break;
                        case "getinfo":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                tuoNm = params.slice(1).join(" ");
                                cmd = "cmd";
                                xtArr.push(params[0]);
                                xtArr.push(tuoNm);
                            };
                            break;
                        case "size":
                            cmd = "cmd";
                            xtArr.push(params[0]);
                        case "getroomname":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                cmd = "cmd";
                                xtArr.push(params[0]);
                                xtArr.push(params[1]);
                            };
                            break;
                        case "event":
                            if (params.length > 2){
                                cmd = "cmd";
                                xtArr.push(params[0]);
                                xtArr.push(params[1]);
                                xtArr.push(params.slice(2).join(" "));
                            };
                            break;
                        case "tfer":
                            if (((((((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))) && (!((typeof(params[2]) == "undefined"))))) && ((params[2].length > 0)))){
                                cmd = "cmd";
                                xtArr.push(params[0]);
                                xtArr.push(params[1]);
                                xtArr.push(params[2]);
                            };
                            break;
                        case "invite":
                        case "pi":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                tuoNm = params.slice(1).join(" ");
                                if ((((rootClass.world.partyMembers.length < 4)) || (!(rootClass.world.isPartyMember(tuoNm))))){
                                    rootClass.world.partyInvite(tuoNm);
                                };
                            };
                            break;
                        case "ps":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                tuoNm = params.slice(1).join(" ");
                                rootClass.world.partySummon(tuoNm);
                            };
                            break;
                        case "pk":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                tuoNm = params.slice(1).join(" ");
                                rootClass.world.doPartyKick(tuoNm);
                            };
                            break;
                        case "gr":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                puNam = params.split(" ")[0];
                                puVal = params.slice(1).join(" ");
                                rootClass.world.partyUpdate(puNam, puVal);
                            };
                            break;
                        case "duel":
                            cmd = null;
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                tuoNm = params.slice(1).join(" ");
                                rootClass.world.sendDuelInvite(tuoNm);
                            };
                            break;
                        case "friends":
                            cmd = null;
                            rootClass.world.showFriendsList();
                            break;
                        case "friend":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                tuoNm = params.slice(1).join(" ");
                                if (tuoNm.toLowerCase() != rootClass.sfc.myUserName){
                                    rootClass.world.requestFriend(tuoNm);
                                };
                            };
                            break;
                        case "modban":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                cmd = "cmd";
                                tuoNm = params.slice(1).join(" ");
                                xtArr.push(params[0]);
                                xtArr.push(tuoNm);
                                xtArr.push(24);
                            };
                            break;
                        case "join":
                            if (((((((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))) && (!((rootClass.world.uoTree[rootClass.sfc.myUserName].intState == 0))))) && (rootClass.world.coolDown("tfer")))){
                                rootClass.world.returnInfo = null;
                                cmd = "cmd";
                                uName = rootClass.sfc.myUserName;
                                xtArr.push("tfer");
                                xtArr.push(rootClass.sfc.myUserName);
                                xtArr.push(params[1]);
                            };
                            break;
                        case "house":
                            cmd = "cmd";
                            if (params[1] == null){
                                tuoNm = rootClass.sfc.myUserName;
                            }
                            else {
                                tuoNm = params.slice(1).join(" ");
                            };
                            xtArr.push(params[0]);
                            xtArr.push(tuoNm);
                            break;
                        case "kick":
                        case "ipkick":
                        case "ipunmute":
                        case "unmute":
                        case "freeze":
                        case "unfreeze":
                        case "watch":
                        case "unwatch":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                cmd = "cmd";
                                tuoNm = params.slice(1).join(" ");
                                xtArr.push(params[0]);
                                xtArr.push(tuoNm);
                            };
                            break;
                        case "mute":
                        case "ban":
                        case "ipmute":
                            if (((((rootClass.world.myAvatar.isStaff()) && (!((typeof(params[1]) == "undefined"))))) && ((params[1].length > 0)))){
                                cmd = "cmd";
                                tuoNm = params.slice(2).join(" ");
                                xtArr.push(params[0]);
                                xtArr.push(params[1]);
                                xtArr.push(tuoNm);
                            };
                            break;
                        case "goto":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                cmd = null;
                                rootClass.world.goto(params.slice(1).join(" "));
                            };
                            break;
                        case "pull":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                cmd = null;
                                rootClass.world.pull(params.slice(1).join(" "));
                            };
                            break;
                        case "clear":
                            if (params.length > 1){
                                cmd = "cmd";
                                xtArr.push(params[0]);
                                xtArr.push(params[1]);
                            };
                            break;
                        case "killmap":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                cmd = "cmd";
                                xtArr.push(params[0]);
                                xtArr.push(params[1]);
                            };
                            break;
                        case "item":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                cmd = "cmd";
                                xtArr.push(params[0]);
                                xtArr.push(params[1]);
                                xtArr.push(params[2]);
                            };
                            break;
                        case "addrep":
                        case "addxp":
                        case "addv":
                        case "hp":
                        case "level":
                        case "getevents":
                        case "getevent":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                cmd = "cmd";
                                xtArr.push(params[0]);
                                xtArr.push(params[1]);
                            };
                            break;
                        case "resetevents":
                        case "resetlogins":
                        case "resetgrove":
                        case "resettimes":
                        case "getlogins":
                        case "gettimes":
                        case "clock":
                        case "whitelist":
                            cmd = "cmd";
                            i = 0;
                            while (i < params.length) {
                                xtArr.push(params[i]);
                                i = (i + 1);
                            };
                            break;
                        case "getbreakdown":
                            cmd = "cmd";
                            xtArr.push(params[0]);
                            break;
                        case "adminyell":
                        case "iay":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                cmd = "cmd";
                                xtArr.push(params[0]);
                                msg = params.slice(1).join(" ");
                                msg = cleanStr(msg, false, true);
                                xtArr.push(msg);
                            };
                            break;
                        case "iteratortest":
                            cmd = "cmd";
                            xtArr.push(params[0]);
                            break;
                        case "fps":
                            cmd = null;
                            if (rootClass.world.myAvatar.objData.intAccessLevel >= 40){
                                rootClass.world.toggleFPS();
                            };
                            break;
                        case "dps":
                            cmd = null;
                            if (rootClass.world.myAvatar.objData.intAccessLevel >= 40){
                            };
                            break;
                        case "mod":
                            cmd = "cmd";
                            xtArr.push(params[0]);
                            break;
                        case "pmoff":
                            cmd = "cmd";
                            xtArr.push(params[0]);
                            xtArr.push(msg.substr(7));
                            break;
                        case "pmon":
                        case "partyon":
                        case "partyoff":
                        case "chaton":
                        case "chatoff":
                        case "friendon":
                        case "friendoff":
                        case "waron":
                        case "waroff":
                        case "kickall":
                        case "restart":
                        case "restartnow":
                        case "shutdown":
                        case "shutdownnow":
                        case "empty":
                            cmd = "cmd";
                            xtArr.push(params[0]);
                            break;
                        case "roll":
                            cmd = "util";
                            xtArr.push(params[0]);
                            break;
                        case "geta":
                            if (((rootClass.world.myAvatar.isStaff()) && ((params.length == 3)))){
                                pushMsg("warning", ((((("geta " + params[1]) + ",") + params[2]) + ": ") + rootClass.world.getAchievement(params[1], params[2])), "SERVER", "", 0);
                            };
                            break;
                        case "seta":
                            if (((rootClass.world.myAvatar.isStaff()) && ((params.length == 4)))){
                                rootClass.world.setAchievement(params[1], params[2], params[3]);
                            };
                            break;
                        case "queststring":
                            if (rootClass.world.myAvatar.isStaff()){
                                rootClass.world.loadQuestStringData();
                                cmd = "cmd";
                                i = 0;
                                while (i < params.length) {
                                    xtArr.push(params[i]);
                                    i = (i + 1);
                                };
                            };
                            break;
                        case "e":
                        case "me":
                        case "em":
                            if (((!((typeof(params[1]) == "undefined"))) && ((params[1].length > 0)))){
                                emStr = params.slice(1).join(" ");
                                emStr = cleanStr(emStr, false, true);
                                rmId = chn.cur.rid;
                                cmd = "em";
                                xtArr.push(emStr);
                                xtArr.push(chn.event.str);
                            };
                            break;
                        case "who":
                            break;
                        case "afk":
                            cmd = null;
                            rootClass.world.afkToggle();
                            break;
                        case "fly":
                            cmd = null;
                            rootClass.world.flyToggle();
                            break;
                        case "rest":
                            rootClass.world.rest();
                            break;
                        case "repairavatars":
                            cmd = null;
                            rootClass.world.repairAvatars();
                            break;
                        case "dance":
                        case "laugh":
                        case "lol":
                        case "point":
                        case "use":
                        case "backflip":
                        case "sleep":
                        case "jump":
                        case "punt":
                        case "dance2":
                        case "swordplay":
                        case "feign":
                        case "wave":
                        case "bow":
                        case "cry":
                        case "unsheath":
                        case "cheer":
                        case "stern":
                        case "salute":
                        case "airguitar":
                        case "facepalm":
                            uVars = {};
                            cmd = (uVars.typ = "emotea");
                            uVars.strEmote = paramStr;
                            if (uVars.strEmote == "lol"){
                                uVars.strEmote = "laugh";
                            };
                            uVars.strChar = params[1];
                            break;
                        default:
                            if ((((unm == "iterator")) || (rootClass.world.myAvatar.isStaff()))){
                                cmd = "cmd";
                                index = 0;
                                while (index < params.length) {
                                    xtArr.push(params[index]);
                                    index = (index + 1);
                                };
                            };
                    };
                }
                else {
                    if (typ != "whisper"){
                        rmId = chn.cur.rid;
                        cmd = "message";
                        msg = cleanStr(msg, false, true);
                        xtArr.push(msg);
                        xtArr.push(chn.cur.str);
                    }
                    else {
                        rmId = 1;
                        cmd = "whisper";
                        msg = cleanStr(msg, false, true);
                        xtArr.push(msg);
                        xtArr.push(unm);
                    };
                };
                if (cmd == "emotea"){
                    rootClass.world.myAvatar.pMC.mcChar.gotoAndPlay(rootClass.strToProperCase(uVars.strEmote));
                    rootClass.sfc.sendXtMessage("zm", cmd, [uVars.strEmote], "str", 1);
                }
                else {
                    if ((((cmd == "mod")) || ((cmd == "cmd")))){
                        if (xtArr.length){
                            rootClass.sfc.sendXtMessage("zm", cmd, xtArr, "str", 1);
                            if (isMulti){
                                trace("** submitMsg multi ");
                                for each (multiO in rootClass.sfcA) {
                                    trace(("    > " + multiO.sIP));
                                    multiO.sfc.sendXtMessage("zm", cmd, xtArr, "str", 1);
                                };
                            };
                        };
                    }
                    else {
                        if (cmd != "simple"){
                            if (!(((cmd == null)) || ((xtArr.length < 1)))){
                                if (!rootClass.serialCmdMode){
                                    rootClass.world.afkPostpone();
                                    profanityResult = profanityCheck(cleanStr(msg));
                                    myAvatar = rootClass.world.myAvatar;
                                    if (iChat == 0){
                                        pushMsg("warning", "This server only allows canned chat.", "SERVER", "", 0);
                                    }
                                    else {
                                        if ((((((((iChat == 1)) && (!(myAvatar.hasUpgraded())))) && (!(myAvatar.isMASUpgraded())))) && (!(myAvatar.isStaff())))){
                                            pushMsg("warning", "Chat is a members-only feature at this time.", "SERVER", "", 0);
                                        }
                                        else {
                                            if (((((((!(myAvatar.hasUpgraded())) && (!(myAvatar.isMASUpgraded())))) && (!(myAvatar.isStaff())))) && (!(myAvatar.isEmailVerified())))){
                                                if (int(myAvatar.objData.iAge) < 13){
                                                    pushMsg("warning", "Upgrade is required to chat in this server.", "SERVER", "", 0);
                                                }
                                                else {
                                                    pushMsg("warning", "Email Verification required to chat in this server.", "SERVER", "", 0);
                                                };
                                            }
                                            else {
                                                if (myAvatar.objData.bPermaMute == 1){
                                                    pushMsg("warning", "You are muted! Chat privileges have been permanently revoked.", "SERVER", "", 0);
                                                }
                                                else {
                                                    if (((!((myAvatar.objData.dMutedTill == null))) && ((myAvatar.objData.dMutedTill.getTime() > rootClass.date_server.getTime())))){
                                                        iDiff = ((myAvatar.objData.dMutedTill.getTime() - rootClass.date_server.getTime()) / 1000);
                                                        iHrs = (iDiff / (60 * 60));
                                                        iMins = ((iDiff - ((iHrs * 60) * 60)) / 60);
                                                        pushMsg("warning", (((("You are muted! Chat privileges have been revoked for next " + iHrs) + " h ") + iMins) + " m."), "SERVER", "", 0);
                                                    }
                                                    else {
                                                        if (amIMute()){
                                                            pushMsg("warning", "You are muted! Chat privileges have been temporarily revoked.", "SERVER", "", 0);
                                                        }
                                                        else {
                                                            if (profanityResult.code == 1){
                                                                pushMsg("warning", (("Do not use inappropriate language such as '" + profanityResult.term) + "'."), "SERVER", "", 0);
                                                                rootClass.world.selfMute(2);
                                                            }
                                                            else {
                                                                if (profanityResult.code == 2){
                                                                    pushMsg("warning", (("Please do not use inappropriate language such as '" + profanityResult.term) + "'."), "SERVER", "", 0);
                                                                }
                                                                else {
                                                                    if (isUnsendable(msg)){
                                                                        pushMsg("warning", "Please do not send messages that may contain private information, such as an email address.", "SERVER", "", 0);
                                                                    }
                                                                    else {
                                                                        if (xtArr[0].length > 0){
                                                                            rootClass.sfc.sendXtMessage("zm", cmd, xtArr, "str", rmId);
                                                                        };
                                                                    };
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                }
                                else {
                                    rootClass.sfc.sendXtMessage("zm", cmd, xtArr, "str", rmId);
                                    if (isMulti){
                                        trace("** submitMsg multi ");
                                        for each (multiO in rootClass.sfcA) {
                                            trace(("    > " + multiO.sIP));
                                            try {
                                                if (multiO.sfc.isConnected){
                                                    multiO.sfc.sendXtMessage("zm", cmd, xtArr, "str", -1);
                                                };
                                            }
                                            catch(e:Error) {
                                                trace(((("MULTI error on handler for " + multiO.sIP) + " >> ") + e));
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (!rootClass.serialCmdMode){
                closeMsgEntry();
            };
        }
        private function getRoomType(chn){
            if (chn.indexOf("trade") > -1){
                return ("trade");
            };
            if (chn.indexOf("party") > -1){
                return ("party");
            };
            return ("zone");
        }
        public function isIgnored(strName:String):Boolean{
            return ((ignoreList.data.users.indexOf(strName.toLowerCase()) >= 0));
        }
        private function removeHTML(str:String):String{
            var s:String;
            s = "";
            s = (s + str);
            if (s.indexOf("&nbsp;") > -1){
                s = s.split("&nbsp;").join(" ");
            };
            if (s.indexOf("<br>") > -1){
                s = s.split("<br>").join(" ");
            };
            return (s);
        }
        public function mapChannels(args){
            var i:*;
            var str:*;
            resetAreaChannels();
            i = 0;
            while (i < args.length) {
                str = args[i].split(",")[0].toString();
                if (str.indexOf("trade") > -1){
                    chn.trade.rid = rootClass.sfc.getRoom(str).getId();
                    chn.trade.act = 1;
                };
                i++;
            };
            chn.zone.act = 1;
        }
        private function setFieldsVPos(){
            var t:*;
            t = mci.t1;
            if (t.resetVPos){
                panelIndex = (t1Arr.length - 1);
            };
            panelIndex = Math.min(panelIndex, (t1Arr.length - 1));
        }
        function openPMsg(unm){
            pmNm = unm;
            chn.cur = chn.whisper;
            openMsgEntry();
        }
        function popBubble(avtnm, msg, typ){
            var char:*;
            var actTyp:*;
            char = null;
            actTyp = avtnm.split(":")[0];
            avtnm = avtnm.substr(2);
            switch (actTyp){
                case "u":
                    char = rootClass.world.getMCByUserName(avtnm);
                    break;
            };
            if (char != null){
                char.bubble.ti.autoSize = TextFieldAutoSize.CENTER;
                char.bubble.ti.wordWrap = true;
                char.bubble.ti.htmlText = msg;
                char.bubble.bg.width = int((char.bubble.ti.textWidth + 12));
                char.bubble.bg.height = int((char.bubble.ti.textHeight + 8));
                char.bubble.y = ((char.pname.y - char.bubble.bg.height) - 4);
                char.bubble.bg.x = (0 - (char.bubble.bg.width / 2));
                char.bubble.arrow.y = ((char.bubble.bg.y + char.bubble.bg.height) - 2);
                char.bubble.visible = true;
                char.bubble.alpha = 100;
                if (char.kv == null){
                    char.kv = new Killvis();
                    char.kv.kill(char.bubble, 3000);
                }
                else {
                    char.kv.resetkill();
                };
            };
        }
        private function onFocusOut(event:FocusEvent):void{
            mci.tebg.ring.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        }
        private function checkPos(tl:MovieClip, i:int, id:int, index:int):int{
            var tfp:DisplayObject;
            tfp = getBitmapByIndex((id + 1), mci.t1);
            if (((!((tfp == null))) && ((i < index)))){
                return (((tfp.y - tl.height) + 2));
            };
            return (Math.round((tfHeight - tl.height)));
        }
        public function updateMsgEntry(){
            mci.te.x = ((mci.tt.x + mci.tt.textWidth) + ((mci.tt.text.length) ? 1 : 0));
            mci.te.width = ((mci.bsend.x - mci.te.x) - 3);
            mci.te.textColor = "0xFFFFFF";
            mci.tt.textColor = "0xFFFFFF";
        }
        private function getCCOption(ccID:String, list:XMLList):XML{
            var i:int;
            var item:XML;
            var recur:XML;
            i = 0;
            while (i < list.length()) {
                item = list[i];
                if (item.children().length() == 0){
                    if (item.attribute("id").toString() == ccID){
                        return (item);
                    };
                }
                else {
                    recur = getCCOption(ccID, item.children());
                    if (recur != null){
                        return (recur);
                    };
                };
                i++;
            };
            return (null);
        }
        public function amIMute():Boolean{
            var r:Boolean;
            var date:Date;
            var iNow:Number;
            r = false;
            if (mute.ts > 0){
                date = new Date();
                iNow = date.getTime();
                if ((iNow - mute.ts) >= mute.cd){
                    mute.ts = 0;
                    mute.cd = 0;
                }
                else {
                    r = true;
                };
            };
            return (r);
        }
        public function strContains(str:String, arr:Array):Boolean{
            var i:int;
            i = 0;
            while (i < arr.length) {
                if (str.indexOf(arr[i]) > -1){
                    return (true);
                };
                i++;
            };
            return (false);
        }
        public function unmuteMe(e:Event=null):void{
            mute.ts = 0;
            mute.cd = 0;
            muteData.clear();
            mute.timer.reset();
            pushMsg("server", "You have been unmuted.  Chat privileges are restored.", "SERVER", "", 0);
        }
        private function startWindowTimer():void{
            var bm:MovieClip;
            bm = mci.bMinMax;
            if (!mci.t1.visible){
                if (bm.fx.currentLabel == "hold"){
                    bm.fx.gotoAndPlay("hold");
                }
                else {
                    bm.fx.gotoAndPlay("in");
                };
            };
        }
        public function bCloseClick(e:MouseEvent){
            mci.t1.visible = false;
        }
        public function getCCText(ccID:String):String{
            var xmlCC:XML;
            xmlCC = getCCOption(ccID, xmlCannedOptions.children());
            if (xmlCC != null){
                return (xmlCC.attribute("text").toString());
            };
            return ("");
        }
        function resetAreaChannels(){
            chn.zone.act = 0;
            chn.trade.act = 0;
        }
        public function formatMsgEntry(uoNm){
            mci.te.setSelection(0, 0);
            if (chn.cur != chn.whisper){
                if (chn.cur == chn.zone){
                    mci.tt.text = "";
                    mci.tt.visible = false;
                }
                else {
                    mci.tt.text = (chn.cur.tag + ": ");
                    mci.tt.visible = true;
                };
            }
            else {
                if ((((typeof(uoNm) == "undefined")) || ((uoNm == "")))){
                    mci.tt.text = "";
                    mci.tt.visible = false;
                }
                else {
                    pmNm = uoNm;
                    mci.tt.text = (("To " + uoNm.toUpperCase()) + ": ");
                    mci.tt.visible = true;
                };
            };
        }
        private function chat_linkHandler(e:TextEvent){
            var func:String;
            var uoNm:String;
            func = String(e.text.split(",")[0]);
            switch (func){
                case "openPMsg":
                    pmMode = 1;
                    uoNm = String(e.text.split(",")[1]);
                    openPMsg(uoNm);
                    break;
            };
        }
        private function chat_tebgClick(e:MouseEvent){
            if (rootClass.stage.focus != mci.te){
                openMsgEntry();
            };
        }
        private function checkFieldsVPos(){
            var t:*;
            t = mci.t1;
            t.resetVPos = 0;
            if (panelIndex == (t1Arr.length - 1)){
                t.resetVPos = 1;
            };
        }
        private function html2Fields(str, op, typ, mID){
            var t:*;
            t = mci.t1;
            switch (op){
                case "=":
                default:
                    t1Arr = [{
                        s:str,
                        id:mID,
                        t:typ
                    }];
                    break;
                case "+=":
                    t1Arr.push({
                        s:str,
                        id:mID,
                        t:typ
                    });
            };
        }
        public function muteMe(dur:int):void{
            var date:Date;
            date = new Date();
            mute.ts = Number(date.getTime());
            mute.cd = dur;
            mute.timer.delay = dur;
            mute.timer.start();
            muteData.data.ts = mute.ts;
            muteData.data.cd = mute.cd;
            muteData.flush();
            pushMsg("warning", "You have been muted! Chat privileges are temporarily revoked.", "SERVER", "", 0);
        }
        function closeMsgEntry(){
            mci.tebg.addEventListener(MouseEvent.CLICK, chat_tebgClick);
            mci.te.text = "";
            mci.tt.text = "";
            mci.te.visible = false;
            mci.tt.visible = false;
            if (pmMode != 2){
                chn.cur = chn.lastPublic;
            };
            mci.te.type = TextFieldType.DYNAMIC;
            rootClass.stage.focus = null;
        }
        private function pmClick(e:MouseEvent):void{
            var mc:*;
            if (e.shiftKey){
                mc = (e.currentTarget as MovieClip);
                openPMsg(mc.str);
            }
            else {
                rootClass.world.onWalkClick();
            };
        }
        public function isChannel(channelStr:String):Boolean{
            var nam:*;
            for (nam in chn) {
                if (nam.toLowerCase() == channelStr.toLowerCase()){
                    return (true);
                };
            };
            return (false);
        }
        public function unignore(strName:String):void{
            var uind:* = undefined;
            var mc:* = undefined;
            var strName:String = strName;
            uind = ignoreList.data.users.indexOf(strName.toLowerCase());
            while (uind > -1) {
                ignoreList.data.users.splice(uind, 1);
                uind = ignoreList.data.users.indexOf(strName.toLowerCase());
            };
            ignoreList.flush();
            mc = rootClass.world.getAvatarByUserName(strName.toLowerCase());
            if (mc != null){
                mc.pMC.ignore.visible = false;
            };
            rootClass.sfc.sendXtMessage("zm", "cmd", ["ignoreList", ignoreList.data.users], "str", 1);
            try {
                if (rootClass.ui.mcOFrame.fData.typ == "userListIgnore"){
                    rootClass.ui.mcOFrame.update();
                };
            }
            catch(e:Error) {
            };
        }
        private function initProfanity():void{
            var arrIgnore:Array;
            var arrForce:Array;
            var i:int;
            var strStrict:String;
            arrIgnore = new Array("butt", "pron", "rape", "tits", "shi t", "shi t");
            arrForce = new Array("as5", "a5s", "a$$", "a5$", "a$5", "as$", "fck", "fkc", "fvk", "fuck", "fvck", "fukk", "fvkk", "sh!t", "sh|t", "sh1t", "shiz");
            i = 0;
            while (i < profanityA.length) {
                strStrict = rootClass.stripWhiteStrict(profanityA[i]);
                if ((((arrIgnore.indexOf(strStrict) == -1)) && ((((strStrict.length > 4)) || ((arrForce.indexOf(strStrict) > -1)))))){
                    profanityB.push(strStrict);
                }
                else {
                    if (profanityA[i].indexOf("*") > -1){
                        profanityB.push(profanityA[i]);
                    };
                };
                i++;
            };
        }
        private function onRollOut(e:MouseEvent){
            var btn:*;
            btn = MovieClip(e.currentTarget);
            btn.bg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
            if (e.currentTarget.mcMoreOptions != null){
                e.currentTarget.mcMoreOptions.visible = false;
            };
        }
        public function writeText(index:int):void{
            var tf:DisplayObject;
            var bmc:MovieClip;
            var drawOK:*;
            var drawA:Array;
            var yPos:int;
            var i:int;
            var id:int;
            drawOK = true;
            drawA = [];
            i = 0;
            id = 0;
            i = (t1Arr.length - 1);
            while (i > -1) {
                if ((((i <= index)) && (drawOK))){
                    id = t1Arr[i].id;
                    tl.ti.htmlText = t1Arr[i].s;
                    formatWithoutTextLinks(tl.ti);
                    yPos = checkPos(tl, i, id, index);
                    if (yPos <= 0){
                        drawOK = false;
                    }
                    else {
                        drawA.push(id);
                        if (drawnA.indexOf(id) > -1){
                            tf = getBitmapByIndex(id, mci.t1);
                        }
                        else {
                            tf = buildTextLinks(tl.ti, t1Arr[i].s, mci.t1, drawnA, id);
                        };
                        tf.y = yPos;
                        MovieClip(tf).mouseEnabled = false;
                        switch (t1Arr[i].t){
                            case "server":
                                tf.filters = [BlueGlow];
                                break;
                            case "warning":
                                tf.filters = [RedGlow];
                                break;
                            default:
                                tf.filters = [BlackGlow];
                        };
                    };
                };
                i--;
            };
            i = 0;
            while (i < drawnA.length) {
                if (drawA.indexOf(drawnA[i]) < 0){
                    tf = getBitmapByIndex(drawnA[i], mci.t1);
                    if (tf != null){
                        mci.t1.removeChild(tf);
                        drawnA.splice(i, 1);
                        i--;
                    };
                };
                i++;
            };
        }
        function onMouseWheelEvent(e:MouseEvent):void{
            var index:*;
            if (mci.t1.hitTestPoint(e.stageX, e.stageY)){
                index = t1Arr.length;
                if (e.delta > 0){
                    if (panelIndex > 0){
                        panelIndex--;
                    };
                }
                else {
                    if (panelIndex < (t1Arr.length - 1)){
                        panelIndex++;
                    };
                };
                writeText(panelIndex);
            };
        }
        private function formatWithoutTextLinks(ti:TextField):void{
            var itemOpen:String;
            var itemClose:String;
            var fa:*;
            var fb:*;
            var fc:*;
            var tempA:String;
            var tempB:String;
            var tempC:String;
            var tempD:String;
            var itemDef:Array;
            var itemType:String;
            var itemName:String;
            var itemIndex:int;
            var itemLink:String;
            var itemEmbed:String;
            itemOpen = "$({";
            itemClose = "})$";
            fa = '<font color="#';
            fb = '">';
            fc = "</font>";
            while ((((ti.htmlText.indexOf(itemOpen) > -1)) && ((ti.htmlText.indexOf(itemClose) > -1)))) {
                tempA = ti.htmlText;
                tempB = tempA.substr(0, tempA.indexOf(itemOpen));
                tempC = tempA.substr((tempA.indexOf(itemClose) + itemClose.length));
                tempD = tempA.substr((tempA.indexOf(itemOpen) + itemOpen.length));
                itemDef = tempD.substr(0, tempD.indexOf(itemClose)).split(",");
                itemType = itemDef[0];
                itemName = itemDef[1];
                itemIndex = ti.text.indexOf(itemOpen);
                switch (itemType){
                    case "user":
                        itemEmbed = itemName.toUpperCase();
                        itemLink = ((((fa + "EFD3A9") + fb) + itemEmbed) + fc);
                        break;
                    case "item":
                    case "quest":
                        itemEmbed = (("[" + itemName) + "]");
                        itemLink = ((((fa + "00CCFF") + fb) + itemEmbed) + fc);
                        break;
                };
                ti.htmlText = ((tempB + itemLink) + tempC);
            };
        }
        private function closeCannedChatTimer(e:TimerEvent){
            closeCannedChat();
        }
        private function onCannedChatOut(e:MouseEvent){
            t.start();
        }
        private function bMinMaxMouseOver(e:MouseEvent){
            var bm:MovieClip;
            bm = (e.currentTarget as MovieClip);
            bm.filters = [rootClass.GlowFilterGold];
        }
        private function bPlusClick(e:MouseEvent){
            var bm:MovieClip;
            bm = mci.bMinMax;
            if ((((bm.fx.currentFrame > 1)) && (!((bm.fx.currentLabel == "out"))))){
                bm.fx.gotoAndPlay("out");
            };
            if (mci.t1.y != t1Tally){
                mci.t1.y = t1Tally;
                tfHeight = (tfHeight + tfdH);
                writeText(panelIndex);
            };
            mci.t1.visible = true;
        }
        public function closeCannedChat():void{
            mcCannedChat.visible = false;
        }
        public function modWhisperCheck(str:String):int{
            var s:String;
            var word:String;
            s = rootClass.stripWhiteStrict(removeHTML(str.toLowerCase()));
            for each (word in modWhisperCheckList) {
                if (s.indexOf(word) > -1){
                    return (1);
                };
            };
            return (0);
        }
        public function ignore(strName:String):void{
            var mc:* = undefined;
            var strName:String = strName;
            if (ignoreList.data.users.indexOf(strName.toLowerCase()) == -1){
                ignoreList.data.users.push(strName.toLowerCase());
                ignoreList.flush();
                mc = rootClass.world.getAvatarByUserName(strName.toLowerCase());
                if (mc != null){
                    mc.pMC.ignore.visible = true;
                };
                rootClass.sfc.sendXtMessage("zm", "cmd", ["ignoreList", ignoreList.data.users], "str", 1);
            };
            try {
                if (rootClass.ui.mcOFrame.fData.typ == "userListIgnore"){
                    rootClass.ui.mcOFrame.update();
                };
            }
            catch(e:Error) {
            };
        }
        private function stopWindowTimer():void{
        }
        function openMsgEntry(){
            pmI = 0;
            myMsgsI = 0;
            stopWindowTimer();
            mci.tebg.addEventListener(MouseEvent.CLICK, chat_tebgClick);
            mci.te.visible = true;
            mci.te.type = TextFieldType.INPUT;
            rootClass.stage.focus = null;
            rootClass.stage.focus = mci.te;
            formatMsgEntry(pmNm);
            updateMsgEntry();
        }
        private function buildTextLinks(ti:TextField, txt:String, mc:MovieClip, drawnA:Array, id:int):DisplayObject{
            var bmc:MovieClip;
            var itemOpen:String;
            var itemClose:String;
            var fa:*;
            var fb:*;
            var fc:*;
            var tlC:*;
            var bm:*;
            var tempA:String;
            var tempB:String;
            var tempC:String;
            var tempD:String;
            var itemDef:Array;
            var itemType:String;
            var itemName:String;
            var itemIndex:int;
            var itemLink:String;
            var itemEmbed:String;
            var itemArgs:Object;
            var ia:*;
            var ib:*;
            var ra:Rectangle;
            var rb:Rectangle;
            var rc:Rectangle;
            var hitBox:MovieClip;
            var hit:*;
            var j:String;
            bmc = new MovieClip();
            bmc.name = ("b" + id);
            itemOpen = "$({";
            itemClose = "})$";
            fa = '<font color="#';
            fb = '">';
            fc = "</font>";
            ti.htmlText = txt;
            while ((((ti.htmlText.indexOf(itemOpen) > -1)) && ((ti.htmlText.indexOf(itemClose) > -1)))) {
                tempA = ti.htmlText;
                tempB = tempA.substr(0, tempA.indexOf(itemOpen));
                tempC = tempA.substr((tempA.indexOf(itemClose) + itemClose.length));
                tempD = tempA.substr((tempA.indexOf(itemOpen) + itemOpen.length));
                itemDef = tempD.substr(0, tempD.indexOf(itemClose)).split(",");
                itemType = itemDef[0];
                itemName = itemDef[1];
                itemIndex = ti.text.indexOf(itemOpen);
                itemArgs = {};
                switch (itemType){
                    case "user":
                        itemEmbed = itemName.toUpperCase();
                        itemLink = ((((fa + "EFD3A9") + fb) + itemEmbed) + fc);
                        itemArgs.callback = pmClick;
                        break;
                    case "item":
                        itemEmbed = (("[" + itemName) + "]");
                        itemLink = ((((fa + "00CCFF") + fb) + itemEmbed) + fc);
                        itemArgs.callback = null;
                        break;
                    case "quest":
                        itemArgs.sName = itemDef[1];
                        itemArgs.QuestID = itemDef[2];
                        itemArgs.iLvl = itemDef[3];
                        itemArgs.unm = itemDef[4];
                        itemEmbed = (("[" + itemName) + "]");
                        itemLink = ((((fa + "00CCFF") + fb) + itemEmbed) + fc);
                        itemArgs.callback = rootClass.world.doCTAClick;
                        break;
                };
                ti.htmlText = ((tempB + itemLink) + tempC);
                ia = itemIndex;
                ib = ((itemIndex + itemEmbed.length) - 1);
                ra = ti.getCharBoundaries(ia);
                rb = ti.getCharBoundaries(ib);
                rc = new Rectangle(ra.x, ra.y, ((rb.x - ra.x) + rb.width), (rb.y + rb.height));
                hitBox = new MovieClip();
                hitBox.graphics.beginFill(52479);
                hitBox.graphics.drawRect(0, 0, rc.width, rc.height);
                hitBox.graphics.endFill();
                hit = bmc.addChild(hitBox);
                hit.alpha = 0;
                hit.x = (ti.x + ra.x);
                hit.y = (ti.y + ra.y);
                for (j in itemArgs) {
                    if (j != "callback"){
                        hit[j] = itemArgs[j];
                    };
                };
                hit.str = itemName;
                hit.buttonMode = true;
                hit.addEventListener(MouseEvent.CLICK, itemArgs.callback, false, 0, true);
            };
            tlC = (tl.constructor as Class);
            bm = new (tlC)();
            bm.ti.htmlText = tl.ti.htmlText;
            bm.ti.autoSize = "left";
            bm.ti.multiline = true;
            MovieClip(bm).mouseEnabled = false;
            MovieClip(bm).mouseChildren = false;
            bm.name = "bmp";
            if (bmc.numChildren > 0){
                bmc.swapChildren(bmc.getChildAt(0), bmc.addChildAt(bm, 0));
            }
            else {
                bmc.addChild(bm);
            };
            drawnA.push(id);
            return (mc.addChild(bmc));
        }
        private function initCannedChat(list:XMLList):MovieClip{
            var mcOptionCnt:MovieClip;
            var maxWidth:Number;
            var i:int;
            var mcIndex:int;
            var bevel:BevelFilter;
            var item:XML;
            var mcOption:*;
            var mc:MovieClip;
            mcOptionCnt = new MovieClip();
            maxWidth = 0;
            i = 0;
            while (i < list.length()) {
                item = list[i];
                mcOption = new CannedOption();
                mcOption.y = (i * 23);
                mcOption.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
                mcOption.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
                mcOption.txtChat.text = item.attribute("display").toString();
                if (mcOption.txtChat.textWidth > maxWidth){
                    maxWidth = mcOption.txtChat.textWidth;
                };
                mcOption.strMsg = item.attribute("text").toString();
                mcOption.id = item.attribute("id").toString();
                mcOptionCnt.addChild(mcOption);
                if (item.children().length() > 0){
                    mcOption.mcMoreOptions = initCannedChat(item.children());
                    mcOption.addChild(mcOption.mcMoreOptions);
                    mcOption.mcMoreOptions.visible = false;
                }
                else {
                    mcOption.mcMore.visible = false;
                    mcOption.addEventListener(MouseEvent.CLICK, onMouseClick);
                };
                i++;
            };
            mcIndex = 0;
            while (mcIndex < mcOptionCnt.numChildren) {
                mc = MovieClip(mcOptionCnt.getChildAt(mcIndex));
                mc.txtChat.width = (maxWidth + 6);
                mc.bg.width = (maxWidth + 25);
                mc.mcMore.x = (mc.bg.width - 10);
                if (mc.mcMoreOptions != null){
                    mc.mcMoreOptions.x = mc.bg.width;
                };
                mcIndex++;
            };
            bevel = new BevelFilter(1, 45, 0, 1, 0, 1, 0, 0, 1, 3);
            mcOptionCnt.filters = [bevel];
            return (mcOptionCnt);
        }
        private function timedWindowHide(e:Event):void{
            mci.t1.visible = false;
        }
        private function getBitmapByIndex(ind:int, mc:DisplayObjectContainer):DisplayObject{
            var bmp:DisplayObject;
            var i:int;
            i = 0;
            while (i < mc.numChildren) {
                if (int(mc.getChildAt(i).name.substr(1)) == ind){
                    bmp = mc.getChildAt(i);
                    return (bmp);
                };
                i++;
            };
            return (null);
        }
        private function onCannedChatOver(e:MouseEvent){
            if (t != null){
                t.reset();
            };
        }
        private function onCannedChatClick(e:MouseEvent):void{
            mcCannedChat.visible = !(mcCannedChat.visible);
        }
        private function bMinusClick(e:MouseEvent){
            var bm:MovieClip;
            bm = mci.bMinMax;
            if ((((bm.fx.currentFrame > 1)) && (!((bm.fx.currentLabel == "out"))))){
                bm.fx.gotoAndPlay("out");
            };
            if (mci.t1.y != t1Shorty){
                mci.t1.y = t1Shorty;
                tfHeight = (tfHeight - tfdH);
                writeText(panelIndex);
            };
            mci.t1.visible = true;
        }
        private function isMyModHandle(strName:String):Boolean{
            if ((((strName.split("-")[0] == "Moderator")) && (int((strName.split("-")[1] == rootClass.world.modID))))){
                return (true);
            };
            return (false);
        }
        private function onRollOver(e:MouseEvent){
            var btn:*;
            var mc:*;
            var clickPoint:Point;
            var newPoint:Point;
            btn = MovieClip(e.currentTarget);
            btn.bg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 25, 25, 25, 0);
            if (e.currentTarget.mcMoreOptions != null){
                e.currentTarget.mcMoreOptions.visible = true;
                mc = e.currentTarget;
                clickPoint = new Point(mc.x, ((mc.y + mc.mcMoreOptions.y) + (mc.mcMoreOptions.numChildren * 23)));
                newPoint = mcCannedChat.localToGlobal(clickPoint);
                if (newPoint.y > 505){
                    mc.mcMoreOptions.y = (mc.mcMoreOptions.y - (newPoint.y - 505));
                };
            };
        }

    }
}//package 

