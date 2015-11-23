Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:43043 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbbKWPiK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 10:38:10 -0500
Date: Mon, 23 Nov 2015 10:37:48 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Harald Geyer <harald@ccbib.org>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	Vivien Didelot <vivien.didelot@savoirlinux.com>,
	linux@roeck-us.net
Subject: Re: In-reply-to:
 <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <20151123153747.GA13332@localhost>
References: <1448056496-2335-2-git-send-email-damien.riegel@savoirfairelinux.com>
 <E1a0sdo-0000RV-FA@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1a0sdo-0000RV-FA@stardust.g4.wien.funkfeuer.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

[Ccing Guenter as he reviewed the patches]

On Mon, Nov 23, 2015 at 04:02:52PM +0100, Harald Geyer wrote:
> Hi,
> 
> sorry for breaking the threading. Only stumbled upon this message in the
> webarchive of the Mailinglist and couldn't reconstruct full headers ...
> 
> I think there is an issue with your patch:
> 
> +static int watchdog_reboot_notifier(struct notifier_block *nb,
> +				    unsigned long code, void *data)
> +{
> +	struct watchdog_device *wdd = container_of(nb, struct watchdog_device,
> +						   reboot_nb);
> +
> +	if (code == SYS_DOWN || code == SYS_HALT) {
> 
> I think you want this to be (code == SYS_POWER_OFF || code == SYS_HALT)
> AFAIK SYS_DOWN is the code for a reboot, where the system should come
> back up immediatly, so probably we shouldn't disable the watchdog in
> this case, for the system might crash during going down.

Well, most of the drivers (all of them but gpio) that I changed stopped
on SYS_HALT and SYS_DOWN, so they explicitely wanted to stop the
watchdog on reboot. I just factorized that in watchdog core.

Maybe they should not stop on reboot in the first place, but this serie
does not introduce a new behaviour. Also, note that the watchdog will
be stopped only if it registers for that by calling
watchdog_stop_on_reboot, so there is no side effect for watchdogs that
should not be stopped.

> 
> More importantly however we should stop the watchdog on SYS_POWER_OFF
> I think.
> 
My understanding here is that if the system is powered off, the watchdog
will be powered off too, so there is no need to stop it.


Damien

> Otherwise your series looks good to me and I look forward to rebase
> my own patches on it.
> 
> HTH,
> Harald
> 
> +		if (watchdog_active(wdd)) {
> +			int ret;
> +
> +			ret = wdd->ops->stop(wdd);
> +			if (ret)
> +				return NOTIFY_BAD;
> +		}
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> -- 
> If you want to support my work:
> see http://friends.ccbib.org/harald/supporting/
> or donate via bitcoin to 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
