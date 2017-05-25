Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:19307 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755634AbdEYIot (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 25 May 2017 04:44:49 -0400
From: "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To: =?iso-2022-jp?B?WWFtYWRhLCBNYXNhaGlyby8bJEI7M0VEGyhCIBskQj8/OTAbKEI=?=
        <yamada.masahiro@socionext.com>, <wim@iguana.be>,
        <linux@roeck-us.net>
Cc: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <masami.hiramatsu@linaro.org>, <jaswinder.singh@linaro.org>,
        =?iso-2022-jp?B?SGF5YXNoaSwgS3VuaWhpa28vGyRCTlMbKEIgGyRCSy5JJxsoQg==?=
        <hayashi.kunihiko@socionext.com>,
        =?iso-2022-jp?B?T3dhZGEsIEtpeW9zaGkvGyRCQmdPQkVEGyhCIBskQkA2O1YbKEI=?=
        <owada.kiyoshi@socionext.com>
References: <1495607692-657-1-git-send-email-hayashibara.keiji@socionext.com> <1495607692-657-2-git-send-email-hayashibara.keiji@socionext.com> <24780eb20b3c4aecb1f5112e1827d5e1@SOC-EX01V.e01.socionext.com>
In-Reply-To: <24780eb20b3c4aecb1f5112e1827d5e1@SOC-EX01V.e01.socionext.com>
Subject: RE: [PATCH 1/2] watchdog: uniphier: add UniPhier watchdog driver
Date: Thu, 25 May 2017 17:44:43 +0900
Message-ID: <000501d2d533$27fe47b0$77fad710$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Language: ja
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Yamada-san,

> > a/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> > b/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> > new file mode 100644
> > index 0000000..a59d1ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> > @@ -0,0 +1,20 @@
> > +UniPhier watchdog timer controller
> > +
> > +This UniPhier watchdog timer controller must be under sysctrl compatible
> > node.
> > +
> > +Required properties:
> > +- compatible: should be "socionext,uniphier-wdt"
> > +
> > +Example:
> > +
> > +	sysctrl@61840000 {
> > +		compatible = "socionext,uniphier-ld11-sysctrl",
> > +			     "simple-mfd", "syscon";
> > +		reg = <0x61840000 0x4000>;
> > +
> > +		sys_wdt: watchdog {
> > +			compatible = "socionext,uniphier-wdt";
> > +		}
> > +
> > +		other nodes ...
> > +	};
> 
> 
> Next time, please include
> devicetree@vger.kernel.org
> (and Rob) in your CC list for binding review.
> 
> I think scripts/get_maintainer.pl will do it correctly for you.
> 

OK. I will include to CC list in next v2 patch.

> 
> 
> > +#include <linux/delay.h>
> 
> Is this used?

It is unnecessary. I will remove it.

Thanks.

-----
Best Regards,
Keiji Hayashibara


