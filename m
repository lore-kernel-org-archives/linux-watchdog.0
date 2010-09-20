Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46732 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756483Ab0ITPwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Sep 2010 11:52:08 -0400
Received: by vws3 with SMTP id 3so3394620vws.19
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 08:52:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
 <1284764008-19469-2-git-send-email-timur@freescale.com> <AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com>
From: Timur Tabi <timur@freescale.com>
Date: Mon, 20 Sep 2010 10:51:37 -0500
Message-ID: <AANLkTimp-0zdw-fAaX8qCwHW0NMn--6RK0_USDGOSe47@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/watchdog: allow the e500 watchdog driver to
 be compiled as a module
To: Josh Boyer <jwboyer@gmail.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 17, 2010 at 7:37 PM, Josh Boyer <jwboyer@gmail.com> wrote:
>>  config BOOKE_WDT
>> -       bool "PowerPC Book-E Watchdog Timer"
>> +       tristate "PowerPC Book-E Watchdog Timer"
>>        depends on BOOKE || 4xx
>>        ---help---
>> +         Watchdog driver for PowerPC e500 chips, such as the Freescale
>> +         MPC85xx SOCs.
>> +
>
> Again, used for more than e500.  That || 4xx in the depends statement
> right above your addition isn't there for fun :).

Does this mean that this comment which is already in the driver is
wrong?  It alludes that "Book-E" is synonymous with "e500".

/* If the kernel parameter wdt=1, the watchdog will be enabled at boot.
 * Also, the wdt_period sets the watchdog timer period timeout.
 * For E500 cpus the wdt_period sets which bit changing from 0->1 will
 * trigger a watchog timeout. This watchdog timeout will occur 3 times, the
 * first time nothing will happen, the second time a watchdog exception will
 * occur, and the final time the board will reset.
 */

#ifdef	CONFIG_FSL_BOOKE
#define WDT_PERIOD_DEFAULT 38	/* Ex. wdt_period=28 bus=333Mhz,reset=~40sec */
#else
#define WDT_PERIOD_DEFAULT 3	/* Refer to the PPC40x and PPC4xx manuals */
#endif				/* for timing information */

-- 
Timur Tabi
Linux kernel developer at Freescale
