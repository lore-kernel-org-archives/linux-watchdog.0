Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:47310 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755035Ab2CZI1V (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Mar 2012 04:27:21 -0400
Date: Mon, 26 Mar 2012 10:27:17 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linus.walleij@stericsson.com, linux-watchdog@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: Commit "watchdog: coh901327_wdt.c: fix timeout" breaks linux-next
Message-ID: <20120326082717.GX10698@spo001.leaseweb.com>
References: <CAP=VYLr4MfkBpgg-QeMRw9oDswtrySBEb6ZUKa8_CLOHh+pF2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP=VYLr4MfkBpgg-QeMRw9oDswtrySBEb6ZUKa8_CLOHh+pF2A@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Paul,

Will fix it.

Kind regards,
wim.

> Hi Wim,
> 
> Can you please re-check this commit?  It has two instances of
> the typo "timout" and one of them is causing a build failure
> in linux-next.
> 
> Thanks,
> Paul.
> --
> 
> drivers/watchdog/coh901327_wdt.c:358:15: error: 'struct
> watchdog_device' has no member named 'timout'
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/5940810/
> 
> commit 884f1a12c8b39721452f0dfedf1f82de3d696cf1
> Author: Wim Van Sebroeck <wim@iguana.be>
> Date:   Thu Mar 22 20:42:16 2012 +0100
> 
>     watchdog: coh901327_wdt.c: fix timeout
> 
>     Set the timeout value properly so that we don't get faulty values
>     for the WDIOC_GETTIMEOUT iotcl. 'margin' should be an unsigned int.
>     Also add a check to see if margin is a valid parameter after it is
>     loaded as a module.
