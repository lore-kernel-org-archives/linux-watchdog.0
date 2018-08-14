Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37180 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQRj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Aug 2018 12:17:39 -0400
Subject: Re: [PATCH v2 1/5] watchdog: hpwdt: Initialize pretimeout from module
 parameter.
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-2-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <088155d8-3e9e-51b1-d6e4-390cf74977f6@roeck-us.net>
Date: Tue, 14 Aug 2018 06:30:25 -0700
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-2-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> When the pretimeout is specified as a module parameter, the
> value should be reflected in hpwdt_dev.pretimeout.  The default
> (on) case is correct.  But, when disabling pretimeout, the value
> should be set to zero in hpwdt_dev.
> 
> When compiling w/o CONFIG_HPWDT_NMI_DECODING defined, the pretimeout
> module parameter is ignored and the value internally will be 0.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 9dc62a4..fae9364 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -205,9 +205,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   	.min_timeout	= 1,
>   	.max_timeout	= HPWDT_MAX_TIMER,
>   	.timeout	= DEFAULT_MARGIN,
> -#ifdef CONFIG_HPWDT_NMI_DECODING
>   	.pretimeout	= PRETIMEOUT_SEC,
> -#endif
>   };
>   
>   
> @@ -313,6 +311,8 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
>   		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
>   
> +	hpwdt_dev.pretimeout = pretimeout ? PRETIMEOUT_SEC : 0;
> +
>   	hpwdt_dev.parent = &dev->dev;
>   	retval = watchdog_register_device(&hpwdt_dev);
>   	if (retval < 0) {
> 
