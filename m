Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35224 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHEDQB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Aug 2018 23:16:01 -0400
Subject: Re: [PATCH 3/4] watchdog: hpwdt: Display module parameters.
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-4-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ba07e5f3-282f-0417-236d-57289d33f56c@roeck-us.net>
Date: Sat, 4 Aug 2018 18:13:20 -0700
MIME-Version: 1.0
In-Reply-To: <1533244541-42310-4-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> Print module parameters when the driver is loaded.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 8a85ddd..f098371 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -326,8 +326,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   	}
>   
>   	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
> -			", timer margin: %d seconds (nowayout=%d).\n",
> -			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
> +		", timeout : %d seconds (nowayout=%d) pretimeout=%s.\n",
> +		HPWDT_VERSION, hpwdt_dev.timeout, nowayout,
> +		pretimeout ? "on" : "off");
>   
When touching that, you might as well address

WARNING: quoted string split across lines

Why did you add a space before ':' ? Personal preference ?

Guenter

>   	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
>   		ilo5 = true;
> 

