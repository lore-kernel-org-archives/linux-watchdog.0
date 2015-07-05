Return-path: <ariel@vanguardiasur.com.ar>
Message-ID: <5598911B.5020004@vanguardiasur.com.ar>
Date: Sat, 04 Jul 2015 23:06:19 -0300
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
MIME-Version: 1.0
To: Joachim Eastwood <manabian@gmail.com>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be, linux@roeck-us.net,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
References: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>	<1435783930-20184-2-git-send-email-ariel@vanguardiasur.com.ar> <CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
In-Reply-To: <CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Joachim,

El 01/07/15 a las 20:04, Joachim Eastwood escibió:
> Hi Ariel,
> 
> On 1 July 2015 at 22:52, Ariel D'Alessandro <ariel@vanguardiasur.com.ar> wrote:
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 742fbbc..31100c2 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -547,6 +547,17 @@ config DIGICOLOR_WATCHDOG
>>           To compile this driver as a module, choose M here: the
>>           module will be called digicolor_wdt.
>>
>> +config LPC18XX_WATCHDOG
>> +       tristate "LCP18XX Watchdog"
> 
> LPC18xx/43xx in tristate to indicate that is usable for both families.

Ok, I'll do that.

> 
>> +       depends on ARCH_LPC18XX
>> +       select WATCHDOG_CORE
> 
> Maybe add COMPILE_TEST. At least a couple of other watchdog drivers does that.

Yes, that's correct. I'll add it in the next version.

> 
>> +       help
>> +         Say Y here if to include support for the watchdog timer
>> +         in NXP LPC SoCs family, which includes LPC18xx/LPC43xx
>> +         processors.
>> +         To compile this driver as a module, choose M here: the
>> +         module will be called lpc18xx_wdt.
>> +
> [...]
>> +static int lpc18xx_wdt_feed(struct watchdog_device *wdt_dev)
>> +{
>> +       struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
>> +       unsigned long flags;
>> +
>> +       /*
>> +        * An abort condition will occur if an interrupt happens during the feed
>> +        * sequence.
>> +        */
>> +       raw_local_irq_save(flags);
> 
> Any particular reason why you are using the raw variant of
> local_irq_save/restore?
> raw_local_irq_save doesn't seem to be a common function for drivers to
> call at all.

No, you're right, raw variants don't seem to be necessary.

> 
> If you need a lock to protect register access as well you could use a
> spin lock with irq save.

Yes but, as Ezequiel said in his response, the watchdog framework
serializes this access. So I think a lock isn't necessary.

> 
>> +       writel(LPC18XX_WDT_FEED_MAGIC1, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
>> +       writel(LPC18XX_WDT_FEED_MAGIC2, lpc18xx_wdt->base + LPC18XX_WDT_FEED);
>> +       raw_local_irq_restore(flags);
>> +
>> +       return 0;
>> +}
> [...]
>> +unsigned int lpc18xx_wdt_get_timeleft(struct watchdog_device *wdt_dev)
>> +{
>> +       struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
>> +       unsigned long clk_rate = clk_get_rate(lpc18xx_wdt->wdt_clk);
>> +       unsigned int val;
>> +
>> +       val = readl(lpc18xx_wdt->base + LPC18XX_WDT_TV);
>> +       return ((val * LPC18XX_WDT_CLK_DIV) / clk_rate);
> 
> Outer parentheses on return is unnecessary.

You're right, I'll fix it.

> 
>> +}
>> +
>> +static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
>> +{
>> +       struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
>> +       unsigned int val;
>> +
>> +       if (timer_pending(&lpc18xx_wdt->timer))
>> +               del_timer(&lpc18xx_wdt->timer);
>> +
>> +       val = readl(lpc18xx_wdt->base + LPC18XX_WDT_MOD);
>> +       val |= LPC18XX_WDT_MOD_WDEN;
>> +       val |= LPC18XX_WDT_MOD_WDRESET;
>> +       writel(val, lpc18xx_wdt->base + LPC18XX_WDT_MOD);
> 
> R-M-W sequence should probably be protect with a lock.

We can continue discussing this point on Ezequiel's response.

> 
>> +       /*
>> +        * Setting the WDEN bit in the WDMOD register is not sufficient to
>> +        * enable the Watchdog. A valid feed sequence must be completed after
>> +        * setting WDEN before the Watchdog is capable of generating a reset.
>> +        */
>> +       lpc18xx_wdt_feed(wdt_dev);
>> +
>> +       return 0;
>> +}
> 
> 
> regards,
> Joachim Eastwood
> 
