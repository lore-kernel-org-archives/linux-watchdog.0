Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47803 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbcLPDfU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Dec 2016 22:35:20 -0500
Subject: Re: [PATCH] watchdog: mpc8xxx: Remove unneeded linux/miscdevice.h
 include
To: Corentin Labbe <clabbe.montjoie@gmail.com>, wim@iguana.be,
        linux-watchdog@vger.kernel.org
References: <20161215180344.22237-1-clabbe.montjoie@gmail.com>
Cc: linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8a154d8b-bee0-9a87-d95e-869778a44ca4@roeck-us.net>
Date: Thu, 15 Dec 2016 19:35:18 -0800
MIME-Version: 1.0
In-Reply-To: <20161215180344.22237-1-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/15/2016 10:03 AM, Corentin Labbe wrote:
> watchdog/mpc8xxx_wdt.c does not use any miscdevice so this patch remove
> this unnecessary inclusion.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mpc8xxx_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 5f2273a..366e5c7 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -23,7 +23,6 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/timer.h>
> -#include <linux/miscdevice.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/module.h>
>

