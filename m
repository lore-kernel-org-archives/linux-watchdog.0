Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40108 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHEDLq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Aug 2018 23:11:46 -0400
Subject: Re: [PATCH 2/4] watchdog: hpwdt: Claim NMI from iLO
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-3-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b4de8a19-00c6-fcca-2414-197056ef27bc@roeck-us.net>
Date: Sat, 4 Aug 2018 18:09:05 -0700
MIME-Version: 1.0
In-Reply-To: <1533244541-42310-3-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> The hwpdt driver is overloaded for handling both the iLO
> watchdog and the explicit "Generate NMI to System" virutal
> button.
> 
> Claim the iLO NMI virtual button even if we are not claiming
> the iLO watchdog pretimeout.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Guess you know what you are doing here.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 369022d..8a85ddd 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -162,7 +162,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
>   		return NMI_DONE;
>   
> -	if (ilo5 && !pretimeout)
> +	if (ilo5 && !pretimeout && !(mynmi & 0x4))
>   		return NMI_DONE;
>   
>   	hpwdt_stop();
> 

