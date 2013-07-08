Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.106]:10837 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753661Ab3GHGyQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 8 Jul 2013 02:54:16 -0400
Date: Mon, 8 Jul 2013 08:59:02 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<guenter@roeck-us.net>
Subject: Re: [PATCH RESEND v10 1/2] watchdog: New watchdog driver for MEN A21
 watchdogs
Message-ID: <20130708065902.GA22574@jtlinux>
References: <20130617140019.GA23794@roeck-us.net>
 <20130618151939.GA23296@jtlinux>
 <20130705210119.GA10354@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20130705210119.GA10354@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jul 05, 2013 at 11:01:19PM +0200, Wim Van Sebroeck wrote:
> Hi Johannes,
>
> > This patch adds the driver for the watchdog devices found on MEN Mikro
> > Elektronik A21 VMEbus CPU Carrier Boards. It has DT-support and uses the
> > watchdog framework.
> >
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> I added this patch to linux-watchdog-next.
> I am still thinking about wether or not we shouldn't add a timer to this
> watchdog device driver. But that's something we can change later on.

Probably yes, but that really would be some work for watchdog core imho.

Anyway, tanks for adding the patch.

Thanks,
Johannes

>
> Kind regards,
> Wim.
>
