Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41645 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbcBFRKg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Feb 2016 12:10:36 -0500
Subject: Re: [PATCH] watchdog: w83627hf: Added NCT6102D support.
To: Rob Kramer <rob@solution-space.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <56B40FCD.1010802@solution-space.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56B6290B.6010904@roeck-us.net>
Date: Sat, 6 Feb 2016 09:10:35 -0800
MIME-Version: 1.0
In-Reply-To: <56B40FCD.1010802@solution-space.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/04/2016 06:58 PM, Rob Kramer wrote:
> As used in (and tested on) the ASRock IMB-150 board. Implementation is
> identical to other NCT chips, just with different registers.
>
> Signed-off-by: Rob Kramer <rob@solution-space.com>

Rob,

your patch is whitespace damaged (tabs replaced with spaces) and can not be applied.
Please resend.

Thanks,
Guenter

> ---
>   drivers/watchdog/Kconfig        |  1 +
>   drivers/watchdog/w83627hf_wdt.c | 22 +++++++++++++++++++---
>   2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be..318d8bc 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1140,6 +1140,7 @@ config W83627HF_WDT
>           NCT6779
>           NCT6791
>           NCT6792
> +        NCT6102D/04D/06D
>
>         This watchdog simply watches your kernel to make sure it doesn't
>         freeze, and if it does, it reboots your computer after a certain
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index cab14bc..09e8003 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -45,10 +45,11 @@
>   static int wdt_io;
>   static int cr_wdt_timeout;    /* WDT timeout register */
>   static int cr_wdt_control;    /* WDT control register */
> +static int cr_wdt_csr;        /* WDT control & status register */
>
>   enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>            w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
> -         w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792 };
> +         w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6102 };
>
>   static int timeout;            /* in seconds */
>   module_param(timeout, int, 0);
> @@ -92,15 +93,21 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
>   #define W83667HG_B_ID        0xb3
>   #define NCT6775_ID        0xb4
>   #define NCT6776_ID        0xc3
> +#define NCT6102_ID        0xc4
>   #define NCT6779_ID        0xc5
>   #define NCT6791_ID        0xc8
>   #define NCT6792_ID        0xc9
>
>   #define W83627HF_WDT_TIMEOUT    0xf6
>   #define W83697HF_WDT_TIMEOUT    0xf4
> +#define NCT6102D_WDT_TIMEOUT    0xf1
>
>   #define W83627HF_WDT_CONTROL    0xf5
>   #define W83697HF_WDT_CONTROL    0xf3
> +#define NCT6102D_WDT_CONTROL    0xf0
> +
> +#define W836X7HF_WDT_CSR    0xf7
> +#define NCT6102D_WDT_CSR    0xf2
>
>   static void superio_outb(int reg, int val)
>   {
> @@ -197,6 +204,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>       case nct6779:
>       case nct6791:
>       case nct6792:
> +    case nct6102:
>           /*
>            * These chips have a fixed WDTO# output pin (W83627UHG),
>            * or support more than one WDTO# output pin.
> @@ -229,8 +237,8 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>       superio_outb(cr_wdt_control, t);
>
>       /* reset trigger, disable keyboard & mouse turning off watchdog */
> -    t = superio_inb(0xF7) & ~0xD0;
> -    superio_outb(0xF7, t);
> +    t = superio_inb(cr_wdt_csr) & ~0xD0;
> +    superio_outb(cr_wdt_csr, t);
>
>       superio_exit();
>
> @@ -322,6 +330,7 @@ static int wdt_find(int addr)
>
>       cr_wdt_timeout = W83627HF_WDT_TIMEOUT;
>       cr_wdt_control = W83627HF_WDT_CONTROL;
> +    cr_wdt_csr = W836X7HF_WDT_CSR;
>
>       ret = superio_enter();
>       if (ret)
> @@ -387,6 +396,12 @@ static int wdt_find(int addr)
>       case NCT6792_ID:
>           ret = nct6792;
>           break;
> +    case NCT6102_ID:
> +        ret = nct6102;
> +        cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
> +        cr_wdt_control = NCT6102D_WDT_CONTROL;
> +        cr_wdt_csr = NCT6102D_WDT_CSR;
> +        break;
>       case 0xff:
>           ret = -ENODEV;
>           break;
> @@ -422,6 +437,7 @@ static int __init wdt_init(void)
>           "NCT6779",
>           "NCT6791",
>           "NCT6792",
> +        "NCT6102",
>       };
>
>       wdt_io = 0x2e;

