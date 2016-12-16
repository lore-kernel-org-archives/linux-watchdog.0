Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47324 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754013AbcLPDex (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Dec 2016 22:34:53 -0500
Subject: Re: [PATCH] watchdog: octeon: Remove unneeded linux/miscdevice.h
 include
To: Corentin Labbe <clabbe.montjoie@gmail.com>, wim@iguana.be,
        linux-watchdog@vger.kernel.org
References: <20161215174929.12493-1-clabbe.montjoie@gmail.com>
Cc: linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8d62c15f-e46a-0ee4-b802-7bfe44be7e15@roeck-us.net>
Date: Thu, 15 Dec 2016 19:34:50 -0800
MIME-Version: 1.0
In-Reply-To: <20161215174929.12493-1-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/15/2016 09:49 AM, Corentin Labbe wrote:
> watchdog/octeon-wdt-main.c does not use any miscdevice so this patch
> remove this unnecessary inclusion.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/octeon-wdt-main.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
> index 529182d..b5cdceb 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -56,7 +56,6 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> -#include <linux/miscdevice.h>
>  #include <linux/interrupt.h>
>  #include <linux/watchdog.h>
>  #include <linux/cpumask.h>
>

