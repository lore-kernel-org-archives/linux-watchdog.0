Return-path: <baoyou.xie@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4cba1be6-ee85-7371-ea02-1bf8e7eb628e@roeck-us.net>
References: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
 <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org> <4cba1be6-ee85-7371-ea02-1bf8e7eb628e@roeck-us.net>
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Sun, 5 Feb 2017 10:36:38 +0800
Message-ID: <CA+DQWkyOZPQORy-rVSqGY8Ht9xWttYt6Csp6pvShGG4OVA_2YQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] MAINTAINERS: add zx2967 watchdog controller driver
 to ARM ZTE architecture
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jun Nie <jun.nie@linaro.org>, wim@iguana.be, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Content-Type: multipart/alternative; boundary=001a11414d7070a7af0547bf6279
List-ID: <linux-watchdog@vger.kernel.org>

--001a11414d7070a7af0547bf6279
Content-Type: text/plain; charset=UTF-8

On 5 February 2017 at 08:05, Guenter Roeck <linux@roeck-us.net> wrote:

> On 02/03/2017 05:34 PM, Baoyou Xie wrote:
>
>> Add the zx2967 watchdog controller driver as maintained by ARM ZTE
>> architecture maintainers, as they're parts of the core IP.
>>
>> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
>>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> I assume you'll submit this patch through the arm tree ?
>
> Could you please submit all three patches through your tree? Thanks a lot
:)


> Guenter
>
>
> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index edfdea3..275c434 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1990,11 +1990,13 @@ F:      drivers/clk/zte/
>>  F:     drivers/reset/reset-zx2967.c
>>  F:     drivers/soc/zte/
>>  F:     drivers/thermal/zx*
>> +F:     drivers/watchdog/zx2967_wdt.c
>>  F:     Documentation/devicetree/bindings/arm/zte.txt
>>  F:     Documentation/devicetree/bindings/clock/zx296702-clk.txt
>>  F:     Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
>>  F:     Documentation/devicetree/bindings/soc/zte/
>>  F:     Documentation/devicetree/bindings/thermal/zx*
>> +F:     Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
>>  F:     include/dt-bindings/soc/zx*.h
>>
>>  ARM/ZYNQ ARCHITECTURE
>>
>>
>

--001a11414d7070a7af0547bf6279
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 5 February 2017 at 08:05, Guenter Roeck <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 02/03=
/2017 05:34 PM, Baoyou Xie wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Add the zx2967 watchdog controller driver as maintained by ARM ZTE<br>
architecture maintainers, as they&#39;re parts of the core IP.<br>
<br>
Signed-off-by: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@linaro.org" targ=
et=3D"_blank">baoyou.xie@linaro.org</a>&gt;<br>
</blockquote>
<br></span>
Reviewed-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net" target=
=3D"_blank">linux@roeck-us.net</a>&gt;<br>
<br>
I assume you&#39;ll submit this patch through the arm tree ?<span class=3D"=
HOEnZb"><font color=3D"#888888"><br>
<br></font></span></blockquote><div>Could you please submit all three patch=
es through your tree? Thanks a lot :)<br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><span class=3D"HOEnZb"><font color=3D"#888888">
Guenter</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
---<br>
=C2=A0MAINTAINERS | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index edfdea3..275c434 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1990,11 +1990,13 @@ F:=C2=A0 =C2=A0 =C2=A0 drivers/clk/zte/<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/reset/reset-zx2967.c<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/soc/zte/<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/thermal/zx*<br>
+F:=C2=A0 =C2=A0 =C2=A0drivers/watchdog/zx2967_wdt.c<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0Documentation/devicetree/bind<wbr>ings/arm/zte.=
txt<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0Documentation/devicetree/bind<wbr>ings/clock/zx=
296702-clk.txt<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0Documentation/devicetree/bind<wbr>ings/reset/zt=
e,zx2967-reset.<wbr>txt<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0Documentation/devicetree/bind<wbr>ings/soc/zte/=
<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0Documentation/devicetree/bind<wbr>ings/thermal/=
zx*<br>
+F:=C2=A0 =C2=A0 =C2=A0Documentation/devicetree/bind<wbr>ings/watchdog/zte,=
zx2967-wdt.<wbr>txt<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0include/dt-bindings/soc/zx*.h<br>
<br>
=C2=A0ARM/ZYNQ ARCHITECTURE<br>
<br>
</blockquote>
<br>
</div></div></blockquote></div><br></div></div>

--001a11414d7070a7af0547bf6279--
