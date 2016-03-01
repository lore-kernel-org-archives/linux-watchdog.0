Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:37419 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbcCADaO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Feb 2016 22:30:14 -0500
Reply-to: minyard@acm.org
Subject: Re: [PATCH 2/3] ipmi/watchdog: Use nmi_panic() when kernel panics in
 NMI handler
References: <20160301015035.4318.78677.stgit@softrs>
 <20160301015039.4318.58063.stgit@softrs>
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: openipmi-developer@lists.sourceforge.net,
	Michal Hocko <mhocko@kernel.org>,
	Borislav Petkov <bp@alien8.de>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Corey Minyard <minyard@acm.org>
Message-id: <56D4FEAE.7080909@acm.org>
Date: Mon, 29 Feb 2016 20:30:06 -0600
MIME-version: 1.0
In-reply-to: <20160301015039.4318.58063.stgit@softrs>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Sure, this is a good idea.

Acked-by: Corey Minyard <cminyard@mvista.com>

Note that nmi_panic() came in commit 1717f2096b5 (panic, x86: Fix
re-entrance problem due to panic on NMI) and then the regs field
was added in the commit you reference.

Do you want me to add this to the IPMI queue or do you have another
way to get this patch into the kernel?

-corey

On 02/29/2016 07:50 PM, Hidehiro Kawai wrote:
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

