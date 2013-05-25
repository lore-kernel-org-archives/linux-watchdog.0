Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:47882 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757624Ab3EYTAV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 May 2013 15:00:21 -0400
Date: Sat, 25 May 2013 21:00:19 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 1/5] watchdog: at32ap700x: Remove redundant platform_set_drvdata()
Message-ID: <20130525190019.GA12506@spo001.leaseweb.com>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> ---
>  drivers/watchdog/at32ap700x_wdt.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.

