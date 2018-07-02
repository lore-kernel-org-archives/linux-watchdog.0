Return-Path: <baofeng.tian@intel.com>
Return-path: <baofeng.tian@intel.com>
From: "Tian, Baofeng" <baofeng.tian@intel.com>
To: "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Tian, Baofeng" <baofeng.tian@intel.com>
Subject: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
Date: Mon, 2 Jul 2018 07:30:10 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEBshsmsx102ccrcor_"
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

--_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEBshsmsx102ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: "Tian, Baofeng" <baofeng.tian@intel.com<mailto:baofeng.tian@intel.com=
>>
Subject: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO

Setting "force_no_reboot" parameter to true (y/Y/1) will have
the effect to prevent to reset the NO_REBOOT flag thus
preventing the iTCO to reboot the platform, if not set
or set to false, then system will reboot after about 30s.

Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com<mailto:baofeng.tian@in=
tel.com>>
---
 drivers/watchdog/iTCO_wdt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 347f038..255318b 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -131,6 +131,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
 MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
      "Turn off SMI clearing watchdog (depends on TCO-version)(default=3D1)=
");

+static bool force_no_reboot;
+module_param(force_no_reboot, bool, 0);
+MODULE_PARM_DESC(force_no_reboot,
+           "Prevents the watchdog rebooting the platform (default=3D0)");
+
 /*
  * Some TCO specific functions
  */
@@ -243,6 +248,10 @@ static int iTCO_wdt_start(struct watchdog_device *wd_d=
ev)
      struct iTCO_wdt_private *p =3D watchdog_get_drvdata(wd_dev);
      unsigned int val;

+     /* force_no_reboot will prevent to unset NO_REBOOT bit */
+     if (force_no_reboot)
+           return -EIO;
+
      spin_lock(&p->io_lock);

      iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
@@ -250,7 +259,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_de=
v)
      /* disable chipset's NO_REBOOT bit */
      if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
            spin_unlock(&p->io_lock);
-           pr_err("failed to reset NO_REBOOT flag, reboot disabled by hard=
ware/BIOS\n");
+           pr_err("failed to reset NO_REBOOT flag, reboot disabled by hard=
ware/BIOS/rc_cmd\n");
            return -EIO;
      }

--
2.7.4


--_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEBshsmsx102ccrcor_
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
Subject: [PATCH] watchdog: add module parameter &quot;force_no_reboot&quot;=
 for iTCO<br>
<br>
Setting &quot;force_no_reboot&quot; parameter to true (y/Y/1) will have<br>
the effect to prevent to reset the NO_REBOOT flag thus<br>
preventing the iTCO to reboot the platform, if not set<br>
or set to false, then system will reboot after about 30s.<br>
<br>
Signed-off-by: Tian, Baofeng &lt;<a href=3D"mailto:baofeng.tian@intel.com">=
baofeng.tian@intel.com</a>&gt;<br>
---<br>
&nbsp;drivers/watchdog/iTCO_wdt.c | 11 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;-<br>
&nbsp;1 file changed, 10 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c<br>
index 347f038..255318b 100644<br>
--- a/drivers/watchdog/iTCO_wdt.c<br>
&#43;&#43;&#43; b/drivers/watchdog/iTCO_wdt.c<br>
@@ -131,6 &#43;131,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);=
<br>
&nbsp;MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Turn off SMI clearing watchdog (depend=
s on TCO-version)(default=3D1)&quot;);<br>
&nbsp;<br>
&#43;static bool force_no_reboot;<br>
&#43;module_param(force_no_reboot, bool, 0);<br>
&#43;MODULE_PARM_DESC(force_no_reboot,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Pre=
vents the watchdog rebooting the platform (default=3D0)&quot;);<br>
&#43;<br>
&nbsp;/*<br>
&nbsp; * Some TCO specific functions<br>
&nbsp; */<br>
@@ -243,6 &#43;248,10 @@ static int iTCO_wdt_start(struct watchdog_device *=
wd_dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct iTCO_wdt_private *p =3D watchdog_get_=
drvdata(wd_dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int val;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; /* force_no_reboot will prevent to unset NO_R=
EBOOT bit */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; if (force_no_reboot)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -E=
IO;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;p-&gt;io_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iTCO_vendor_pre_start(p-&gt;smi_res, wd_dev-=
&gt;timeout);<br>
@@ -250,7 &#43;259,7 @@ static int iTCO_wdt_start(struct watchdog_device *w=
d_dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable chipset's NO_REBOOT bit */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;update_no_reboot_bit(p-&gt;no_rebo=
ot_priv, false)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unl=
ock(&amp;p-&gt;io_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;=
failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n&quot;);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&q=
uot;failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS/rc_cmd=
\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -=
EIO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.7.4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEBshsmsx102ccrcor_--
