Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:47933 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757947Ab3EYUjs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 May 2013 16:39:48 -0400
Date: Sat, 25 May 2013 22:39:47 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 3/5] watchdog: shwdt: Remove redundant platform_set_drvdata()
Message-ID: <20130525203947.GA13709@spo001.leaseweb.com>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org> <1367611878-3784-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1367611878-3784-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> ---
>  drivers/watchdog/shwdt.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.

