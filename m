Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:47223 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751077AbbETFhj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 20 May 2015 01:37:39 -0400
Message-ID: <555C1D9F.4060600@offcode.fi>
Date: Wed, 20 May 2015 08:37:35 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
CC: Wenyou.Yang@atmel.com
Subject: Re: [PATCHv8 01/10] watchdog: Rename watchdog_active to watchdog_hw_active
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi> <1432023969-20736-2-git-send-email-timo.kokkonen@offcode.fi> <555BDF22.2090208@roeck-us.net>
In-Reply-To: <555BDF22.2090208@roeck-us.net>
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 20.05.2015 04:10, Guenter Roeck wrote:
> On 05/19/2015 01:26 AM, Timo Kokkonen wrote:
>> Before extending the watchdog core midlayer, it is useful to rename
>> the watchdog_active function so that it states explicitly what it
>> really does. That is, "active" watchdog means really that the watchd=
og
>> hardware is running and needs pinging to prevent a watchdog reset
>> taking place in near future.
>>
>> This is different to "watchdog open" state, which simply states that
>> kernel is expecting the user space to keep the watchdog alive. These
>> states might become different mainly because some hardware have
>> limitations that prevent them from being stopped at will.
>>
>
> I don't see why this is needed. If you need another state, per your
> description, it would be "open" in addition to "active".

Yes, the watchdog_is_open() is introduced on patch number two. The=20
original watchdog_is_active() is really confusing. It doesn't really=20
state what it means. Most of the drivers are using it to test whether=20
the watchdog HW is active when going to suspend, but at least atmel=20
watchdog was testing it to see whether the watchdog device is open from=
=20
user space. The HW itself is always active in that driver.

If we are about to distinguish between "device open from user space" an=
d=20
"hardware timer running", we better be clear about the naming.=20
"watchdog_is_active" doesn't really tell what it does.

This was originally suggested by Uwe Kleine-K=F6nig. He also recommende=
d=20
changing the timeout parameter so that is would state more clearly that=
=20
it is the SW timeout and not HW timeout. But I felt that it would have=20
been too invasive to change the timeout parameter as well. The=20
watchdog_is_active was not used very much so the change was easy.

-Timo
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
