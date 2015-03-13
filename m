Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48593 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751295AbbCMKow (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 06:44:52 -0400
Date: Fri, 13 Mar 2015 11:44:50 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 09/10] clocksource: atmel-st: remove mach/hardware
 dependency
Message-ID: <20150313104450.GH4329@piout.net>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426162054-9987-10-git-send-email-alexandre.belloni@free-electrons.com>
 <5502BA2F.4040600@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5502BA2F.4040600@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 13/03/2015 at 11:21:35 +0100, Daniel Lezcano wrote :
> On 03/12/2015 01:07 PM, Alexandre Belloni wrote:
> >Remove the mach/hardware dependency to prepare the driver for multiplatform
> >support.
> >Also switch from setup_irq() to request_irq()
> >
> >Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >---
> >  drivers/clocksource/timer-atmel-st.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> >
> >diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
> >index 674ef2519d6b..91d6cbb7a56b 100644
> >--- a/drivers/clocksource/timer-atmel-st.c
> >+++ b/drivers/clocksource/timer-atmel-st.c
> >@@ -31,13 +31,12 @@
> >
> >  #include <asm/mach/time.h>
> 
> Couldn't the header above be removed ?
> 

Indeed, it can but that is starting to be further cleanup than I
intended ;)

I'll send a v6 of that patch for Nicolas to pick.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
