Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:30557 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbdFNGuo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Jun 2017 02:50:44 -0400
From: "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To: =?utf-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?=
        <yamada.masahiro@socionext.com>
Cc: <wim@iguana.be>, "Guenter Roeck" <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        =?utf-8?Q?Hayashi=2C_Kunihiko/=E6=9E=97_=E9=82=A6=E5=BD=A6?=
        <hayashi.kunihiko@socionext.com>,
        =?utf-8?B?T3dhZGEsIEtpeW9zaGkv5aSn5ZKM55SwIOa4heW/lw==?=
        <owada.kiyoshi@socionext.com>
References: <1497316499-22254-1-git-send-email-hayashibara.keiji@socionext.com> <1497316499-22254-3-git-send-email-hayashibara.keiji@socionext.com> <CAK7LNASq9MxUwDrNeRrg_eNkJbXR2J-9hHKGZe6-DtioO3p4cQ@mail.gmail.com>
In-Reply-To: <CAK7LNASq9MxUwDrNeRrg_eNkJbXR2J-9hHKGZe6-DtioO3p4cQ@mail.gmail.com>
Subject: RE: [PATCH V3 2/3] watchdog: uniphier: add UniPhier watchdog driver
Date: Wed, 14 Jun 2017 15:50:37 +0900
Message-ID: <000101d2e4da$87e7e210$97b7a630$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ja
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Yamada-san,

From: Masahiro Yamada [mailto:yamada.masahiro@socionext.com]
Sent: Wednesday, June 14, 2017 12:08 PM
>
> 2017-06-13 10:14 GMT+09:00 Keiji Hayashibara
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 52a70ee..2a9d9a6 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -744,6 +744,17 @@ config ZX2967_WATCHDOG
> >           To compile this driver as a module, choose M here: the
> >           module will be called zx2967_wdt.
> >
> > +config UNIPHIER_WATCHDOG
> > +       tristate "UniPhier watchdog support"
> > +       depends on ARCH_UNIPHIER || COMPILE_TEST
> 
> This driver relies on syscon_node_to_regmap().
> Could you also add "depends on OF && MFD_SYSCON" ?

OK. I will fix this.
> 
> 
> > +       select WATCHDOG_CORE
> > +       help
> > +         Say Y here to include support watchdog timer embedded
> > +         into the UniPhier system.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called uniphier_wdt.
> > +

----------
Best Regards,
Keiji Hayashibara


