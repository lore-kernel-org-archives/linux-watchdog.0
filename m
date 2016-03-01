Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34509 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbcCAC4U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Feb 2016 21:56:20 -0500
Subject: Re: [PATCH 2/3] ipmi/watchdog: Use nmi_panic() when kernel panics in
 NMI handler
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>
References: <20160301015035.4318.78677.stgit@softrs>
 <20160301015039.4318.58063.stgit@softrs>
Cc: openipmi-developer@lists.sourceforge.net,
	Michal Hocko <mhocko@kernel.org>,
	Borislav Petkov <bp@alien8.de>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D504D2.3070701@roeck-us.net>
Date: Mon, 29 Feb 2016 18:56:18 -0800
MIME-Version: 1.0
In-Reply-To: <20160301015039.4318.58063.stgit@softrs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/29/2016 05:50 PM, Hidehiro Kawai wrote:
> commit 58c5661f2144 ("panic, x86: Allow CPUs to save registers even
> if looping in NMI context") introduced nmi_panic() which prevents
> concurrent/recursive execution of panic().  It also saves registers
> for the crash dump on x86.
>
> ipmi_watchdog driver can call panic() from NMI handler, so replace
> it with nmi_panic().
>
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/char/ipmi/ipmi_watchdog.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index 096f0ce..4facc75 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -1140,7 +1140,7 @@ ipmi_nmi(unsigned int val, struct pt_regs *regs)
>   		   the timer.   So do so. */
>   		pretimeout_since_last_heartbeat = 1;
>   		if (atomic_inc_and_test(&preop_panic_excl))
> -			panic(PFX "pre-timeout");
> +			nmi_panic(regs, PFX "pre-timeout");
>   	}
>
>   	return NMI_HANDLED;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

