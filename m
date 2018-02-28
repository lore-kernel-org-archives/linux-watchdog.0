Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44382 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeB1OcA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Feb 2018 09:32:00 -0500
Received: by mail-pf0-f193.google.com with SMTP id 17so1048657pfw.11
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Feb 2018 06:32:00 -0800 (PST)
Subject: Re: [PATCH] watchdog: f71808e_wdt: Fix magic close handling
To: Igor Pylypiv <igor.pylypiv@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org
References: <1519808352-17278-1-git-send-email-igor.pylypiv@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <dbfde2d6-3e57-ec66-6ca6-55ace45754d0@roeck-us.net>
Date: Wed, 28 Feb 2018 06:31:58 -0800
MIME-Version: 1.0
In-Reply-To: <1519808352-17278-1-git-send-email-igor.pylypiv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/28/2018 12:59 AM, Igor Pylypiv wrote:
> Watchdog close is "expected" when any byte is 'V' not just the last one.
> Writing "V" to the device fails because the last byte is the end of string.
> 
> $ echo V > /dev/watchdog
> f71808e_wdt: Unexpected close, not stopping watchdog!
> 
> Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Any volunteers to convert the driver to use the watchdog subsystem ?

Guenter

> ---
>   drivers/watchdog/f71808e_wdt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index e0678c1..3a33c53 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -566,7 +566,8 @@ static ssize_t watchdog_write(struct file *file, const char __user *buf,
>   				char c;
>   				if (get_user(c, buf + i))
>   					return -EFAULT;
> -				expect_close = (c == 'V');
> +				if (c == 'V')
> +					expect_close = true;
>   			}
>   
>   			/* Properly order writes across fork()ed processes */
> 

