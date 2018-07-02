Return-Path: <baofeng.tian@intel.com>
Return-path: <baofeng.tian@intel.com>
From: "Tian, Baofeng" <baofeng.tian@intel.com>
To: "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Tian, Baofeng" <baofeng.tian@intel.com>
Subject: [PATCH] watchdog: add NMI handler for iTCO watchdog
Date: Mon, 2 Jul 2018 08:15:40 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E1C063@shsmsx102.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE7E@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <0038B620BAC72941BCBF48AEB892976C02CADE7E@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1C063shsmsx102ccrcor_"
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

--_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1C063shsmsx102ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: "Tian, Baofeng" <baofeng.tian@intel.com<mailto:baofeng.tian@intel.com=
>>
Subject: [PATCH] watchdog: add NMI handler for iTCO watchdog

Add a NMI handler in iTCO watchdog driver probe.
When iTCO watchdog timeout, it gernerate a NMI interrupt.
The NMI handler will be called when iTCO NMI interrupt triggered.

In the NMI handler, it will dump all cpu backtraces
and call panic to continue reboot.

Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com<mailto:baofeng.tian@in=
tel.com>>
---
 drivers/watchdog/iTCO_wdt.c | 53 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 347f038..7a79d0f 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -68,6 +68,8 @@
 #include <linux/io.h>              /* For inb/outb/... */
 #include <linux/platform_data/itco_wdt.h>

+#include <linux/nmi.h>
+#include <asm/nmi.h>
 #include "iTCO_vendor.h"

 /* Address definitions for the TCO */
@@ -86,6 +88,11 @@
 #define TCO2_CNT(p)    (TCOBASE(p) + 0x0a) /* TCO2 Control Register    */
 #define TCOv2_TMR(p)   (TCOBASE(p) + 0x12) /* TCOv2 Timer Initial Value*/

+#define TCO_RLD_sub(base)    (base + 0x00) /* TCO Timer Reload/Curr. Value=
 */
+#define TCO1_STS_sub(base)   (base + 0x04) /* TCO1 Status Register     */
+#define TCOv2_TMR_sub(base)  (base + 0x12) /* TCOv2 Timer Initial Value*/
+
+
 /* internal variables */
 struct iTCO_wdt_private {
      struct watchdog_device wddev;
@@ -112,6 +119,14 @@ struct iTCO_wdt_private {
      int (*update_no_reboot_bit)(void *p, bool set);
 };

+static struct {
+     resource_size_t tco_base_address;
+     unsigned int iTCO_version;
+     bool pretimeout_occurred;
+     unsigned int second_to_ticks;
+} iTCO_wdt_sub;
+
+
 /* module parameters */
 #define WATCHDOG_TIMEOUT 30  /* 30 sec default heartbeat */
 static int heartbeat =3D WATCHDOG_TIMEOUT;  /* in seconds */
@@ -422,6 +437,33 @@ static const struct watchdog_ops iTCO_wdt_ops =3D {
      .get_timeleft =3D         iTCO_wdt_get_timeleft,
 };

+static int iTCO_pretimeout(unsigned int cmd, struct pt_regs *unused_regs)
+{
+     resource_size_t tco_base_address;
+
+     /* Prevent re-entrance */
+     if (iTCO_wdt_sub.pretimeout_occurred)
+           return NMI_HANDLED;
+
+           tco_base_address =3D iTCO_wdt_sub.tco_base_address;
+
+     /* Check the NMI is from the TCO first expiration */
+     if (inw(TCO1_STS_sub(tco_base_address)) & 0x8) {
+           iTCO_wdt_sub.pretimeout_occurred =3D true;
+
+           /* Forward next expiration */
+           outw(iTCO_wdt_sub.second_to_ticks, TCOv2_TMR_sub(tco_base_addre=
ss));
+           outw(0x01, TCO_RLD_sub(tco_base_address));
+
+           trigger_all_cpu_backtrace();
+           panic_timeout =3D 0;
+           panic("Kernel Watchdog");
+           return NMI_HANDLED;
+     }
+
+     return NMI_DONE;
+}
+
 /*
  *   Init & exit routines
  */
@@ -555,6 +597,17 @@ static int iTCO_wdt_probe(struct platform_device *pdev=
)
            return ret;
      }

+    /* init vars that used for nmi handler */
+     iTCO_wdt_sub.iTCO_version =3D p->iTCO_version;
+     iTCO_wdt_sub.second_to_ticks =3D seconds_to_ticks(p, 10);
+     iTCO_wdt_sub.tco_base_address =3D TCOBASE(p);
+
+     ret =3D register_nmi_handler(NMI_LOCAL, iTCO_pretimeout, 0, "iTCO_wdt=
");
+     if (ret !=3D 0) {
+           pr_err("cannot register nmi handler (err=3D%d)\n", ret);
+           return ret;
+     }
+
      pr_info("initialized. heartbeat=3D%d sec (nowayout=3D%d)\n",
            heartbeat, nowayout);

--
2.7.4


--_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1C063shsmsx102ccrcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:Consolas;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText" style=3D"margin-bottom:12.0pt"><span style=3D"fon=
t-family:&quot;Courier New&quot;">From: &quot;Tian, Baofeng&quot; &lt;<a hr=
ef=3D"mailto:baofeng.tian@intel.com">baofeng.tian@intel.com</a>&gt;<br>
Subject: [PATCH] watchdog: add NMI handler for iTCO watchdog<br>
<br>
Add a NMI handler in iTCO watchdog driver probe.<br>
When iTCO watchdog timeout, it gernerate a NMI interrupt.<br>
The NMI handler will be called when iTCO NMI interrupt triggered.<br>
<br>
In the NMI handler, it will dump all cpu backtraces<br>
and call panic to continue reboot.<br>
<br>
Signed-off-by: Tian, Baofeng &lt;<a href=3D"mailto:baofeng.tian@intel.com">=
baofeng.tian@intel.com</a>&gt;<br>
---<br>
&nbsp;drivers/watchdog/iTCO_wdt.c | 53 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 53 insertions(&#43;)<br>
<br>
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c<br>
index 347f038..7a79d0f 100644<br>
--- a/drivers/watchdog/iTCO_wdt.c<br>
&#43;&#43;&#43; b/drivers/watchdog/iTCO_wdt.c<br>
@@ -68,6 &#43;68,8 @@<br>
&nbsp;#include &lt;linux/io.h&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For inb/outb/... */<br>
&nbsp;#include &lt;linux/platform_data/itco_wdt.h&gt;<br>
&nbsp;<br>
&#43;#include &lt;linux/nmi.h&gt;<br>
&#43;#include &lt;asm/nmi.h&gt;<br>
&nbsp;#include &quot;iTCO_vendor.h&quot;<br>
&nbsp;<br>
&nbsp;/* Address definitions for the TCO */<br>
@@ -86,6 &#43;88,11 @@<br>
&nbsp;#define TCO2_CNT(p)&nbsp;&nbsp;&nbsp; (TCOBASE(p) &#43; 0x0a) /* TCO2=
 Control Register&nbsp;&nbsp;&nbsp; */<br>
&nbsp;#define TCOv2_TMR(p)&nbsp;&nbsp; (TCOBASE(p) &#43; 0x12) /* TCOv2 Tim=
er Initial Value*/<br>
&nbsp;<br>
&#43;#define TCO_RLD_sub(base)&nbsp;&nbsp;&nbsp; (base &#43; 0x00) /* TCO T=
imer Reload/Curr. Value */<br>
&#43;#define TCO1_STS_sub(base)&nbsp;&nbsp; (base &#43; 0x04) /* TCO1 Statu=
s Register&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;#define TCOv2_TMR_sub(base)&nbsp; (base &#43; 0x12) /* TCOv2 Timer Ini=
tial Value*/<br>
&#43;<br>
&#43;<br>
&nbsp;/* internal variables */<br>
&nbsp;struct iTCO_wdt_private {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct watchdog_device wddev;<br>
@@ -112,6 &#43;119,14 @@ struct iTCO_wdt_private {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*update_no_reboot_bit)(void *p, bool se=
t);<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static struct {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t tco_base_address;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int iTCO_version;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; bool pretimeout_occurred;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int second_to_ticks;<br>
&#43;} iTCO_wdt_sub;<br>
&#43;<br>
&#43;<br>
&nbsp;/* module parameters */<br>
&nbsp;#define WATCHDOG_TIMEOUT 30&nbsp; /* 30 sec default heartbeat */<br>
&nbsp;static int heartbeat =3D WATCHDOG_TIMEOUT;&nbsp; /* in seconds */<br>
@@ -422,6 &#43;437,33 @@ static const struct watchdog_ops iTCO_wdt_ops =3D =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_timeleft =3D&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; iTCO_wdt_get_timeleft,<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static int iTCO_pretimeout(unsigned int cmd, struct pt_regs *unused_re=
gs)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t tco_base_address;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Prevent re-entrance */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; if (iTCO_wdt_sub.pretimeout_occurred)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NM=
I_HANDLED;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tco_base_=
address =3D iTCO_wdt_sub.tco_base_address;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Check the NMI is from the TCO first expira=
tion */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; if (inw(TCO1_STS_sub(tco_base_address)) &amp;=
 0x8) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iTCO_wdt_=
sub.pretimeout_occurred =3D true;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Forwar=
d next expiration */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; outw(iTCO=
_wdt_sub.second_to_ticks, TCOv2_TMR_sub(tco_base_address));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; outw(0x01=
, TCO_RLD_sub(tco_base_address));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trigger_a=
ll_cpu_backtrace();<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; panic_tim=
eout =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; panic(&qu=
ot;Kernel Watchdog&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NM=
I_HANDLED;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; return NMI_DONE;<br>
&#43;}<br>
&#43;<br>
&nbsp;/*<br>
&nbsp; *&nbsp;&nbsp; Init &amp; exit routines<br>
&nbsp; */<br>
@@ -555,6 &#43;597,17 @@ static int iTCO_wdt_probe(struct platform_device *=
pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r=
et;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp; /* init vars that used for nmi handler */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; iTCO_wdt_sub.iTCO_version =3D p-&gt;iTCO_vers=
ion;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; iTCO_wdt_sub.second_to_ticks =3D seconds_to_t=
icks(p, 10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; iTCO_wdt_sub.tco_base_address =3D TCOBASE(p);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D register_nmi_handler(NMI_LOCAL, iTCO_=
pretimeout, 0, &quot;iTCO_wdt&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret !=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&q=
uot;cannot register nmi handler (err=3D%d)\n&quot;, ret);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;initialized. heartbeat=3D%d se=
c (nowayout=3D%d)\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; heartbea=
t, nowayout);<br>
&nbsp;<br>
-- <br>
2.7.4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1C063shsmsx102ccrcor_--
