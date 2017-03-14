Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44643 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCNNpH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Mar 2017 09:45:07 -0400
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/8] ARM: dts: exynos: Fix watchdog reset on Exynos4412
Date: Tue, 14 Mar 2017 14:45 +0100
Message-id: <1510739.WtREN49XT5@amdc3058>
In-reply-to: <CAJKOXPcoP7c=TTFtWqBLMXT0BS_yi3fpu8X3q4sxCTM9m=mPmw@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
References: <20170311172527.16368-1-krzk@kernel.org>
 <6788694.7QfyuOlrPv@amdc3058>
 <CAJKOXPcoP7c=TTFtWqBLMXT0BS_yi3fpu8X3q4sxCTM9m=mPmw@mail.gmail.com>
 <CGME20170314134503epcas1p178241245d202edf9f3ea5885c605ffb6@epcas1p1.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday, March 14, 2017 03:09:25 PM Krzysztof Kozlowski wrote:
> On Tue, Mar 14, 2017 at 3:03 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Saturday, March 11, 2017 07:25:22 PM Krzysztof Kozlowski wrote:
> >> The Exynos4412 has the same watchdog as newer SoCs (e.g. Exynos5250).
> >> Just like the others, for working it requires additional steps in Power
> >> Management Unit: unmasking the reset request and enabling the system
> >> reset.  Without these additional steps in PMU, the watchdog will not be
> >> able to reset the system on expiration event.
> >>
> >> Change the compatible of Exynos4412 watchdog device node to
> >> samsung,exynos5250-wdt which includes the additional PMU steps.
> >
> > This is going to confuse people.  How's about doing it cleanly
> > (by adding samsung,exynos4412-wdt compatible and convert existing
> > users to use instead)?
> 
> I don't find usage of 5250 in Exynos4412 DTS as confusing because
> since long time I do not threat these numbers as having any meaning
> (e.g. 3250 is newer...). Yes, we can duplicate the compatible for that
> purpose. Care to send a patch for this?

I don't buy this argument. The point is not in the number itself
but in the fact that you as developer know than 3250 is newer than
4412 (the same way as you know that 5250 is also newer than 4412).
This convention is used for all Exynos bindings so please don't
break it.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

