Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57048 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbbKWP6E (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 10:58:04 -0500
Subject: Re: In-reply-to:
 <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
To: Harald Geyer <harald@ccbib.org>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
References: <E1a0sdo-0000RV-FA@stardust.g4.wien.funkfeuer.at>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	Vivien Didelot <vivien.didelot@savoirlinux.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56533787.8070205@roeck-us.net>
Date: Mon, 23 Nov 2015 07:57:59 -0800
MIME-Version: 1.0
In-Reply-To: <E1a0sdo-0000RV-FA@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/23/2015 07:02 AM, Harald Geyer wrote:
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
>
> More importantly however we should stop the watchdog on SYS_POWER_OFF
> I think.
>

Harald,

please have a look into existing watchdog drivers. Unless I am counting wrong,
there are 31 watchdog drivers using the above code, and only 3 watchdog drivers
(gpio, it8712, scx200) using SYS_POWER_OFF || SYS_HALT. I think it makes sense
to make a majority decision when moving code from drivers into the infrastructure.

Thanks,
Guenter

