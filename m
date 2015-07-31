Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 31 Jul 2015 11:59:03 +0200
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        rtc-linux@googlegroups.com, Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 00/23] ARM: at91: Properly handle slow clock
Message-ID: <20150731115903.4ef23e83@bbrezillon>
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Alexandre,

On Fri, 31 Jul 2015 11:39:36 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Hi,
> 
> It was discovered that all the slow clock user were not properly claiming it.
> This can end up in a system hang because the last registered user is releasing
> it, and it gets disabled.
> 
> commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system hang")
> was a workaround. This series is adding the slow clock to the necessary drivers
> to avoid the issue and then removes that workaround.
> 
> The Documentation updates and DT patches should probably go through the AT91
> tree this cycle to avoid breakage.
> 
> Then the other patches can go through each subsystem tree. They are trivial
> enough to also go in this cycle.
> 
> The final clk patch depends on the other ones and may be taken for the next
> cycle to avoid synchronization issues.
> 
> I've thrown in a cleanup for at91-reset as it avoids adding support for that
> clock to the platform data initialization

I would have squashed commit 5 to 14 into a single patch, but apart
from that it looks good to me.

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thanks,

Boris

> 
> Changes in v2:
>  - statisticize the global in the atmel-st change
>  - merge at91_reset_of_probe() in at91_reset_probe()
>  - added patches from Boris for the TCB
>  - added the slow clock to the TCB
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: rtc-linux@googlegroups.com
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> 
> Alexandre Belloni (20):
>   Documentation: dt: atmel-at91: add clocks to system timer, rstc and
>     shdwc
>   Documentation: watchdog: at91sam9_wdt: add clocks property
>   Documentation: dt: rtc: at91rm9200: add clocks property
>   ARM: at91/dt: at91rm9200: use slow clock where necessary
>   ARM: at91/dt: at91sam9260: use slow clock where necessary
>   ARM: at91/dt: at91sam9261: use slow clock where necessary
>   ARM: at91/dt: at91sam9263: use slow clock where necessary
>   ARM: at91/dt: at91sam9g45: use slow clock where necessary
>   ARM: at91/dt: at91sam9n12: use slow clock where necessary
>   ARM: at91/dt: at91sam9rl: use slow clock where necessary
>   ARM: at91/dt: at91sam9x5: use slow clock where necessary
>   ARM: at91/dt: sama5d3: use slow clock where necessary
>   ARM: at91/dt: sama5d4: use slow clock where necessary
>   rtc: at91rm9200: get and use slow clock
>   watchdog: at91sam9: get and use slow clock
>   power/reset: at91-reset: remove useless at91_reset_platform_probe()
>   power/reset: at91-reset: get and use slow clock
>   power/reset: at91-poweroff: get and use slow clock
>   clocksource: atmel-st: get and use slow clock
>   clk: at91: Revert "keep slow clk enabled to prevent system hang"
> 
> Boris Brezillon (3):
>   Documentation: dt: atmel-at91: add slow clock to tcb
>   clocksource: tcb_clksrc: fix setup_clkevents error path
>   misc: atmel_tclib: get and use slow clock
> 
>  .../devicetree/bindings/arm/atmel-at91.txt         | 13 +++--
>  .../bindings/rtc/atmel,at91rm9200-rtc.txt          |  2 +
>  .../devicetree/bindings/watchdog/atmel-wdt.txt     |  2 +
>  arch/arm/boot/dts/at91rm9200.dtsi                  | 10 ++--
>  arch/arm/boot/dts/at91sam9260.dtsi                 | 11 +++--
>  arch/arm/boot/dts/at91sam9261.dtsi                 |  7 ++-
>  arch/arm/boot/dts/at91sam9263.dtsi                 |  7 ++-
>  arch/arm/boot/dts/at91sam9g45.dtsi                 | 12 +++--
>  arch/arm/boot/dts/at91sam9n12.dtsi                 | 12 +++--
>  arch/arm/boot/dts/at91sam9rl.dtsi                  |  8 ++-
>  arch/arm/boot/dts/at91sam9x5.dtsi                  | 12 +++--
>  arch/arm/boot/dts/sama5d3.dtsi                     |  8 ++-
>  arch/arm/boot/dts/sama5d3_tcb1.dtsi                |  4 +-
>  arch/arm/boot/dts/sama5d4.dtsi                     | 12 +++--
>  drivers/clk/at91/clk-slow.c                        | 27 ----------
>  drivers/clocksource/tcb_clksrc.c                   | 10 +++-
>  drivers/clocksource/timer-atmel-st.c               | 31 ++++++++----
>  drivers/misc/atmel_tclib.c                         |  4 ++
>  drivers/power/reset/at91-poweroff.c                | 13 +++++
>  drivers/power/reset/at91-reset.c                   | 57 ++++++----------------
>  drivers/pwm/pwm-atmel-tcb.c                        | 23 ++++++---
>  drivers/rtc/rtc-at91rm9200.c                       | 27 ++++++++--
>  drivers/watchdog/at91sam9_wdt.c                    | 22 ++++++++-
>  include/linux/atmel_tc.h                           |  1 +
>  24 files changed, 206 insertions(+), 129 deletions(-)
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
