Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35070 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbaLHUMG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 8 Dec 2014 15:12:06 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xy4f7-003sxW-6O
	for linux-watchdog@vger.kernel.org; Mon, 08 Dec 2014 20:12:05 +0000
Date: Mon, 8 Dec 2014 12:11:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Robert Yang <hachyang@gmail.com>
Cc: Wim Van Seroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, ryang <ryang@hach.com>
Subject: Re: [PATCH 1/1] Watchdog: Fixed the watchdog close/stop logic - only
 close the watchdog if the magic character was received and the magic close
 is supported.
Message-ID: <20141208201158.GA29618@roeck-us.net>
References: <1418060711-47872-1-git-send-email-hachyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418060711-47872-1-git-send-email-hachyang@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 08, 2014 at 10:45:11AM -0700, Robert Yang wrote:
> From: ryang <ryang@hach.com>
> 
> Signed-off-by: ryang <ryang@hach.com>
> ---
>  drivers/watchdog/watchdog_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 6aaefba..73793d8 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -471,8 +471,8 @@ static int watchdog_release(struct inode *inode, struct file *file)
>  	 */
>  	if (!test_bit(WDOG_ACTIVE, &wdd->status))
>  		err = 0;
> -	else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
> -		 !(wdd->info->options & WDIOF_MAGICCLOSE))
> +	else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) &&
> +		(wdd->info->options & WDIOF_MAGICCLOSE))
>  		err = watchdog_stop(wdd);
>  
Why ?

Guenter
