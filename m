Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:2955 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbdFHGWS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 8 Jun 2017 02:22:18 -0400
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
References: <1496740294-12653-1-git-send-email-hayashibara.keiji@socionext.com> <1496740294-12653-2-git-send-email-hayashibara.keiji@socionext.com> <CAK7LNATMRPW3PYU-fX+biRdez-mgkUKRbVi+w+dBNb3szOuXdw@mail.gmail.com>
In-Reply-To: <CAK7LNATMRPW3PYU-fX+biRdez-mgkUKRbVi+w+dBNb3szOuXdw@mail.gmail.com>
Subject: RE: [PATCH V2 1/3] devicetree: add UniPhier WDT devicetree bindings documentation
Date: Thu, 8 Jun 2017 15:22:12 +0900
Message-ID: <000101d2e01f$913fef20$b3bfcd60$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ja
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Yamada-san

Thank you for your comment.

> > Add uniphier-wdt bindings documentation.
> >
> > Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> 
> 
> Maybe "dt-bindings: watchdog: ..." for the subject.
> 
> This seems what Rob prefers.
> 
> For example,
> https://patchwork.kernel.org/patch/9606365/

OK. I will change the subject in v3 patch.

> 
> > ---
> >  .../devicetree/bindings/watchdog/uniphier-wdt.txt    | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> b/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> > new file mode 100644
> > index 0000000..a59d1ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> > @@ -0,0 +1,20 @@
> > +UniPhier watchdog timer controller
> > +
> > +This UniPhier watchdog timer controller must be under sysctrl compatible node.
> 
> Do you mean "syscon compatible" ?

The "compatible" word is inappropriate.
I will remove it in v3 patch.

> 
> > +Required properties:
> > +- compatible: should be "socionext,uniphier-wdt"
> > +
> > +Example:
> > +
> > +       sysctrl@61840000 {
> > +               compatible = "socionext,uniphier-ld11-sysctrl",
> > +                            "simple-mfd", "syscon";
> > +               reg = <0x61840000 0x4000>;
> > +
> > +               sys_wdt: watchdog {
> > +                       compatible = "socionext,uniphier-wdt";
> > +               }
> 
> Could you remove the "sys_dwt: " label?
> I'd like the example matched with actual DT files.

I will remove it.

> 
> Thanks.
> 
> 
> > +               other nodes ...
> > +       };
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

----------
Best Regards,
Keiji Hayashibara


