Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39817 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdCAAHS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 19:07:18 -0500
Date: Tue, 28 Feb 2017 15:24:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] mfd: db8500-prcmu: fix stub helper interface
Message-ID: <20170228232459.GA10512@roeck-us.net>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-3-arnd@arndb.de>
 <20170228214203.GE6651@roeck-us.net>
 <CAK8P3a3iu-2MAdD+-nRQfeOme--LLSAH1LRkREVGRo78m_ra7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3iu-2MAdD+-nRQfeOme--LLSAH1LRkREVGRo78m_ra7Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:47:02PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 28, 2017 at 10:42 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Tue, Feb 28, 2017 at 10:01:17PM +0100, Arnd Bergmann wrote:
> >> When the db8500 watchdog is enabled without the PRCMU, we get a lot of
> >> warnings about duplicate or missing helper functions:
> >>
> >> In file included from drivers/watchdog/ux500_wdt.c:21:0:
> >> include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prcmu_abb_read'
> >>  static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
> >>
> >> This removes the duplicate function definitions and moves the helpers in
> >> dbx500-prcmu outside of the #ifdef that hides them.
> >>
> >
> > Is that appropriate ? Maybe we should just disable COMPILE_TEST
> > for this driver instead.
> 
> Or we could do both. The MFD driver was written to support this in principle,
> it just hasn't worked in a long time.
> 

Can you send me patches to disable COMPILE_TEST for this driver and for retu ?

Thanks,
Guenter
