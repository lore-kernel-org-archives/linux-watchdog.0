Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46948 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeC0VFw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Mar 2018 17:05:52 -0400
Subject: Re: [PATCH] watchdog: wafer5823wdt: Mark expected switch fall-through
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180327193349.GA2547@embeddedgus>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <346fdc4e-321b-33dc-3b6a-a2d3a0617743@roeck-us.net>
Date: Tue, 27 Mar 2018 14:05:50 -0700
MIME-Version: 1.0
In-Reply-To: <20180327193349.GA2547@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/27/2018 12:33 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "Fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/wafer5823wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/wafer5823wdt.c b/drivers/watchdog/wafer5823wdt.c
> index db0da7e..93c5b61 100644
> --- a/drivers/watchdog/wafer5823wdt.c
> +++ b/drivers/watchdog/wafer5823wdt.c
> @@ -178,7 +178,7 @@ static long wafwdt_ioctl(struct file *file, unsigned int cmd,
>   		timeout = new_timeout;
>   		wafwdt_stop();
>   		wafwdt_start();
> -		/* Fall */
> +		/* Fall through */
>   	case WDIOC_GETTIMEOUT:
>   		return put_user(timeout, p);
>   
> 

