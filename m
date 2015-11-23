Return-path: <f.fainelli@gmail.com>
Message-ID: <565358AF.2090609@gmail.com>
Date: Mon, 23 Nov 2015 10:19:27 -0800
From: Florian Fainelli <f.fainelli@gmail.com>
MIME-Version: 1.0
To: Jonas Gorski <jogo@openwrt.org>, Simon Arlott <simon@fire.lp0.eu>
CC: Guenter Roeck <linux@roeck-us.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Kevin Cernekee <cernekee@gmail.com>,
 Wim Van Sebroeck <wim@iguana.be>,
 Maxime Bizon <mbizon@freebox.fr>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 6/10] watchdog: bcm63xx_wdt: Obtain watchdog clock HZ
 from "periph" clk
References: <5650BFD6.5030700@simon.arlott.org.uk> <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net> <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net> <5651CB13.4090704@simon.arlott.org.uk> <5651CC3C.5090200@simon.arlott.org.uk> <CAOiHx==Z=4H=-L2CY-FE5m6WMV0XzgsCmy1b9tUbsmOHydzkEw@mail.gmail.com>
In-Reply-To: <CAOiHx==Z=4H=-L2CY-FE5m6WMV0XzgsCmy1b9tUbsmOHydzkEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 23/11/15 07:02, Jonas Gorski wrote:
> Hi,
> 
> On Sun, Nov 22, 2015 at 3:07 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
>> Instead of using a fixed clock HZ in the driver, obtain it from the
>> "periph" clk that the watchdog timer uses.
>>
>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
>> ---
>>  drivers/watchdog/bcm63xx_wdt.c | 36 +++++++++++++++++++++++++++++++-----
>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
>> index 1d2a501..eb5e551 100644
>> --- a/drivers/watchdog/bcm63xx_wdt.c
>> +++ b/drivers/watchdog/bcm63xx_wdt.c
>> @@ -13,6 +13,7 @@
>>
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>> +#include <linux/clk.h>
>>  #include <linux/errno.h>
>>  #include <linux/io.h>
>>  #include <linux/kernel.h>
>> @@ -32,11 +33,13 @@
>>
>>  #define PFX KBUILD_MODNAME
>>
>> -#define WDT_HZ                 50000000                /* Fclk */
>> +#define WDT_CLK_NAME           "periph"
> 
> @Florian:
> Is this correct? The comment for the watchdog in 6358_map_part.h and
> earlier claims that the clock is 40 MHz there, but the code uses 50MHz
> - is this a bug in the comments or is it a bug taken over from the
> original broadcom code? I'm sure that the periph clock being 50 MHz
> even on the older chips is correct, else we'd have noticed that in
> serial output (where it's also used).

There are references to a Fbus2 clock in documentation, but I could not
find any actual documentation for its actual clock frequency, I would be
surprised if this chip would have diverged from the previous and future
ones and used a 40Mhz clock. 6345 started with a peripheral clock
running at 50Mhz, and that is true for all chips since then AFAICT.

I agree we would have noticed this with the UART or SPI controllers if
that was not true, so probably a code glitch here...
-- 
Florian
