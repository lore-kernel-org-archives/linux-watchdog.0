Return-Path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
Date: Mon, 2 Dec 2013 10:31:48 -0800
Message-ID: <CAD=FV=VEJj0-AnymUO1gM4C7omQdqv+F5r10TypZNWErnfi8Gw@mail.gmail.com>
Subject: Recent s3c2410 watchdog patches?
From: Doug Anderson <dianders@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Leelakrishna A <l.krishna@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>,
	Olof Johansson <olof@lixom.net>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-watchdog@vger.kernel.org>

Wim,

Just checking up on the status of recent watchdog patches that have
been flying by on the list over the last week (some from me, some from
Leela Krishna).  I think many of them are in good shape and I wanted
to see if there was anything else you needed before Acking them and/or
landing them.

Here's a summary (IDs are patchwork IDs that you can get like
https://patchwork.kernel.org/patch/3251851/).  I can also repost if
that's more helpful.

---

Specifically I think these are ready (from Leela Krishna):

3251851 New          [V11,1/3] ARM: dts: Add pmu sysreg node to
exynos5250 and exynos5420 dtsi files
3251841 New          [V11,2/3] watchdog: s3c2410_wdt: use syscon
regmap interface to configure pmu register
3251861 New          [V11,3/3] ARM: dts: update watchdog device nodes
for Exynos5250 and Exynos5420

...you may want to funnel the DTS changes through Kukjin (exynos
maintainer) or through the ARM SoC tree...


I think these are ready as well:

3235201 New          [v2] watchdog: s3c2410_wdt: Only register for
cpufreq on ARM_S3C24XX_CPUFREQ
3240581 New          [1/2] watchdog: core: Make dt "timeout-sec"
property work on drivers w/out min/max
3244711 New          [v2] watchdog: s3c2410_wdt: Handle rounding a
little better for timeout


I just posted this one, so you could wait or review as your discretion:

3266591 New          watchdog: s3c2410_wdt: Report when the watchdog
reset the system


...and this one can be dropped or reworked at your request (no need to
hold up other patches for it):

3240561 New          [2/2] watchdog: core: Fix watchdog_init_timeout()
when invalid param / valid dt

---

If you need more time, that's OK (I know it's the holidays).  I just
wanted to double-check on them.  Thanks!

-Doug
