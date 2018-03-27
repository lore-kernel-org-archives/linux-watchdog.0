Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38323 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeC0VFS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Mar 2018 17:05:18 -0400
Subject: Re: [PATCH] watchdog: sch311x_wdt: Mark expected switch fall-through
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180327192540.GA2293@embeddedgus>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f204da30-7ee6-b2a6-b369-35213af603c0@roeck-us.net>
Date: Tue, 27 Mar 2018 14:05:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180327192540.GA2293@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/27/2018 12:25 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "Fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sch311x_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
> index 43d0cbb..814cdf5 100644
> --- a/drivers/watchdog/sch311x_wdt.c
> +++ b/drivers/watchdog/sch311x_wdt.c
> @@ -299,7 +299,7 @@ static long sch311x_wdt_ioctl(struct file *file, unsigned int cmd,
>   		if (sch311x_wdt_set_heartbeat(new_timeout))
>   			return -EINVAL;
>   		sch311x_wdt_keepalive();
> -		/* Fall */
> +		/* Fall through */
>   	case WDIOC_GETTIMEOUT:
>   		return put_user(timeout, p);
>   	default:
> 

