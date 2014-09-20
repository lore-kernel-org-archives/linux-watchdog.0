Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52339 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbaITNwZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 20 Sep 2014 09:52:25 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XVL5N-002SwU-DA
	for linux-watchdog@vger.kernel.org; Sat, 20 Sep 2014 13:52:25 +0000
Message-ID: <541D867C.6080407@roeck-us.net>
Date: Sat, 20 Sep 2014 06:51:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jisheng Zhang <jszhang@marvell.com>, wim@iguana.be
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] watchdog: dw_wdt: restart the counter immediately
 after enabling WDT
References: <1411108199-1280-1-git-send-email-jszhang@marvell.com> <1411108199-1280-2-git-send-email-jszhang@marvell.com>
In-Reply-To: <1411108199-1280-2-git-send-email-jszhang@marvell.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/18/2014 11:29 PM, Jisheng Zhang wrote:
> The TOP_INIT may be zero, so the timeout period may be very short after
> initialization is done, thus the system may be reset soon after enabling.
> We fix this problem by restarting the counter immediately after enabling
> WDT.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   drivers/watchdog/dw_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 9f21029..ad0619d 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -146,6 +146,7 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
>   		dw_wdt_set_top(DW_WDT_MAX_TOP);
>   		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
>   		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
> +		dw_wdt_keepalive();
>   	}
>
>   	dw_wdt_set_next_heartbeat();
>
After getting access to the datasheet, I concluded that this fix is wrong
or at least more risky than necessary. The datasheet states that top_init,
ie bit 4-7 of the wdt_torr register, needs to be initialized with the desired
timeout period prior to enabling the watchdog. dw_wdt_set_top() sets it to
0 instead, ie to the lowest possible timeout period.

Guenter

