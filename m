Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34758 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751934AbcENQm6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 12:42:58 -0400
Date: Sat, 14 May 2016 18:42:55 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] watchdog: core: fix trivial typo in a comment
Message-ID: <20160514164255.GA20279@spo001.leaseweb.nl>
References: <1460476571-2351-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460476571-2351-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Let's have balanced round brackets.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/watchdog/watchdog_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index c1658fe73d58a1..6249ed34214a9f 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -104,7 +104,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>   * timeout module parameter (if it is valid value) or the timeout-sec property
>   * (only if it is a valid value and the timeout_parm is out of bounds).
>   * If none of them are valid then we keep the old value (which should normally
> - * be the default timeout value.
> + * be the default timeout value).
>   *
>   * A zero is returned on success and -EINVAL for failure.
>   */
> -- 
> 2.7.0
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

