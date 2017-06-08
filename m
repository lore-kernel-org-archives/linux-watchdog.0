Return-Path: <hayashibara.keiji@socionext.com>
Return-path: <hayashibara.keiji@socionext.com>
From: "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To: =?iso-2022-jp?B?WWFtYWRhLCBNYXNhaGlyby8bJEI7M0VEGyhCIBskQj8/OTAbKEI=?= <yamada.masahiro@socionext.com>
Cc: <wim@iguana.be>,
	"Guenter Roeck" <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Rob Herring" <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>,
	"Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
	"Jassi Brar" <jaswinder.singh@linaro.org>,
	=?iso-2022-jp?B?SGF5YXNoaSwgS3VuaWhpa28vGyRCTlMbKEIgGyRCSy5JJxsoQg==?= <hayashi.kunihiko@socionext.com>,
	=?iso-2022-jp?B?T3dhZGEsIEtpeW9zaGkvGyRCQmdPQkVEGyhCIBskQkA2O1YbKEI=?= <owada.kiyoshi@socionext.com>
References: <1496740294-12653-1-git-send-email-hayashibara.keiji@socionext.com> <1496740294-12653-3-git-send-email-hayashibara.keiji@socionext.com> <CAK7LNARQb3r7fvytCZ86G3iQBpWhu7-06DY9gcJswjH0heUonA@mail.gmail.com>
In-Reply-To: <CAK7LNARQb3r7fvytCZ86G3iQBpWhu7-06DY9gcJswjH0heUonA@mail.gmail.com>
Subject: RE: [PATCH V2 2/3] watchdog: uniphier: add UniPhier watchdog driver
Date: Thu, 8 Jun 2017 14:51:21 +0900
Message-ID: <000001d2e01b$41b00840$c51018c0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Language: ja
List-ID: <linux-watchdog@vger.kernel.org>

Hello Yamada-san,

> > +
> > +#include <linux/module.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/watchdog.h>
> > +#include <linux/bitops.h>
> 
> I think you should have added <linux/bitops.h> on the top
> to keep the includes alphabetically sorted.

Sorry, I will fix in v3 patch.

----------
Best Regards,
Keiji Hayashibara
