Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34752 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeGBNiY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 2 Jul 2018 09:38:24 -0400
Subject: Re: [PATCH] watchdog: add NMI handler for iTCO watchdog
To: "Tian, Baofeng" <baofeng.tian@intel.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0038B620BAC72941BCBF48AEB892976C02CADE7E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1C063@shsmsx102.ccr.corp.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cf1a7c57-4b65-eba1-a420-103ab40f7103@roeck-us.net>
Date: Mon, 2 Jul 2018 06:38:18 -0700
MIME-Version: 1.0
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E1C063@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/02/2018 01:15 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: add NMI handler for iTCO watchdog
> 
> Add a NMI handler in iTCO watchdog driver probe.
> When iTCO watchdog timeout, it gernerate a NMI interrupt.

generate

Does it always do that ? My understanding is that it has to be configured to do so.

> The NMI handler will be called when iTCO NMI interrupt triggered.
> 
> In the NMI handler, it will dump all cpu backtraces
> and call panic to continue reboot.
> 
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>

As with other patches, the e-mail address is messed up.

If I recall correctly, we already had a similar patch trying to introduce MNI handling
to the driver a long time ago. I don't recall why it did not make it in, but there
must be some caveat. Someone will have to look that up and explain why this submission
is different and works. It would be great if you can do that; otherwise I'll have to
do it. Given my time constraints, that may take a while.

> ---
>   drivers/watchdog/iTCO_wdt.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 347f038..7a79d0f 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -68,6 +68,8 @@
>   #include <linux/io.h>              /* For inb/outb/... */
>   #include <linux/platform_data/itco_wdt.h>
> 
> +#include <linux/nmi.h>
> +#include <asm/nmi.h>
>   #include "iTCO_vendor.h"
> 
>   /* Address definitions for the TCO */
> @@ -86,6 +88,11 @@
>   #define TCO2_CNT(p)    (TCOBASE(p) + 0x0a) /* TCO2 Control Register    */
>   #define TCOv2_TMR(p)   (TCOBASE(p) + 0x12) /* TCOv2 Timer Initial Value*/
> 
> +#define TCO_RLD_sub(base)    (base + 0x00) /* TCO Timer Reload/Curr. Value */
> +#define TCO1_STS_sub(base)   (base + 0x04) /* TCO1 Status Register     */
> +#define TCOv2_TMR_sub(base)  (base + 0x12) /* TCOv2 Timer Initial Value*/
> +
> +
>   /* internal variables */
>   struct iTCO_wdt_private {
>        struct watchdog_device wddev;
> @@ -112,6 +119,14 @@ struct iTCO_wdt_private {
>        int (*update_no_reboot_bit)(void *p, bool set);
>   };
> 
> +static struct {
> +     resource_size_t tco_base_address;
> +     unsigned int iTCO_version;

Where is this variable used ?

> +     bool pretimeout_occurred;
> +     unsigned int second_to_ticks;

What is the point of this variable ? It is used as constant.

> +} iTCO_wdt_sub;
> +
> +

Checkpatch should tell you to avoid more than one empty line.

>   /* module parameters */
>   #define WATCHDOG_TIMEOUT 30  /* 30 sec default heartbeat */
>   static int heartbeat = WATCHDOG_TIMEOUT;  /* in seconds */
> @@ -422,6 +437,33 @@ static const struct watchdog_ops iTCO_wdt_ops = {
>        .get_timeleft =         iTCO_wdt_get_timeleft,
>   };
> 
> +static int iTCO_pretimeout(unsigned int cmd, struct pt_regs *unused_regs)
> +{
> +     resource_size_t tco_base_address;

What is the point of this variable ?

> +
> +     /* Prevent re-entrance */
> +     if (iTCO_wdt_sub.pretimeout_occurred)
> +           return NMI_HANDLED;
> +

This is odd and suggests that something may be wrong. There should
not be more than one NMI.

> +           tco_base_address = iTCO_wdt_sub.tco_base_address;

At the very least column alignment is wrong.

> +
> +     /* Check the NMI is from the TCO first expiration */
> +     if (inw(TCO1_STS_sub(tco_base_address)) & 0x8) {
> +           iTCO_wdt_sub.pretimeout_occurred = true;
> +
> +           /* Forward next expiration */
> +           outw(iTCO_wdt_sub.second_to_ticks, TCOv2_TMR_sub(tco_base_address));
> +           outw(0x01, TCO_RLD_sub(tco_base_address));
> +
> +           trigger_all_cpu_backtrace();

A wild guess is that arch_trigger_cpumask_backtrace() is not exported.
That means you can not call that function from here, and it strongly suggests
that the function is not supposed to be called from drivers, including
watchdog_drivers. Besides, panic() already triggers a backtrace.

> +           panic_timeout = 0;
> +           panic("Kernel Watchdog");
> +           return NMI_HANDLED;
> +     }
> +
> +     return NMI_DONE;
> +}
> +
>   /*
>    *   Init & exit routines
>    */
> @@ -555,6 +597,17 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>              return ret;
>        }
> 
> +    /* init vars that used for nmi handler */
> +     iTCO_wdt_sub.iTCO_version = p->iTCO_version;
> +     iTCO_wdt_sub.second_to_ticks = seconds_to_ticks(p, 10);

Where does the 10 come from ? What is the rationale ?

> +     iTCO_wdt_sub.tco_base_address = TCOBASE(p);
> +
> +     ret = register_nmi_handler(NMI_LOCAL, iTCO_pretimeout, 0, "iTCO_wdt");
> +     if (ret != 0) {
> +           pr_err("cannot register nmi handler (err=%d)\n", ret);
> +           return ret;

Return an error and leave the watchdog driver registered ? That will cause some
nice crashes.

> +     }
> +
>        pr_info("initialized. heartbeat=%d sec (nowayout=%d)\n",
>              heartbeat, nowayout);
> 
> -- 
> 2.7.4
> 

