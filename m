Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53584 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab1FRTBe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Jun 2011 15:01:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 2/10 v2] Generic Watchdog Timer Driver
Date: Sat, 18 Jun 2011 21:01:15 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20110618172043.GC3441@infomag.iguana.be>
In-Reply-To: <20110618172043.GC3441@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106182101.15523.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Saturday 18 June 2011 19:20:43 Wim Van Sebroeck wrote:

> +/*
>   *	watchdog_open: open the /dev/watchdog device.
>   *	@inode: inode of device
>   *	@file: file handle to device
> @@ -202,6 +237,7 @@
>  	.owner		= THIS_MODULE,
>  	.llseek		= no_llseek,
>  	.write		= watchdog_write,
> +	.unlocked_ioctl	= watchdog_ioctl,
>  	.open		= watchdog_open,
>  	.release	= watchdog_release,
>  };

All the ioctl commands are compatible with their 32 bit counterparts, so
you can just set ".compat_ioctl = watchdog_ioctl" here to slightly speed
up the ioctl operation for compat tasks.

Looks good otherwise.

	Arnd
