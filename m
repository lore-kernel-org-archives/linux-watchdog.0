Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58673 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab1FRTSP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Jun 2011 15:18:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 9/10 v2] Generic Watchdog Timer Driver
Date: Sat, 18 Jun 2011 21:17:48 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20110618172727.GJ3441@infomag.iguana.be>
In-Reply-To: <20110618172727.GJ3441@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106182117.49026.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Saturday 18 June 2011 19:27:27 Wim Van Sebroeck wrote:
> 
> watchdog: WatchDog Timer Driver Core - Part 9
> 
> Add support for extra ioctl calls by adding a
> ioctl watchdog operation. This operation will be
> called before we do our own handling of ioctl
> commands. This way we can override the internal
> ioctl command handling and we can also add
> extra ioctl commands. The ioctl watchdog operation
> should return the appropriate error codes or
> -ENOIOCTLCMD if the ioctl command should be handled
> through the internal ioctl handling of the framework.
> 
> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Hmm, I'm not sure about this one. It does make the conversion
of existing drivers easier but doesn't encourage doing a good
job there.

How about instead providing a compatibility helper module that
provides helper functions like this:

int watchdog_compat_getstatus(struct watchdog_device *wdd)
{
	int __user *tmp = compat_alloc_userspace(sizeof (int));
	int ret;

	ret = wdd->ops->ioctl(wdd, WDIOC_GETSTATUS, tmp);
	if (ret)
		return ret;

	__get_user(ret, tmp);
	return ret;
}
EXPORT_SYMBOL_GPL(watchdog_compat_getstatus);

This would let you use the common ioctl implementation for all
watchdogs without the option of an individual driver overriding
it, but a driver could still provide an ioctl method that only
gets called by the watchdog_compat_* functions.

	Arnd
