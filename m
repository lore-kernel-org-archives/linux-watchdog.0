Return-path: <baoyou.xie@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CANLsYkxCdEjvQ3p3nKxmB284cAbo5vPinrAHRX5jdMgZEQR0Xg@mail.gmail.com>
References: <1486092140-1017-1-git-send-email-baoyou.xie@linaro.org>
 <1486092140-1017-3-git-send-email-baoyou.xie@linaro.org> <20170203160257.GA30336@linaro.org>
 <20170203170717.GA14521@roeck-us.net> <CANLsYkxCdEjvQ3p3nKxmB284cAbo5vPinrAHRX5jdMgZEQR0Xg@mail.gmail.com>
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Sat, 4 Feb 2017 08:29:40 +0800
Message-ID: <CA+DQWkxFg=Za5rRzUvUfozNCMDTT5AOar-V7E5KY-nBtMcazwA@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jun Nie <jun.nie@linaro.org>, wim@iguana.be,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Content-Type: multipart/alternative; boundary=001a114acbf086b93d0547a97eaa
List-ID: <linux-watchdog@vger.kernel.org>

--001a114acbf086b93d0547a97eaa
Content-Type: text/plain; charset=UTF-8

On 4 February 2017 at 06:48, Mathieu Poirier <mathieu.poirier@linaro.org>
wrote:

> On 3 February 2017 at 10:07, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Fri, Feb 03, 2017 at 09:02:57AM -0700, Mathieu Poirier wrote:
> >> On Fri, Feb 03, 2017 at 11:22:20AM +0800, Baoyou Xie wrote:
> >> > This patch adds watchdog controller driver for ZTE's zx2967 family.
> >> >
> >> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> >> > ---
> >> >  drivers/watchdog/Kconfig      |  10 ++
> >> >  drivers/watchdog/Makefile     |   1 +
> >> >  drivers/watchdog/zx2967_wdt.c | 285 ++++++++++++++++++++++++++++++
> ++++++++++++
> >> >  3 files changed, 296 insertions(+)
> >> >  create mode 100644 drivers/watchdog/zx2967_wdt.c
> >> >
> >> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >> > index acb00b5..05093a2 100644
> >> > --- a/drivers/watchdog/Kconfig
> >> > +++ b/drivers/watchdog/Kconfig
> >> > @@ -714,6 +714,16 @@ config ASPEED_WATCHDOG
> >> >       To compile this driver as a module, choose M here: the
> >> >       module will be called aspeed_wdt.
> >> >
> >> > +config ZX2967_WATCHDOG
> >> > +   tristate "ZTE zx2967 SoCs watchdog support"
> >> > +   depends on ARCH_ZX
> >> > +   select WATCHDOG_CORE
> >> > +   help
> >> > +     Say Y here to include support for the watchdog timer
> >> > +     in ZTE zx2967 SoCs.
> >> > +     To compile this driver as a module, choose M here: the
> >> > +     module will be called zx2967_wdt.
> >> > +
> >> >  # AVR32 Architecture
> >> >
> >> >  config AT32AP700X_WDT
> >> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> >> > index 0c3d35e..bf2d296 100644
> >> > --- a/drivers/watchdog/Makefile
> >> > +++ b/drivers/watchdog/Makefile
> >> > @@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
> >> >  obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
> >> >  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
> >> >  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
> >> > +obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
> >> >
> >> >  # AVR32 Architecture
> >> >  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> >> > diff --git a/drivers/watchdog/zx2967_wdt.c
> b/drivers/watchdog/zx2967_wdt.c
> >> > new file mode 100644
> >> > index 0000000..2daaca2
> >> > --- /dev/null
> >> > +++ b/drivers/watchdog/zx2967_wdt.c
> >> > @@ -0,0 +1,285 @@
> >> > +/*
> >> > + * watchdog driver for ZTE's zx2967 family
> >> > + *
> >> > + * Copyright (C) 2017 ZTE Ltd.
> >> > + *
> >> > + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> >> > + *
> >> > + * License terms: GNU General Public License (GPL) version 2
> >> > + */
> >> > +
> >> > +#include <linux/clk.h>
> >> > +#include <linux/io.h>
> >> > +#include <linux/mfd/syscon.h>
> >> > +#include <linux/module.h>
> >> > +#include <linux/of_address.h>
> >> > +#include <linux/platform_device.h>
> >> > +#include <linux/regmap.h>
> >> > +#include <linux/reset.h>
> >> > +#include <linux/watchdog.h>
> >> > +
> >> > +#define ZX2967_WDT_CFG_REG                 0x4
> >> > +#define ZX2967_WDT_LOAD_REG                        0x8
> >> > +#define ZX2967_WDT_REFRESH_REG                     0x18
> >> > +#define ZX2967_WDT_START_REG                       0x1c
> >> > +
> >> > +#define ZX2967_WDT_REFRESH_MASK                    0x3f
> >> > +
> >> > +#define ZX2967_WDT_CFG_DIV(n)                      ((((n) & 0xff) -
> 1) << 8)
> >> > +#define ZX2967_WDT_START_EN                        0x1
> >> > +
> >> > +/*
> >> > + * Hardware magic number.
> >> > + * When watchdog reg is written, the lowest 16 bits are valid, but
> >> > + * the highest 16 bits should be always this number.
> >> > + */
> >>
> >> Thanks for the explanation, much better now.
> >>
> >> > +#define ZX2967_WDT_WRITEKEY                        (0x1234 << 16)
> >> > +
> >> > +#define ZX2967_WDT_DIV_DEFAULT                     16
> >> > +#define ZX2967_WDT_DEFAULT_TIMEOUT         32
> >> > +#define ZX2967_WDT_MIN_TIMEOUT                     1
> >> > +#define ZX2967_WDT_MAX_TIMEOUT                     524
> >> > +#define ZX2967_WDT_MAX_COUNT                       0xffff
> >> > +
> >> > +#define ZX2967_WDT_CLK_FREQ                        0x8000
> >> > +
> >> > +#define ZX2967_WDT_FLAG_REBOOT_MON         BIT(0)
> >> > +
> >> > +struct zx2967_wdt {
> >> > +   struct watchdog_device  wdt_device;
> >> > +   void __iomem            *reg_base;
> >> > +   struct clk              *clock;
> >> > +};
> >> > +
> >> > +static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, u16 reg)
> >> > +{
> >> > +   return readl_relaxed(wdt->reg_base + reg);
> >> > +}
> >> > +
> >> > +static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt, u16
> reg, u16 val)
> >> > +{
> >> > +   writel_relaxed(val | ZX2967_WDT_WRITEKEY, wdt->reg_base + reg);
> >> > +}
> >>
> >> You were correct with the u32 type.  My comment was about making sure
> the value
> >> of the value given to the function wasn't bigger than 65535 (0xffff),
> which
> >> would have been corrupted by the OR'ing with ZX2967_WDT_WRITEKEY.
> >>
> >> Going with a u16 forces you to manipulate u16 types in all the
> functions below
> >> but the read operation is still a u32, leaving to the compiler the task
> of
> >> stripping the top 16 bit.
> >>
> >> My suggestion is to go back to a u32 for zx2967_wdt_writel() but to AND
> 'val'
> >> with 0x0000ffff before OR'ing it with ZX2967_WDT_WRITEKEY.
> >>
> >
> > For the record, I am fine either way, including not masking at all;
> > I considered that a theoretic problem that only applies if reading
> > a register can return a value other than 0 in the upper 16 bit.
> > So, ultimately, this patch series is now waiting for your Ack.
> >
>
> Now that there is sufficient comments in the code to understand what's
> going on, I'm also fine either way.  As long as
> zx2967_wdt_readl/writel() are consistent with one another.
>
>
Please wait for my next version patch. I will modify it with u32 for
zx2967_wdt_writel() but to AND 'val'
with 0x0000ffff before OR'ing it with ZX2967_WDT_WRITEKEY.


> Mathieu
>
> > Guenter
>

--001a114acbf086b93d0547a97eaa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 4 February 2017 at 06:48, Mathieu Poirier <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:mathieu.poirier@linaro.org" target=3D"_blank">mathieu.poirier=
@linaro.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On 3 Februa=
ry 2017 at 10:07, Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net">l=
inux@roeck-us.net</a>&gt; wrote:<br>
&gt; On Fri, Feb 03, 2017 at 09:02:57AM -0700, Mathieu Poirier wrote:<br>
&gt;&gt; On Fri, Feb 03, 2017 at 11:22:20AM +0800, Baoyou Xie wrote:<br>
&gt;&gt; &gt; This patch adds watchdog controller driver for ZTE&#39;s zx29=
67 family.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@li=
naro.org">baoyou.xie@linaro.org</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 drivers/watchdog/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 10=
 ++<br>
&gt;&gt; &gt;=C2=A0 drivers/watchdog/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A01 +<br>
&gt;&gt; &gt;=C2=A0 drivers/watchdog/zx2967_wdt.c | 285 +++++++++++++++++++=
+++++++++++<wbr>++++++++++++<br>
&gt;&gt; &gt;=C2=A0 3 files changed, 296 insertions(+)<br>
&gt;&gt; &gt;=C2=A0 create mode 100644 drivers/watchdog/zx2967_wdt.c<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kcon=
fig<br>
&gt;&gt; &gt; index acb00b5..05093a2 100644<br>
&gt;&gt; &gt; --- a/drivers/watchdog/Kconfig<br>
&gt;&gt; &gt; +++ b/drivers/watchdog/Kconfig<br>
&gt;&gt; &gt; @@ -714,6 +714,16 @@ config ASPEED_WATCHDOG<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module,=
 choose M here: the<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called aspeed_wdt.<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +config ZX2967_WATCHDOG<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0tristate &quot;ZTE zx2967 SoCs watchdog support=
&quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0depends on ARCH_ZX<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0select WATCHDOG_CORE<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0help<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0Say Y here to include support for the wa=
tchdog timer<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0in ZTE zx2967 SoCs.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0To compile this driver as a module, choo=
se M here: the<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0module will be called zx2967_wdt.<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 # AVR32 Architecture<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 config AT32AP700X_WDT<br>
&gt;&gt; &gt; diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Mak=
efile<br>
&gt;&gt; &gt; index 0c3d35e..bf2d296 100644<br>
&gt;&gt; &gt; --- a/drivers/watchdog/Makefile<br>
&gt;&gt; &gt; +++ b/drivers/watchdog/Makefile<br>
&gt;&gt; &gt; @@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) +=3D bcm7038_wdt.=
o<br>
&gt;&gt; &gt;=C2=A0 obj-$(CONFIG_ATLAS7_WATCHDOG) +=3D atlas7_wdt.o<br>
&gt;&gt; &gt;=C2=A0 obj-$(CONFIG_RENESAS_WDT) +=3D renesas_wdt.o<br>
&gt;&gt; &gt;=C2=A0 obj-$(CONFIG_ASPEED_WATCHDOG) +=3D aspeed_wdt.o<br>
&gt;&gt; &gt; +obj-$(CONFIG_ZX2967_WATCHDOG) +=3D zx2967_wdt.o<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 # AVR32 Architecture<br>
&gt;&gt; &gt;=C2=A0 obj-$(CONFIG_AT32AP700X_WDT) +=3D at32ap700x_wdt.o<br>
&gt;&gt; &gt; diff --git a/drivers/watchdog/zx2967_wdt.<wbr>c b/drivers/wat=
chdog/zx2967_wdt.<wbr>c<br>
&gt;&gt; &gt; new file mode 100644<br>
&gt;&gt; &gt; index 0000000..2daaca2<br>
&gt;&gt; &gt; --- /dev/null<br>
&gt;&gt; &gt; +++ b/drivers/watchdog/zx2967_wdt.<wbr>c<br>
&gt;&gt; &gt; @@ -0,0 +1,285 @@<br>
&gt;&gt; &gt; +/*<br>
&gt;&gt; &gt; + * watchdog driver for ZTE&#39;s zx2967 family<br>
&gt;&gt; &gt; + *<br>
&gt;&gt; &gt; + * Copyright (C) 2017 ZTE Ltd.<br>
&gt;&gt; &gt; + *<br>
&gt;&gt; &gt; + * Author: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@linar=
o.org">baoyou.xie@linaro.org</a>&gt;<br>
&gt;&gt; &gt; + *<br>
&gt;&gt; &gt; + * License terms: GNU General Public License (GPL) version 2=
<br>
&gt;&gt; &gt; + */<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +#include &lt;linux/clk.h&gt;<br>
&gt;&gt; &gt; +#include &lt;linux/io.h&gt;<br>
&gt;&gt; &gt; +#include &lt;linux/mfd/syscon.h&gt;<br>
&gt;&gt; &gt; +#include &lt;linux/module.h&gt;<br>
&gt;&gt; &gt; +#include &lt;linux/of_address.h&gt;<br>
&gt;&gt; &gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt;&gt; &gt; +#include &lt;linux/regmap.h&gt;<br>
&gt;&gt; &gt; +#include &lt;linux/reset.h&gt;<br>
&gt;&gt; &gt; +#include &lt;linux/watchdog.h&gt;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +#define ZX2967_WDT_CFG_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00x4<br>
&gt;&gt; &gt; +#define ZX2967_WDT_LOAD_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8<br>
&gt;&gt; &gt; +#define ZX2967_WDT_REFRESH_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x18<br>
&gt;&gt; &gt; +#define ZX2967_WDT_START_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1c<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +#define ZX2967_WDT_REFRESH_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3f<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +#define ZX2967_WDT_CFG_DIV(n)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((((n) &amp; 0xff) - 1) &lt;&=
lt; 8)<br>
&gt;&gt; &gt; +#define ZX2967_WDT_START_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +/*<br>
&gt;&gt; &gt; + * Hardware magic number.<br>
&gt;&gt; &gt; + * When watchdog reg is written, the lowest 16 bits are vali=
d, but<br>
&gt;&gt; &gt; + * the highest 16 bits should be always this number.<br>
&gt;&gt; &gt; + */<br>
&gt;&gt;<br>
&gt;&gt; Thanks for the explanation, much better now.<br>
&gt;&gt;<br>
&gt;&gt; &gt; +#define ZX2967_WDT_WRITEKEY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x1234 &lt;&lt; 16)<b=
r>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +#define ZX2967_WDT_DIV_DEFAULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
&gt;&gt; &gt; +#define ZX2967_WDT_DEFAULT_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A032<br>
&gt;&gt; &gt; +#define ZX2967_WDT_MIN_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
&gt;&gt; &gt; +#define ZX2967_WDT_MAX_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0524<br>
&gt;&gt; &gt; +#define ZX2967_WDT_MAX_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xffff<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +#define ZX2967_WDT_CLK_FREQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8000<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +#define ZX2967_WDT_FLAG_REBOOT_MON=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(0)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +struct zx2967_wdt {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0struct watchdog_device=C2=A0 wdt_device;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *reg_base;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0struct clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 *clock;<br>
&gt;&gt; &gt; +};<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, u=
16 reg)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0return readl_relaxed(wdt-&gt;reg_base + reg);<b=
r>
&gt;&gt; &gt; +}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt,=
 u16 reg, u16 val)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0writel_relaxed(val | ZX2967_WDT_WRITEKEY, wdt-&=
gt;reg_base + reg);<br>
&gt;&gt; &gt; +}<br>
&gt;&gt;<br>
&gt;&gt; You were correct with the u32 type.=C2=A0 My comment was about mak=
ing sure the value<br>
&gt;&gt; of the value given to the function wasn&#39;t bigger than 65535 (0=
xffff), which<br>
&gt;&gt; would have been corrupted by the OR&#39;ing with ZX2967_WDT_WRITEK=
EY.<br>
&gt;&gt;<br>
&gt;&gt; Going with a u16 forces you to manipulate u16 types in all the fun=
ctions below<br>
&gt;&gt; but the read operation is still a u32, leaving to the compiler the=
 task of<br>
&gt;&gt; stripping the top 16 bit.<br>
&gt;&gt;<br>
&gt;&gt; My suggestion is to go back to a u32 for zx2967_wdt_writel() but t=
o AND &#39;val&#39;<br>
&gt;&gt; with 0x0000ffff before OR&#39;ing it with ZX2967_WDT_WRITEKEY.<br>
&gt;&gt;<br>
&gt;<br>
&gt; For the record, I am fine either way, including not masking at all;<br=
>
&gt; I considered that a theoretic problem that only applies if reading<br>
&gt; a register can return a value other than 0 in the upper 16 bit.<br>
&gt; So, ultimately, this patch series is now waiting for your Ack.<br>
&gt;<br>
<br>
</div></div>Now that there is sufficient comments in the code to understand=
 what&#39;s<br>
going on, I&#39;m also fine either way.=C2=A0 As long as<br>
zx2967_wdt_readl/writel() are consistent with one another.<br>
<br></blockquote><div><br></div><div>Please wait for my next version patch.=
 I will modify it with u32 for zx2967_wdt_writel() but to AND &#39;val&#39;=
<br>with 0x0000ffff before OR&#39;ing it with ZX2967_WDT_WRITEKEY.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Mathieu<br>
<br>
&gt; Guenter<br>
</blockquote></div><br></div></div>

--001a114acbf086b93d0547a97eaa--
