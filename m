Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42014 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbaAUFIH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 00:08:07 -0500
From: kgene@kernel.org
To: 'Leela Krishna Amudala' <l.krishna@samsung.com>,
	'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-samsung-soc@vger.kernel.org, dianders@chromium.org,
	t.figa@samsung.com, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
 <1386308868-30264-2-git-send-email-l.krishna@samsung.com>
 <20140110074113.GB12119@spo001.leaseweb.com>
 <CAL1wa8cfE7_HfkMOx8jKM6p+xjMFGXaE9X1DsN1pfbt11x62jg@mail.gmail.com>
In-reply-to: <CAL1wa8cfE7_HfkMOx8jKM6p+xjMFGXaE9X1DsN1pfbt11x62jg@mail.gmail.com>
Subject: RE: [PATCH V12 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
Date: Tue, 21 Jan 2014 14:08:04 +0900
Message-id: <0baa01cf1666$c42d1d80$4c875880$@kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Leela Krishna Amudala wrote:
> 
> On 1/10/14, Wim Van Sebroeck <wim@iguana.be> wrote:
> > Hi Leela,
> >
> >> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files
> to
> >> handle PMU register accesses in a centralized way using syscon driver
> >>
> >> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> >> Reviewed-by: Doug Anderson <dianders@chromium.org>
> >> Tested-by: Doug Anderson <dianders@chromium.org>
> >> ---
> > ...
> >> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> >> b/arch/arm/boot/dts/exynos5420.dtsi
> >> index b1fa334..cd47db0 100644
> >> --- a/arch/arm/boot/dts/exynos5420.dtsi
> >> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> >> @@ -402,4 +402,9 @@
> >>  		clock-names = "gscl";
> >>  		samsung,power-domain = <&gsc_pd>;
> >>  	};
> >
> > I can't add this patch since there is no "gscl" in the current linux-
> tree.
> > Is this depending on another patch or are we going to fix this in
> another
> > way?
> >
> 
> Hi Kgene,
> 
Hi Leela,

> Driver changes has been merged to Wim's tree, so can you please pick
> this patch into your tree.
> 
OK, let me take this and 3rd patch into Samsung tree for next time.

Thanks,
Kukjin

