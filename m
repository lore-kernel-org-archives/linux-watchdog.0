Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49655 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdHCFPW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 3 Aug 2017 01:15:22 -0400
Subject: Re: [PATCH] watchdog: moxart_wdt: Replace decimal permissions with 4
 digit octal
To: SZ Lin <sz.lin@moxa.com>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170729091543.11777-1-sz.lin@moxa.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9775443d-5b4e-4022-51a4-af678489d1a2@roeck-us.net>
Date: Wed, 2 Aug 2017 22:15:19 -0700
MIME-Version: 1.0
In-Reply-To: <20170729091543.11777-1-sz.lin@moxa.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/29/2017 02:15 AM, SZ Lin wrote:
> ERROR: Use 4 digit octal (0777) not decimal permissions
> 
> This error was detected by checkpatch.pl
> 
> Signed-off-by: SZ Lin <sz.lin@moxa.com>

I think checkpatch is overdoing it a bit here. There are more than 2,000 of those.
Plus, I really don't see the value in this change.

Guenter

> ---
>   drivers/watchdog/moxart_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
> index 2c4a73d1e214..05684aa89b88 100644
> --- a/drivers/watchdog/moxart_wdt.c
> +++ b/drivers/watchdog/moxart_wdt.c
> @@ -170,7 +170,7 @@ static struct platform_driver moxart_wdt_driver = {
>   };
>   module_platform_driver(moxart_wdt_driver);
>   
> -module_param(heartbeat, int, 0);
> +module_param(heartbeat, int, 0000);
>   MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds");
>   
>   MODULE_DESCRIPTION("MOXART watchdog driver");
> 

