Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33941 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbcCACzb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Feb 2016 21:55:31 -0500
Subject: Re: [PATCH 3/3] hpwdt: Use nmi_panic() when kernel panics in NMI
 handler
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>
References: <20160301015035.4318.78677.stgit@softrs>
 <20160301015041.4318.93922.stgit@softrs>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	openipmi-developer@lists.sourceforge.net
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D5049C.50207@roeck-us.net>
Date: Mon, 29 Feb 2016 18:55:24 -0800
MIME-Version: 1.0
In-Reply-To: <20160301015041.4318.93922.stgit@softrs>
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
> hpwdt driver can call panic() from NMI handler, so replace it with
> nmi_panic().
>
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Thomas Mingarelli <thomas.mingarelli@hpe.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> ---
>   drivers/watchdog/hpwdt.c |   12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 92443c3..fd0486f 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -496,11 +496,12 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>
>   	if (!is_icru && !is_uefi) {
>   		if (cmn_regs.u1.ral == 0) {
> -			panic("An NMI occurred, "
> +			nmi_panic(regs, "An NMI occurred, "
>   				"but unable to determine source.\n");

This message should really be in a single line.
Sure, strictly speaking that should be done in a separate patch,
but since you touch the line you might as well fix it.

> +			goto handled;

The goto is unnecessary. Just return NMI_HANDLED.

>   		}
>   	}
> -	panic("An NMI occurred. Depending on your system the reason "
> +	nmi_panic(regs, "An NMI occurred. Depending on your system the reason "
>   		"for the NMI is logged in any one of the following "
>   		"resources:\n"
>   		"1. Integrated Management Log (IML)\n"
> @@ -508,6 +509,13 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   		"3. OA Forward Progress Log\n"
>   		"4. iLO Event Log");
>
> +handled:
> +	/*
> +	 * Returning from nmi_panic() means this CPU was processing panic()
> +	 * before NMI.  Return NMI_HANDLED and go back to panic routines.
> +	 */

I don't think this comment adds much if any value.

> +	return NMI_HANDLED;
> +
>   out:

Any goto to this label does no longer serve a useful purpose (if it ever served one),
and should be replaced with "return NMI_DONE;"

>   	return NMI_DONE;
>   }
>
>
>

