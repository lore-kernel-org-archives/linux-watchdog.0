Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37466 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHEDK6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Aug 2018 23:10:58 -0400
Subject: Re: [PATCH 1/4] watchdog: hpwdt: Initialize pretimeout from module
 parameter.
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-2-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1635a9b2-6b2a-fd57-13ea-d99494dbfdec@roeck-us.net>
Date: Sat, 4 Aug 2018 18:08:17 -0700
MIME-Version: 1.0
In-Reply-To: <1533244541-42310-2-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> When the pretimeout is specified as a module parameter, the
> value should be reflected in hpwdt_dev.pretimeout.  The default
> (on) case is correct.  But, when disabling pretimeout, the value
> should be set to zero in hpwdt_dev.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 9dc62a4..369022d 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -313,6 +313,11 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
>   		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
>   
> +#ifdef CONFIG_HPWDT_NMI_DECODING
> +	if (!pretimeout)
> +		hpwdt_dev.pretimeout = 0;
> +#endif
> +

Seems to me that
	hpwdt_dev.pretimeout = pretimeout ? PRETIMEOUT_SEC : 0;
would accomplish the same without ifdef. Also, that would make
the conditional initialization in hpwdt_dev unnecessary,
saving us some more ifdefs.

Guenter
