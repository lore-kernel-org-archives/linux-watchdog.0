Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
Date: Thu, 6 Sep 2018 00:03:21 -0600
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] watchdog: hpwdt: Bug Fixes/Enhancement
Message-ID: <20180906060321.GA14264@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Aug 08, 2018 at 01:13:22PM -0600, Jerry Hoemann wrote:
> Changes for v2
> 
> 1) Patch 0001: Simplify initialization of pretimeout removing #ifdef.
> 2) Patch 0002: Loosen check on mynmi to accommodate potential FW issue.
> 3) Patch 0003: Split dev_info into mulitple calls as output was getting long.
> 4) Patch 0004: New: Add alias to module parameter soft_margin.
> 

Wim,

I would like to get our Distro partners to back port these changes,
but they must first be upstream.  :)

Do you know when you will include these in a pull request so that I can
pass on to them when to schedule the work?

Thanks

The patch e-mails are at:
	https://lkml.org/lkml/2018/8/8/769

Jerry

> 
> -----------------------------
> 
> Two defect fixes and one enhancement.  
> 
> 0001: Initialize pretimeout from module parameter.
> 
> Bug Fix.
> 
> Pretimeout was getting programmed correctly in the hardware,
> but this issue caused it to not be displayed correctly
> in sysfs.
> 
> 
> 
> 0002: Claim NMI from iLO
> 
> Bug Fix.
> 
> Default configuration worked, but if user were to disable the
> pretimeout for the watchdog, then an explicit request to NMI
> the system from the iLO virutal button would fail.
> 
> 
> 0003: Display module parameters
> 
> Enhancement.
> 
> Display all the module parameters when loading the driver.
> Makes it easier to diagnose problems.
> 
> 
> Jerry
> 
> 
> Jerry Hoemann (5):
>   watchdog: hpwdt: Initialize pretimeout from module parameter.
>   watchdog: hpwdt: Claim NMI from iLO
>   watchdog: hpwdt: Display module parameters.
>   watchdog: hpwdt: Module paramerter alias.
>   watchdog: hpwdt: Update version number.
> 
>  drivers/watchdog/hpwdt.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> -- 
> 1.8.3.1

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
