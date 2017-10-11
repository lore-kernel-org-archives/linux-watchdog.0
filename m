Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33209 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdJKDfx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2017 23:35:53 -0400
Subject: Re: [PATCH 1/3] watchdog: orion: fix typo
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, wim@iguana.be,
        gregory.clement@free-electrons.com, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
 <20171011022958.31268-2-chris.packham@alliedtelesis.co.nz>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f7e30fe7-0aa8-9630-f277-cc8585760b98@roeck-us.net>
Date: Tue, 10 Oct 2017 20:35:42 -0700
MIME-Version: 1.0
In-Reply-To: <20171011022958.31268-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/10/2017 07:29 PM, Chris Packham wrote:
> Correct typo in comment "insterted" -> "inserted".
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/orion_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 83af7d6cc37c..ea676d233e1e 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -576,7 +576,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
>   	/*
>   	 * Let's make sure the watchdog is fully stopped, unless it's
>   	 * explicitly enabled. This may be the case if the module was
> -	 * removed and re-insterted, or if the bootloader explicitly
> +	 * removed and re-inserted, or if the bootloader explicitly
>   	 * set a running watchdog before booting the kernel.
>   	 */
>   	if (!orion_wdt_enabled(&dev->wdt))
> 

