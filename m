Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail160.messagelabs.com ([216.82.253.99]:7795 "EHLO
	mail160.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063Ab1HCQXV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Aug 2011 12:23:21 -0400
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>
Date: Wed, 3 Aug 2011 11:22:57 -0500
Subject: RE: [RFC PATCH] watchdog: ep93xx: Use the WatchDog Timer Driver
 Core.
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3882B8876@AUSP01VMBX24.collaborationhost.net>
References: <201108011357.24745.hartleys@visionengravers.com>
 <20110802091640.GF13218@intel.com>
 <ADE657CA350FB648AAC2C43247A983F001F3882B8535@AUSP01VMBX24.collaborationhost.net>
 <20110803081559.GI13218@intel.com>
In-Reply-To: <20110803081559.GI13218@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wednesday, August 03, 2011 1:16 AM, Mika Westerberg wrote:
> On Tue, Aug 02, 2011 at 11:55:36AM -0500, H Hartley Sweeten wrote:
>>>> -static const struct watchdog_info ident =3D {
>>>> -	.options =3D WDIOF_CARDRESET | WDIOF_MAGICCLOSE,
>>>> -	.identity =3D "EP93xx Watchdog",
>>>> +static const struct watchdog_info ep93xx_wdt_ident =3D {
>>>> +	.options	=3D WDIOF_CARDRESET | WDIOF_MAGICCLOSE,
>>>> +	.identity	=3D "EP93xx Watchdog",
>>>>  };
>
> One more thing I noticed: you should add WDIOF_KEEPALIVEPING to the opt=
ions
> field. Otherwise it doesn't support ioctl(..., WDIOC_KEEPALIVE) which w=
as
> supported in the original driver.

I noticed that yesterday.  I'll fix it and repost the patch shortly.

Thanks,
Hartley--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
