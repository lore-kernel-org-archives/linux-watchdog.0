Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:47273
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755636Ab2HFXgY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Aug 2012 19:36:24 -0400
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
CC: "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"galak@kernel.crashing.org" <galak@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 1/1] booke/wdt: fix incorrect WDIOC_GETSUPPORT return
 path
Date: Mon, 6 Aug 2012 23:36:20 +0000
Message-ID: <CAOZdJXWYyc_=iikFwSLy4gX7Grag=jxvWhYrP4Y9U3QZcwieBw@mail.gmail.com>
References: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
	<CAOZdJXWftkUSw57-Qbe9JFP9NwodkHprKr6_1xi6ZzzLN8A4wA@mail.gmail.com>
In-Reply-To: <CAOZdJXWftkUSw57-Qbe9JFP9NwodkHprKr6_1xi6ZzzLN8A4wA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=US-ASCII
Content-ID: <9B1A30991CA01C4688104B34177AD9CF@mgd.freescale.com>
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 6, 2012 at 2:12 PM, Tabi Timur-B04825 <b04825@freescale.com> wrote:
> On Mon, Jul 30, 2012 at 3:15 AM, Tiejun Chen <tiejun.chen@windriver.com> wrote:
>> We miss that correct WDIOC_GETSUPPORT return path when perform
>> copy_to_user() properly.
>
> Thanks for catching this.  I'm amazed that this driver still has bugs like this.

While you're at it, I found a few related bugs.  Can you fix these, also?

1.	case WDIOC_SETOPTIONS:
		if (get_user(tmp, p))
			return -EINVAL;

This should return -EFAULT.

2. 	case WDIOC_GETBOOTSTATUS:
		/* XXX: something is clearing TSR */
		tmp = mfspr(SPRN_TSR) & TSR_WRS(3);
		/* returns CARDRESET if last reset was caused by the WDT */
		return (tmp ? WDIOF_CARDRESET : 0);

This should use put_user() to return the value, instead of returning
it as a return code.

You can title the new patch something like, "booke/wdt: some ioctls do
not return values properly"

-- 
Timur Tabi
Linux kernel developer at Freescale
