import module namespace jam="http://xqdev.com/jam" at "jam.xqy"

xdmp:set-response-content-type("text/plain"),


jam:start("http://localhost:8080/mljam", "admin", "secret")
,

let $var := xs:anyURI("http://foo.com/bar?x=y")
let $set := jam:set("var", $var)
let $get := jam:get("var")
return string($var) = $get
,

let $var := ()
let $set := jam:set("var", $var)
let $get := jam:get("var")
return empty($get)
,

let $s := "The quick brown fox!"
let $var := xs:base64Binary(xdmp:base64-encode($s))
let $set := jam:set("var", $var)
let $get := jam:get("var")
return $s = xdmp:quote($get)
,

let $set := jam:set("var1", true())
let $set := jam:set("var2", false())
let $get1 := jam:get("var1")
let $get2 := jam:get("var2")
return $get1 = true() and $get2 = false()
,

let $set := jam:set("date", current-date())
let $set := jam:set("datetime", current-dateTime())
let $set := jam:set("time", current-time())
return jam:get("date") = current-date() and
       jam:get("datetime") = current-dateTime() and
       jam:get("time") = current-time()
,

let $set := jam:set("dec1", xs:decimal("1"))
let $set := jam:set("dec2", xs:decimal("100000.001"))
return jam:get("dec1") = xs:decimal("1") and
       jam:get("dec2") = xs:decimal("100000.001")
,

let $set := jam:set("dbl1", xs:double("1"))
let $set := jam:set("dbl2", xs:double("INF"))
let $set := jam:set("dbl3", xs:double("-INF"))
let $set := jam:set("dbl4", xs:double(number()))
return jam:get("dbl1") = xs:double("1") and
       jam:get("dbl2") = xs:double("INF") and
       jam:get("dbl3") = xs:double("-INF") and
       string(jam:get("dbl4")) = "NaN"
,

let $set := jam:set("flt1", xs:float("1"))
let $set := jam:set("flt2", xs:float("INF"))
let $set := jam:set("flt3", xs:float("-INF"))
let $set := jam:set("flt4", xs:float(number()))
return jam:get("flt1") = xs:float("1") and
       jam:get("flt2") = xs:float("INF") and
       jam:get("flt3") = xs:float("-INF") and
       string(jam:get("flt4")) = "NaN"
,

let $set := jam:set("dur1a", xdt:dayTimeDuration("P1DT10H5M2S"))
let $set := jam:set("dur1b", xdt:dayTimeDuration("-P1DT10H5M2S"))
let $set := jam:set("dur2a", xdt:yearMonthDuration("P1001Y9M"))
let $set := jam:set("dur2b", xdt:yearMonthDuration("-P1001Y9M"))
let $set := jam:set("dur3a", xs:duration("P1Y2D3M4DT5H6M7S"))
let $set := jam:set("dur3b", xs:duration("-P1Y2D3M4DT5H6M7S"))
return jam:get("dur1a") = xdt:dayTimeDuration("P1DT10H5M2S") and
       jam:get("dur1b") = xdt:dayTimeDuration("-P1DT10H5M2S") and
       jam:get("dur2a") = xdt:yearMonthDuration("P1001Y9M") and
       jam:get("dur2b") = xdt:yearMonthDuration("-P1001Y9M") and
       xdmp:describe(jam:get("dur3a")) =
          xdmp:describe(xs:duration("P1Y2D3M4DT5H6M7S")) and
       xdmp:describe(jam:get("dur3b")) =
          xdmp:describe(xs:duration("-P1Y2D3M4DT5H6M7S"))
,

let $set := jam:set("i", xs:int(5))
return xdmp:describe(jam:get("i")) = xdmp:describe(xs:int(5))
,

let $set := jam:set("i", xs:integer(1e90))
return xdmp:describe(jam:get("i")) = xdmp:describe(xs:integer(1e90))
,

let $set := jam:set("q", xs:QName("fn:hi"))
return xdmp:describe(jam:get("q")) = xdmp:describe(xs:QName("fn:hi"))
,

let $set := jam:set("empty", "")
let $set := jam:set("simple", "123")
return jam:get("empty") = "" and
       jam:get("simple") = "123" and
       jam:get("simple") instance of xs:string
,

let $set := jam:set("newline", "
")
return jam:get("newline") = "
" and jam:get("newline") instance of xs:string
,

let $set := jam:set("gday", xs:gDay("01"))
(: let $set := jam:set("gmonth", xs:gMonth("01")) :)
let $set := jam:set("gyear", xs:gYear("2001"))
let $set := jam:set("gyearmonth", xs:gYearMonth("2006-04"))
let $set := jam:set("gmonthday", xs:gMonthDay("01-02"))
return
  xdmp:describe(jam:get("gday")) = xdmp:describe(xs:gDay("01")) and
  (: xdmp:describe(jam:get("gmonth")) = xdmp:describe(xs:gMonth("01")) and :)
  xdmp:describe(jam:get("gyear")) = xdmp:describe(xs:gYear("2001")) and
  xdmp:describe(jam:get("gyearmonth")) = xdmp:describe(xs:gYearMonth("2006-04")) and
  xdmp:describe(jam:get("gmonthday")) = xdmp:describe(xs:gMonthDay("01-02"))
,

(: xdt:untypedAtomic -> String -> xs:string :)
let $set := jam:set("untyped", data(<foo>mixed<b>content</b></foo>))
let $set := jam:set("untypedempty", data(<foo></foo>))
return
  jam:get("untyped") = data(<foo>mixed<b>content</b></foo>) and
  jam:get("untypedempty") = data(<foo></foo>)
,

(: xdt:untypedAtomic -> String -> xs:string :)
let $set := jam:set("untypednewline", xdt:untypedAtomic("
"))
return
jam:get("untypednewline") = xdt:untypedAtomic("
")
,

(: attribute() -> String -> xs:string :)
let $set := jam:set("attr", attribute fn:name { "value" })
return jam:get("attr") = attribute fn:name { "value" }
,

(: element() -> String -> xs:string :)
let $elt := <foo>x<fn:kid/> y</foo>
let $set := jam:set("elt", $elt)
return jam:get("elt") = xdmp:quote($elt)
,

(: document-node() -> String -> xs:string :)
let $doc := document { <foo>x<fn:kid/> y</foo> }
let $set := jam:set("doc", $doc)
return jam:get("doc") = xdmp:quote($doc)
,

(: comment() -> String -> xs:string :)
let $c := comment { "two 
liner" }
let $set := jam:set("c", $c)
return jam:get("c") = xdmp:quote($c)
,

(: processing-instruction() -> String -> xs:string :)
let $pi := processing-instruction targ { "two
liner" }
let $set := jam:set("pi", $pi)
return jam:get("pi") = xdmp:quote($pi)
,

(: text() -> String -> xs:string :)
let $t := text { "two
liner" }
let $set := jam:set("t", $t)
return jam:get("t") = xdmp:quote($t)
,

(: empty binary() -> byte[] -> binary() :)
let $empty := binary { "" }
let $set := jam:set("empty", $empty)
let $len := jam:eval('len = empty.length;')
return jam:get("empty") = $empty and
       jam:get("len") = 0
,

(: binary() -> byte[] -> binary() :)
let $jpg := binary { "FFD8FFE000104A4649460001" }
let $set := jam:set("jpg", $jpg)
let $len := jam:eval('len = jpg.length;')
return jam:get("jpg") = $jpg and
       jam:get("len") = 12
,

(: xs:hexBinary -> byte[] -> binary() :)
let $jpgbin := binary { "FFD8FFE000104A4649460001" }
let $jpghex := xs:hexBinary("FFD8FFE000104A4649460001")
let $set := jam:set("jpghex", $jpghex)
let $len := jam:eval('len = jpghex.length;')
return jam:get("jpghex") = $jpgbin and
       jam:get("len") = 12
,

(: xs:base64Binary -> byte[] -> binary() :)
let $src := "The quick brown fox!"
let $encoded := xdmp:base64-encode($src)
let $base64 := xs:base64Binary($encoded)
let $set := jam:set("base64", $base64)
return jam:get("base64") instance of binary() and
       xdmp:quote(jam:get("base64")) = $src
,

(: Let's try a string array :)
let $arr := ("abc", "def", "xyz")
let $set := jam:set("a", $arr)
return deep-equal(jam:get("a"), $arr)
,

(: A heterogenous array :)
let $arr := ("abc", 1, 1.0,
             current-dateTime(), current-date(), current-time(),
             xs:gDay("01"), xs:QName("fn:hi"),
             xs:float("INF"), xs:double("0"), xs:double(-0.0))
let $set := jam:set("a", $arr)
return deep-equal(jam:get("a"), $arr)
,

(: A Date from Java, make sure the cast works :)
let $go := jam:eval('d = new Date();')
let $dt := xs:dateTime(jam:get("d"))
return true()
,

(: Make sure unset works :)
let $set := jam:set("x", 5)
let $first := jam:get("x")
let $unset := jam:unset("x")
let $second := jam:get("x")
return $first = 5 and empty($second)
,

(: Test get-stdout for print() capture :)
(: This doesn't work for System.out.println() reliably, so we skip that :)
let $clearanyold := jam:get-stdout()
let $ev := jam:eval('print("hey stdout");')
let $full := jam:get-stdout()
let $clearagain := jam:get-stdout()
return
  $clearanyold = "" and
  $full = ("hey stdout&#xA;","hey stdout&#xD;&#xA;") and
  $clearagain = ""
,

(: Test get-stderr for error() capture :)
(: Note that bsh adds '// Error: ' so we account for that :)
(: This doesn't work for System.err.println() reliably, so we skip that :)
let $clearanyold := jam:get-stderr()
let $ev := jam:eval('error("hey stderr");')
let $full := jam:get-stderr()
let $clearagain := jam:get-stderr()
return
  $clearanyold = "" and
  $full = ("// Error: hey stderr&#xA;","// Error: hey stderr&#xD;&#xA;") and
  $clearagain = ""
,

(: Test source() -- This requires a loadme.bsh in the given dir,
   so I commented it out for portability. :)
(:
let $src := jam:source("c:\packages\beanshell-2.0b4\loadme.bsh")
let $run := jam:eval("val = foo();")
let $val := jam:get("val")
return contains($val, "roar")
,
:)

(: Make sure diff contexts work properly :)
let $start := jam:start-in("http://localhost:8080/mljam", "admin", "secret", "one")
let $start := jam:start-in("http://localhost:8080/mljam", "admin", "secret", "two")
let $set := jam:set-in("x", 100, "one")
let $set := jam:set-in("x", 200, "two")
let $eval := jam:eval-in("y = x*2;", "one")
let $eval := jam:eval-in("y = x*3;", "two")
let $print := jam:eval-in('print("I am one");', "one")
let $print := jam:eval-in('print("I am two");', "two")
let $print := jam:eval-in('print("I am one again");', "one")
let $print := jam:eval-in('print("I am two again");', "two")
let $stdout-one := jam:get-stdout-in("one")
let $stdout-two := jam:get-stdout-in("two")
return jam:get-in("x", "one") = 100 and
       jam:get-in("x", "two") = 200 and
       jam:get-in("y", "one") = 200 and
       jam:get-in("y", "two") = 600 and
       $stdout-one = ("I am one&#xA;I am one again&#xA;",
                      "I am one&#xD;&#xA;I am one again&#xD;&#xA;") and
       $stdout-two = ("I am two&#xA;I am two again&#xA;",
                      "I am two&#xD;&#xA;I am two again&#xD;&#xA;")
,

(: Now close the two contexts down :)
jam:end-in("one"),
jam:end-in("two"),

(: Given our current semantics, gets will now return empty not error :)
empty((jam:get-in("x", "one"), jam:get-in("x", "two")))
,

(: Test the 10k circular capture limit :)
let $clearanyold := jam:get-stdout()
(: A string that's 10241, plus \n or \r\n will definitely wrap :)
let $bigstring := concat("abcd", string-pad("x", 10236), "e")
let $set := jam:set("big", $bigstring)
let $setup := jam:eval('print(big);')
let $result := jam:get-stdout()
return 
  (ends-with($result, "xxxe&#xA;") or ends-with($result, "xxxe&#xD;&#xA;")) and
  starts-with($result, "dxxx") and
  string-length($result) = 10240
,

(: Simple JDOM element fetch :)
let $eval := jam:eval('e = new org.jdom.Element("foo").setText("1");')
return deep-equal(jam:get("e"), <foo>1</foo>)
,

(: Tricky JDOM element fetch :)
let $eval := jam:eval('e = new org.jdom.Element("foo").setText("1<2");')
return deep-equal(jam:get("e"), <foo>1&lt;2</foo>)
,

(: Simple JDOM document fetch :)
let $eval := jam:eval('d = new org.jdom.Document(new org.jdom.Element("foo").setText("1"));')
return deep-equal(jam:get("d"), document { <foo>1</foo> })
,

(: Tricky JDOM document fetch :)
let $eval := jam:eval('d = new org.jdom.Document(new org.jdom.Element("foo").setText("1<2"));')
return deep-equal(jam:get("d"), document { <foo>1&lt;2</foo> })
,

(: Namespaced JDOM attribute fetch :)
let $eval := jam:eval('a = new org.jdom.Attribute("name", "value",
               org.jdom.Namespace.getNamespace("x", "http://uri.com"));')
return deep-equal(jam:get("a"),
              <foo xmlns:x="http://uri.com" x:name="value"/>/@*:name)
,

(: JDOM Text node :)
let $eval := jam:eval('t = new org.jdom.Text("testing 1, 2, 3...");')
return jam:get("t") = "testing 1, 2, 3..."
,

(: JDOM PI node :)
let $eval := jam:eval('pi = new org.jdom.ProcessingInstruction("x", "y");')
return deep-equal(jam:get("pi"), <?x y?>)
,

(: JDOM Comment node :)
let $eval := jam:eval('c = new org.jdom.Comment("foo bar");')
return deep-equal(jam:get("c"), <!--foo bar-->)
,

(: Run eval-get through its paces :)
jam:eval-get('1+1') = 2
,
jam:eval-get('x = "1"; y = "2";') = "2"
,
deep-equal(
  jam:eval-get('x = "1"; y = new String[] { "a", "b" };'),
  ("a", "b")
)
,
let $bytes := jam:eval-get('x = "1"; y = new byte[] { 65, 66 };')
return $bytes instance of binary() and
       xdmp:quote($bytes) = "AB"
,

jam:end()
