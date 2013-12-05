Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:47973 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab3LES7V (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Dec 2013 13:59:21 -0500
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Olof Johansson <olof@lixom.net>,
	Leela Krishna Amudala <l.krishna@samsung.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"cpgs ." <cpgs@samsung.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V11 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and exynos5420 dtsi files
Date: Thu, 05 Dec 2013 19:59:15 +0100
Message-ID: <1676404.arUWsvfauz@flatron>
In-Reply-To: <CAD=FV=UcqaG9Dw_rd-bdTAmDwdW-_yCO6HpaEr1G07AW4TWm0w@mail.gmail.com>
References: <1385613243-3559-1-git-send-email-l.krishna@samsung.com> <1979723.ga7TBeh7CQ@flatron> <CAD=FV=UcqaG9Dw_rd-bdTAmDwdW-_yCO6HpaEr1G07AW4TWm0w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday 05 of December 2013 10:35:20 Doug Anderson wrote:
> Tomasz,
> 
> On Thu, Dec 5, 2013 at 10:30 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> >> I'd vote for using "pmu-system-registers".  We end up using the
> >> "syscon" subsystem but really we're describing pmu registers.
> >>
> >> I'd even say that you don't need to formally specify the "name" in the
> >> bindings (though I'm not up with all the latest device tree
> >> requirements).  ...still you'd want to use "pmu-system-registers" in
> >> the DTS changes.
> >
> > Well, since the name should specify the class of device, I would say that
> > pmu-system-registers is too specific. If we want to change this, I'd say
> > we should go with system-controller.
> 
> ...but the "compatible" is "samsung,exynos5250-pmu", "syscon", right?
> That means that the class of the device is "exynos5250-pmu", right?

Nope. "samsung,exynos5250-pmu" is the specific device (or hardware
programming interface) this device is compatible with.

With class I mean the generic kind of device, such as system-controller,
i2c, pinctrl, display, etc., as specified by sections 2.2.1 and 2.2.2 of
ePAPR.

Anyway, node names are just a matter of coding style, as they don't have
any semantical meaning in most cases (such as this one).

> It is also compatible with the generic "syscon" class of devices.

It is also compatible with the generic "syscon" programming interface,
which represents a set of loosely related registers that control various
aspects of other IP blocks.

Best regards,
Tomasz

