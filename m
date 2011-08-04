Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail209.messagelabs.com ([216.82.255.3]:31943 "EHLO
	mail209.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab1HDVzh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Aug 2011 17:55:37 -0400
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Mika Westerberg <mika.westerberg@iki.fi>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Date: Thu, 4 Aug 2011 16:54:56 -0500
Subject: RE: [RFC PATCH v2] watchdog: ep93xx: Use the WatchDog Timer Driver
 Core.
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3882B8D51@AUSP01VMBX24.collaborationhost.net>
References: <201108031021.26620.hartleys@visionengravers.com>
 <20110804181244.GA2445@mwesterb-mobl.ger.corp.intel.com>
In-Reply-To: <20110804181244.GA2445@mwesterb-mobl.ger.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thursday, August 04, 2011 11:13 AM, Mika Westerberg wrote:
> On Wed, Aug 03, 2011 at 10:21:26AM -0700, H Hartley Sweeten wrote:
>> Convert the ep93xx watchdog driver to using the WatchDog Timer Driver =
Core.
>>=20
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Tested-by: Mika Westerberg <mika.westerberg@iki.fi>
>
> BTW, now that the driver uses watchdog core should we also select
> WATCHDOG_CORE in the Kconfig? If it is not enabled we get:
>
> drivers/built-in.o: In function `ep93xx_wdt_init':
> clkdev.c:(.init.text+0x2bd8): undefined reference to
> `watchdog_register_device'
> make: *** [.tmp_vmlinux1] Error 1
>
> Other than that, you can also add my
>
> Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
>
> if you like.

Mika,

I just posted a v3 of this patch that includes the Kconfig change to
select WATCHDOG_CORE.  Can you please take a look and possibly test it?

After that I'll add your Tested-by and Reviewed-by tags.

Thanks,
Hartley--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
