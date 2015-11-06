Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35869 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032077AbbKFTxn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Nov 2015 14:53:43 -0500
Received: by obdgf3 with SMTP id gf3so100533001obd.3
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Nov 2015 11:53:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151105222325.GA26159@roeck-us.net>
References: <1446758362-11702-1-git-send-email-akshay.bhat@timesys.com>
	<1446758362-11702-2-git-send-email-akshay.bhat@timesys.com>
	<20151105222325.GA26159@roeck-us.net>
Date: Fri, 6 Nov 2015 11:53:42 -0800
Message-ID: <CAJ+vNU2fSxRJ7YvxOfNzoEoiKgzv-dHj=+eksKxH48ekHiUw2Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support via
 'ext-reset-output' dt prop
From: Tim Harvey <tharvey@gateworks.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Akshay Bhat <akshay.bhat@timesys.com>,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, justin.waters@timesys.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 5, 2015 at 2:23 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Nov 05, 2015 at 04:19:21PM -0500, Akshay Bhat wrote:
>> From: Tim Harvey <tharvey@gateworks.com>
>>
>> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
>> can be pinmux'd to an external pin. This is typically used for boards that
>> have PMIC's in control of the IMX6 power rails. In fact, failure to use
>> such an external reset on boards with external PMIC's can result in various
>> hangs due to the IMX6 not being fully reset [1] as well as the board failing
>> to reset because its PMIC has not been reset to provide adequate voltage for
>> the CPU when coming out of reset at 800Mhz.
>>
>> This uses a new device-tree property 'ext-reset-output' to indicate the
>> board has such a reset and to cause the watchdog to be configured to assert
>> WDOG_B instead of an internal reset both on a watchdog timeout and in
>> system_restart.
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
>>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>  .../devicetree/bindings/watchdog/fsl-imx-wdt.txt     |  2 ++
>>  drivers/watchdog/imx2_wdt.c                          | 20 ++++++++++++++++++--
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
>> index 8dab6fd..9b89b3a 100644
>> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
>> @@ -9,6 +9,8 @@ Optional property:
>
> properties ?
>
>>  - big-endian: If present the watchdog device's registers are implemented
>>    in big endian mode, otherwise in native mode(same with CPU), for more
>>    detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
>> +- ext-reset-output: If present the watchdog device is configured to assert its
>
> Should that have a vendor prefix ? Also, not sure if "-output"
> has any real value in the property name. "fsl,external-reset", maybe ?

Hi Guenter,

I don't see why a vendor prefix is necessary - its a feature of the
IMX6 watchdog supported by this driver to be able to trigger an
internal chip-level reset and/or an external signal that can be hooked
to additional hardware.

I started with ext-reset, but it was suggested
(http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347437.html)
to also make it clear that this is an 'output' and not a reset input.

>
>> +  external reset (WDOG_B) instead of issuing a software reset.
>>
>>  Examples:
>>
>> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
>> index 29ef719..84bfec4 100644
>> --- a/drivers/watchdog/imx2_wdt.c
>> +++ b/drivers/watchdog/imx2_wdt.c
>> @@ -41,6 +41,8 @@
>>
>>  #define IMX2_WDT_WCR         0x00            /* Control Register */
>>  #define IMX2_WDT_WCR_WT              (0xFF << 8)     /* -> Watchdog Timeout Field */
>> +#define IMX2_WDT_WCR_WDA     (1 << 5)        /* -> External Reset WDOG_B */
>> +#define IMX2_WDT_WCR_SRS     (1 << 4)        /* -> Software Reset Signal */
>>  #define IMX2_WDT_WCR_WRE     (1 << 3)        /* -> WDOG Reset Enable */
>>  #define IMX2_WDT_WCR_WDE     (1 << 2)        /* -> Watchdog Enable */
>>  #define IMX2_WDT_WCR_WDZST   (1 << 0)        /* -> Watchdog timer Suspend */
>> @@ -65,6 +67,7 @@ struct imx2_wdt_device {
>>       struct timer_list timer;        /* Pings the watchdog when closed */
>>       struct watchdog_device wdog;
>>       struct notifier_block restart_handler;
>> +     bool ext_reset;
>>  };
>>
>>  static bool nowayout = WATCHDOG_NOWAYOUT;
>> @@ -90,6 +93,13 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
>>       struct imx2_wdt_device *wdev = container_of(this,
>>                                                   struct imx2_wdt_device,
>>                                                   restart_handler);
>> +
>> +     /* Use internal reset or external - not both */
>> +     if (wdev->ext_reset)
>> +             wcr_enable |= IMX2_WDT_WCR_SRS; /* do not assert int reset */
>> +     else
>> +             wcr_enable |= IMX2_WDT_WCR_WDA; /* do not assert ext-reset */
>> +
>>       /* Assert SRS signal */
>>       regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
>>       /*
>> @@ -119,8 +129,12 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
>>       val |= IMX2_WDT_WCR_WDZST;
>>       /* Strip the old watchdog Time-Out value */
>>       val &= ~IMX2_WDT_WCR_WT;
>> -     /* Generate reset if WDOG times out */
>> -     val &= ~IMX2_WDT_WCR_WRE;
>> +     /* Generate internal chip-level reset if WDOG times out */
>> +     if (!wdev->ext_reset)
>> +             val &= ~IMX2_WDT_WCR_WRE;
>> +     /* Or if external-reset assert WDOG_B reset only on time-out */
>> +     else
>> +             val |= IMX2_WDT_WCR_WRE;
>
> I don't really understand what this means. Normally I would hope that a watchdog
> only generates a reset if/when it times out.

I think we went a couple of rounds on the info in the comment as well
in the previous patch reversions.

It is a feature of the IMX6 watchdog supported by this driver to be
able to trigger an internal chip-level reset and/or an external signal
that can be hooked to additional hardware.

In the case of using a PMIC that can regulate it's own rails (ie the
Freescale SabreSD reference design) an SoC chip-level reset will not
reset the PMIC and thus if the PMIC's rails have been driven down by
DVFS to a value below the necessary value for the chip to come up you
will hang (which is certainly not what you want to do when a watchdog
timeout occurs). The solution for designs that have a PMIC that is
able to change its voltage levels is to 'not' have the SoC internally
reset and to 'instead' drive an external reset signal that should
reset the PMIC (and possibly other chips if needed). The reason for
not allowing the internal reset is because as soon as the SoC goes
into reset it de-asserts the external reset which makes the time the
output is asserted un-deterministic.

Tim
