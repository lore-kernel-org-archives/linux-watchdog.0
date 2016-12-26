Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35309 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbcLZUMi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Dec 2016 15:12:38 -0500
Subject: Re: [PATCH v2] watchdog: constify watchdog_info structures
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
        wim@iguana.be, linux@roeck-us.net, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        support.opensource@diasemi.com, baruch@tkos.co.il,
        manabian@gmail.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4e7daea3-19d1-a8a8-c15a-9e3f5785d817@gmail.com>
Date: Mon, 26 Dec 2016 12:12:35 -0800
MIME-Version: 1.0
In-Reply-To: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Le 12/26/16 à 09:05, Bhumika Goyal a écrit :
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> Changes in v2:
>   * Drop "drivers:" from the subject line.
>   * Remove the file size details.
> 
>  drivers/watchdog/bcm7038_wdt.c   | 2 +-

> diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
> index e238df4..37c6a49 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
> @@ -101,7 +101,7 @@ static unsigned int bcm7038_wdt_get_timeleft(struct watchdog_device *wdog)
>  	return time_left / wdt->rate;
>  }

For BCM7038 WDT:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
