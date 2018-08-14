Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42858 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQTQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Aug 2018 12:19:16 -0400
Subject: Re: [PATCH v2 5/5] watchdog: hpwdt: Update version number.
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-6-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <39fe61eb-52b1-7234-8b02-ecf41f1efdbe@roeck-us.net>
Date: Tue, 14 Aug 2018 06:32:03 -0700
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-6-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> Bump version number to reflect recent bug fixes.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index eb947bc..7af358b 100644
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
