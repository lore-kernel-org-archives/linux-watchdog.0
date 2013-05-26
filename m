Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:48043 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752731Ab3EZOEj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 May 2013 10:04:39 -0400
Date: Sun, 26 May 2013 16:04:38 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	Timo Kokkonen <timo.t.kokkonen@nokia.com>
Subject: Re: [PATCH 5/5] watchdog: twl4030: Remove redundant platform_set_drvdata()
Message-ID: <20130526140438.GB7512@spo001.leaseweb.com>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org> <1367611878-3784-5-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1367611878-3784-5-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Timo Kokkonen <timo.t.kokkonen@nokia.com>
> ---
>  drivers/watchdog/twl4030_wdt.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.

