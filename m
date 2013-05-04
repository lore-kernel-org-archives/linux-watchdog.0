Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:40120 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab3EDKTF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 4 May 2013 06:19:05 -0400
Date: Sat, 4 May 2013 12:18:59 +0200
From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, linux@roeck-us.net
Subject: Re: [PATCH 1/5] watchdog: at32ap700x: Remove redundant
 platform_set_drvdata()
Message-ID: <20130504101859.GA15645@samfundet.no>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Around Sat 04 May 2013 01:41:14 +0530 or thereabout, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.

You are sure cleaning up a lot of drivers, thanks (-:

> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/watchdog/at32ap700x_wdt.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)

<snipp diff>

-- 
HcE
