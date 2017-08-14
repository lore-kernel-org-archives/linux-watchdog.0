Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54667 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdHNPcc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 11:32:32 -0400
Date: Mon, 14 Aug 2017 08:32:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 0/3] watchdog: renesas_wdt: use standard clock
 handling
Message-ID: <20170814153230.GA7025@roeck-us.net>
References: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jul 26, 2017 at 11:54:36PM +0200, Wolfram Sang wrote:
> As mentioned in a response to a previous patch, clock handling for Renesas
> R-Car is done via RuntimePM. Patch 1 implements that consequently. Patch 2
> is a cleanup then possible and patch 3 is a trivial copyright update.
> 
> This is RFC because I'd like Geert's comments on these patches first which
> might take a few days...
> 
Was there any feedback from Geert ? I don't recall seeing any.

Guenter

> Looking forward to other comments, too, of course :)
> 
> These patches are on top of the already reviewed 'better-precision' series for
> this watchdog. A branch can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/watchdog-fixes
> 
> These patches have been tested on a Renesas Salvator-X / r8a7796 (R-Car M3-W)
> 
> Thanks and kind regards,
> 
>    Wolfram
> 
> 
> Wolfram Sang (3):
>   watchdog: renesas_wdt: consistently use RuntimePM for clock management
>   watchdog: renesas_wdt: make 'clk' a variable local to probe()
>   watchdog: renesas_wdt: update copyright dates
> 
>  drivers/watchdog/renesas_wdt.c | 47 +++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
