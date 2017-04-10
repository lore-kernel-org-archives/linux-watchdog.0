Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39304 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753249AbdDJVni (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Apr 2017 17:43:38 -0400
Subject: Re: [PATCH] watchdog: fix build error if define SOFTWARE_REBOOT
To: Shile Zhang <shile.zhang@nokia.com>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1491835173-34840-1-git-send-email-shile.zhang@nokia.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <587bcbe0-8c83-8798-bdb4-fe189c1056ce@roeck-us.net>
Date: Mon, 10 Apr 2017 14:43:34 -0700
MIME-Version: 1.0
In-Reply-To: <1491835173-34840-1-git-send-email-shile.zhang@nokia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/10/2017 07:39 AM, Shile Zhang wrote:
> To fix following build error when SOFTWARE_REBOOT is defined:
>
>   CC [M]  driver/watchdog/wdt_pci.o
> driver/watchdog/wdt_pci.c: In function 'wdtpci_interrupt':
> driver/watchdog/wdt_pci.c:335:3: error: too many arguments to function 'emergency_restart'
>    emergency_restart(NULL);
>    ^
> In file included from driver/watchdog/wdt_pci.c:51:0:
> include/linux/reboot.h:80:13: note: declared here
>  extern void emergency_restart(void);
>              ^
>
> Signed-off-by: Shile Zhang <shile.zhang@nokia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wdt_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
> index 48b2c05..bc7addc 100644
> --- a/drivers/watchdog/wdt_pci.c
> +++ b/drivers/watchdog/wdt_pci.c
> @@ -332,7 +332,7 @@ static irqreturn_t wdtpci_interrupt(int irq, void *dev_id)
>  		pr_crit("Would Reboot\n");
>  #else
>  		pr_crit("Initiating system reboot\n");
> -		emergency_restart(NULL);
> +		emergency_restart();
>  #endif
>  #else
>  		pr_crit("Reset in 5ms\n");
>

