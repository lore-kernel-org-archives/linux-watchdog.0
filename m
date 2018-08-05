Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41042 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHEDSm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Aug 2018 23:18:42 -0400
Subject: Re: [PATCH 4/4] watchdog: hpwdt: Update version number.
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-5-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <056cf690-6a25-c921-5bb1-217ea1c9536c@roeck-us.net>
Date: Sat, 4 Aug 2018 18:16:00 -0700
MIME-Version: 1.0
In-Reply-To: <1533244541-42310-5-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> Bump version number to reflect recent bug fixes.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

As usual, my recommendation is to drop version numbers. The version number is
reflected by the Linux kernel version and SHA. Yet, I understand that people
feel quite strong about having version numbers in drivers, so,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Just don't expect anyone outside hpe to keep it up to date.

Guenter

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index f098371..27091f3 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -26,7 +26,7 @@
>   #include <linux/watchdog.h>
>   #include <asm/nmi.h>
>   
> -#define HPWDT_VERSION			"2.0.0"
> +#define HPWDT_VERSION			"2.0.1"
>   #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
>   #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
>   #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
> 

