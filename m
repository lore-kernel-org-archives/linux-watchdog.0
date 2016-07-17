Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43712 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751174AbcGQTsI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 15:48:08 -0400
Date: Sun, 17 Jul 2016 21:48:07 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/7] watchdog: softdog: cleanups
Message-ID: <20160717194807.GA32733@spo001.leaseweb.nl>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

> While working on another series where I need the softdog, this series already
> came out of it. It gets the driver prepared for the interesting stuff (coming
> later today hopefully) but is orthogonal from that.
> 
> Buildbot is happy, branch is here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/softdog_cleanup
> 
> Please review, comment, apply...
> 
> Thanks,
> 
>    Wolfram
> 
> Wolfram Sang (7):
>   watchdog: softdog: remove obsolete comments
>   watchdog: softdog: use watchdog core to init timeout value
>   watchdog: softdog: consistently use softdog_ prefix
>   watchdog: softdog: remove forward declaration
>   watchdog: softdog: sort includes to avoid duplicates
>   watchdog: softdog: drop superfluous set_timeout callback
>   watchdog: softdog: improve coding style
> 
>  drivers/watchdog/softdog.c | 92 +++++++++++-----------------------------------
>  1 file changed, 21 insertions(+), 71 deletions(-)
> 
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

These patches have been added to linux-watchdog-next.

Kind regards,
Wim.

