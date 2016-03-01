Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36002 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbcCAIuV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Mar 2016 03:50:21 -0500
Date: Tue, 1 Mar 2016 09:50:18 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>,
	openipmi-developer@lists.sourceforge.net,
	Borislav Petkov <bp@alien8.de>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ipmi/watchdog: Use nmi_panic() when kernel panics in
 NMI handler
Message-ID: <20160301085017.GB9461@dhcp22.suse.cz>
References: <20160301015035.4318.78677.stgit@softrs>
 <20160301015039.4318.58063.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160301015039.4318.58063.stgit@softrs>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue 01-03-16 10:50:39, Hidehiro Kawai wrote:
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

Reviewed-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/char/ipmi/ipmi_watchdog.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index 096f0ce..4facc75 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -1140,7 +1140,7 @@ ipmi_nmi(unsigned int val, struct pt_regs *regs)
>  		   the timer.   So do so. */
>  		pretimeout_since_last_heartbeat = 1;
>  		if (atomic_inc_and_test(&preop_panic_excl))
> -			panic(PFX "pre-timeout");
> +			nmi_panic(regs, PFX "pre-timeout");
>  	}
>  
>  	return NMI_HANDLED;
> 

-- 
Michal Hocko
SUSE Labs
