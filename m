Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36310 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUBaI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Nov 2018 20:30:08 -0500
Subject: Re: [PATCH v2] watchdog: cpwd: add of_node_put()
To: Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181120145445.20730-1-tiny.windzz@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <205bee9b-7323-77ce-3f08-fa23ce7bdc9a@roeck-us.net>
Date: Tue, 20 Nov 2018 07:00:31 -0800
MIME-Version: 1.0
In-Reply-To: <20181120145445.20730-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/20/18 6:54 AM, Yangtao Li wrote:
> use of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> -do that right after its last use to also cover
>   error handling.
> ---
>   drivers/watchdog/cpwd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index aee0b25cf10d..32156e199c51 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c
> @@ -570,6 +570,8 @@ static int cpwd_probe(struct platform_device *op)
>   	if (str_prop)
>   		p->timeout = simple_strtoul(str_prop, NULL, 10);
>   
> +	of_node_put(options);
> +
>   	/* CP1400s seem to have broken PLD implementations-- the
>   	 * interrupt_mask register cannot be written, so no timer
>   	 * interrupts can be masked within the PLD.
> 
