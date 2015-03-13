Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48552 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752280AbbCMKke (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 06:40:34 -0400
Date: Fri, 13 Mar 2015 11:40:32 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 02/10] mfd: syscon: Add atmel system timer registers
 definition
Message-ID: <20150313104032.GG4329@piout.net>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426162054-9987-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20150313080315.GC3383@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150313080315.GC3383@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 13/03/2015 at 08:03:15 +0000, Lee Jones wrote :
> On Thu, 12 Mar 2015, Alexandre Belloni wrote:
> 
> > AT91RM920 has a memory range reserved for timer and watchdog configuration.
> > Expose those registers so that drivers can make use of the system timer syscon
> > declared in at91 DTs.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  include/linux/mfd/syscon/atmel-st.h | 49 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 include/linux/mfd/syscon/atmel-st.h
> 
> Applied, thanks.
> 

Actually, I was thinking this could go through the at91 to avoid
depending on your branch.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
