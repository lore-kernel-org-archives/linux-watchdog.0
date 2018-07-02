Return-Path: <baofeng.tian@intel.com>
Return-path: <baofeng.tian@intel.com>
From: "Tian, Baofeng" <baofeng.tian@intel.com>
To: "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
Date: Mon, 2 Jul 2018 08:18:56 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E1C084@shsmsx102.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE91@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <0038B620BAC72941BCBF48AEB892976C02CADE91@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1C084shsmsx102ccrcor_"
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

--_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1C084shsmsx102ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: "Tian, Baofeng" <baofeng.tian@intel.com<mailto:baofeng.tian@intel.com=
>>
Subject: [PATCH] watchdog: change ITCO_WDT type from tristate to bool

tristate will allow kernel config it to M and build ko file,
this will cause build allmodconfig errors as necessary
symbols have not been exported.
change it to bool, only allow config ITCO_WDT to yes/no.

Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com<mailto:baofeng.tian@in=
tel.com>>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9af07fd..f991e93 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1049,7 +1049,7 @@ config INTEL_MID_WATCHDOG
        To compile this driver as a module, choose M here.

 config ITCO_WDT
-     tristate "Intel TCO Timer/Watchdog"
+     bool "Intel TCO Timer/Watchdog"
      depends on (X86 || IA64) && PCI
      select WATCHDOG_CORE
      depends on I2C || I2C=3Dn
--
2.7.4


--_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1C084shsmsx102ccrcor_
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
Subject: [PATCH] watchdog: change ITCO_WDT type from tristate to bool<br>
<br>
tristate will allow kernel config it to M and build ko file,<br>
this will cause build allmodconfig errors as necessary<br>
symbols have not been exported.<br>
change it to bool, only allow config ITCO_WDT to yes/no.<br>
<br>
Signed-off-by: Tian, Baofeng &lt;<a href=3D"mailto:baofeng.tian@intel.com">=
baofeng.tian@intel.com</a>&gt;<br>
---<br>
&nbsp;drivers/watchdog/Kconfig | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig<br>
index 9af07fd..f991e93 100644<br>
--- a/drivers/watchdog/Kconfig<br>
&#43;&#43;&#43; b/drivers/watchdog/Kconfig<br>
@@ -1049,7 &#43;1049,7 @@ config INTEL_MID_WATCHDOG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; To compile this driver as a module, c=
hoose M here.<br>
&nbsp;<br>
&nbsp;config ITCO_WDT<br>
-&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Intel TCO Timer/Watchdog&quot;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Intel TCO Timer/Watchdog&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on (X86 || IA64) &amp;&amp; PCI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select WATCHDOG_CORE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on I2C || I2C=3Dn<br>
-- <br>
2.7.4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_EEBA739CCF11FE49B73E1FB4690F5EE649E1C084shsmsx102ccrcor_--
