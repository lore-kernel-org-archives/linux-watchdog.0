Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37990 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQSf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Aug 2018 12:18:35 -0400
Subject: Re: [PATCH v2 3/5] watchdog: hpwdt: Display module parameters.
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-4-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e8113ab1-f8a3-aef8-6b7e-46b2ef29f93c@roeck-us.net>
Date: Tue, 14 Aug 2018 06:31:21 -0700
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-4-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> Print module parameters when the driver is loaded.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index bb41714..69a88b1 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -320,9 +320,12 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   		goto error_wd_register;
>   	}
>   
> -	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
> -			", timer margin: %d seconds (nowayout=%d).\n",
> -			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
> +	dev_info(&dev->dev, "HPE Watchdog Timer Driver: Version: %s\n",
> +				HPWDT_VERSION);
> +	dev_info(&dev->dev, "timeout: %d seconds (nowayout=%d)\n",
> +				hpwdt_dev.timeout, nowayout);
> +	dev_info(&dev->dev, "pretimeout: %s.\n",
> +				pretimeout ? "on" : "off");
>   
>   	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
>   		ilo5 = true;
> 
