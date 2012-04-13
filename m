Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63694 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932603Ab2DMI6O (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Apr 2012 04:58:14 -0400
Message-ID: <4F87EB25.6050709@redhat.com>
Date: Fri, 13 Apr 2012 11:00:21 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 4/4] watchdog: use dev_ functions
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk> <20120321152532.20045.87765.stgit@bob.linux.org.uk>
In-Reply-To: <20120321152532.20045.87765.stgit@bob.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Looks good, ack.

Acked-by: Hans de Goede <hdegoede@redhat.com>

On 03/21/2012 04:25 PM, Alan Cox wrote:
> From: Alan Cox<alan@linux.intel.com>
>
> While they are registered all our watchdogs now have a valid device object
> so we can in turn use that to report problems nicely.
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   drivers/watchdog/watchdog_dev.c |    5 ++---
>   1 files changed, 2 insertions(+), 3 deletions(-)
>
>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index abefa56..902a3af 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -110,8 +110,7 @@ static int watchdog_stop(struct watchdog_device *wddev)
>   	int err = -EBUSY;
>
>   	if (test_bit(WDOG_NO_WAY_OUT,&wddev->status)) {
> -		pr_info("%s: nowayout prevents watchdog to be stopped!\n",
> -							wddev->info->identity);
> +		dev_info(wddev->dev, "nowayout prevents watchdog being stopped!\n");
>   		return err;
>   	}
>
> @@ -348,7 +347,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
>
>   	/* If the watchdog was not stopped, send a keepalive ping */
>   	if (err<  0) {
> -		pr_crit("%s: watchdog did not stop!\n", wdd->info->identity);
> +		dev_crit(wdd->dev, "watchdog did not stop!\n");
>   		watchdog_ping(wdd);
>   	}
>
>
