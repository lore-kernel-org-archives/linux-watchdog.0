Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:38408 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab0ITTa3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Sep 2010 15:30:29 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8KJJxXu013473
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 13:19:59 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8KJUNdu110204
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 13:30:23 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8KJULek025837
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 13:30:22 -0600
Date: Mon, 20 Sep 2010 15:30:16 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Cc: Josh Boyer <jwboyer@gmail.com>, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/watchdog: allow the e500 watchdog driver to
 be compiled as a module
Message-ID: <20100920193016.GA3845@zod.rchland.ibm.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
 <1284764008-19469-2-git-send-email-timur@freescale.com>
 <AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com>
 <AANLkTimp-0zdw-fAaX8qCwHW0NMn--6RK0_USDGOSe47@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTimp-0zdw-fAaX8qCwHW0NMn--6RK0_USDGOSe47@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 20, 2010 at 10:51:37AM -0500, Timur Tabi wrote:
>On Fri, Sep 17, 2010 at 7:37 PM, Josh Boyer <jwboyer@gmail.com> wrote:
>>>  config BOOKE_WDT
>>> -       bool "PowerPC Book-E Watchdog Timer"
>>> +       tristate "PowerPC Book-E Watchdog Timer"
>>>        depends on BOOKE || 4xx
>>>        ---help---
>>> +         Watchdog driver for PowerPC e500 chips, such as the Freescale
>>> +         MPC85xx SOCs.
>>> +
>>
>> Again, used for more than e500.  That || 4xx in the depends statement
>> right above your addition isn't there for fun :).
>
>Does this mean that this comment which is already in the driver is
>wrong?  It alludes that "Book-E" is synonymous with "e500".
>
>/* If the kernel parameter wdt=1, the watchdog will be enabled at boot.
> * Also, the wdt_period sets the watchdog timer period timeout.
> * For E500 cpus the wdt_period sets which bit changing from 0->1 will
> * trigger a watchog timeout. This watchdog timeout will occur 3 times, the
> * first time nothing will happen, the second time a watchdog exception will
> * occur, and the final time the board will reset.
> */

I guess I don't see what you mean.  It talks about e500 but it doesn't
say "Book-E" anywhere in that comment.  (Though I'm pretty sure that
comment does apply to 4xx.)

>
>#ifdef	CONFIG_FSL_BOOKE
>#define WDT_PERIOD_DEFAULT 38	/* Ex. wdt_period=28 bus=333Mhz,reset=~40sec */
>#else
>#define WDT_PERIOD_DEFAULT 3	/* Refer to the PPC40x and PPC4xx manuals */
>#endif				/* for timing information */

And this bit is marked as "FSL_BOOKE" vs. 40x and 44x.

josh
