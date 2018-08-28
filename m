Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:51168
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeH1VPu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 17:15:50 -0400
Date: Tue, 28 Aug 2018 10:23:05 -0700
From: Paul Burton <paul.burton@mips.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
Message-ID: <20180828172305.bohg6cggnzm3wsuj@pburton-laptop>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-6-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Daniel & Thomas,

On Tue, Aug 21, 2018 at 07:16:16PM +0200, Paul Cercueil wrote:
> This driver handles the TCU (Timer Counter Unit) present on the Ingenic
> JZ47xx SoCs, and provides the kernel with a system timer, and optionally
> with a clocksource and a sched_clock.
> 
> It also provides clocks and interrupt handling to client drivers.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v2: Use SPDX identifier for the license
>     
>      v3: - Move documentation to its own patch
>          - Search the devicetree for PWM clients, and use all the TCU
>     	   channels that won't be used for PWM
>     
>      v4: - Add documentation about why we search for PWM clients
>          - Verify that the PWM clients are for the TCU PWM driver
>     
>      v5: Major overhaul. Too many changes to list. Consider it's a new
>          patch.
>     
>      v6: - Add two API functions ingenic_tcu_request_channel and
>            ingenic_tcu_release_channel. To be used by the PWM driver to
>            request the use of a TCU channel. The driver will now dynamically
>            move away the system timer or clocksource to a new TCU channel.
>          - The system timer now defaults to channel 0, the clocksource now
>            defaults to channel 1 and is no more optional. The
>            ingenic,timer-channel and ingenic,clocksource-channel devicetree
>            properties are now gone.
>          - Fix round_rate / set_rate not calculating the prescale divider
>            the same way. This caused problems when (parent_rate / div) would
>            give a non-integer result. The behaviour is correct now.
>          - The clocksource clock is turned off on suspend now.
>     
>      v7: Fix section mismatch by using builtin_platform_driver_probe()
> 
>  drivers/clocksource/Kconfig         |   10 +
>  drivers/clocksource/Makefile        |    1 +
>  drivers/clocksource/ingenic-timer.c | 1124 +++++++++++++++++++++++++++++++++++
>  drivers/clocksource/ingenic-timer.h |   15 +
>  include/linux/mfd/ingenic-tcu.h     |    3 +
>  5 files changed, 1153 insertions(+)
>  create mode 100644 drivers/clocksource/ingenic-timer.c
>  create mode 100644 drivers/clocksource/ingenic-timer.h
>%

How is this & patch 6 of the series looking to you from a
drivers/clocksource perspective?

If you're happy with them it'd be great to get an ack so I can take this
through the MIPS tree with the rest of the series. The alternative would
be to get the drivers in first then the MIPS bits in the next release
cycle.

Thanks,
    Paul
