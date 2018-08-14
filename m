Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41969 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQSM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Aug 2018 12:18:12 -0400
Subject: Re: [PATCH v2 2/5] watchdog: hpwdt: Claim NMI from iLO
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-3-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e3fcd8e8-abdf-6626-2a54-52de089bde5c@roeck-us.net>
Date: Tue, 14 Aug 2018 06:30:58 -0700
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-3-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> The hwpdt driver is overloaded for handling both the iLO
> watchdog and the explicit "Generate NMI to System" virutal
> button.  Hence NMI handler needs to claim NMI resulting
> from the virutal button.
> 
> Claim if iLO generated accommodating firmware that might
> set wrong bit.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index fae9364..bb41714 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -162,7 +162,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
>   		return NMI_DONE;
>   
> -	if (ilo5 && !pretimeout)
> +	if (ilo5 && !pretimeout && !mynmi)
>   		return NMI_DONE;
>   
>   	hpwdt_stop();
> 
