Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43574 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965078AbcDLRLU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Apr 2016 13:11:20 -0400
Date: Tue, 12 Apr 2016 10:11:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] watchdog: core: fix trivial typo in a comment
Message-ID: <20160412171122.GA12407@roeck-us.net>
References: <1460476571-2351-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460476571-2351-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 12, 2016 at 05:56:11PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Let's have balanced round brackets.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Nice catch. Shows that someone is actually reading comments :-)

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
