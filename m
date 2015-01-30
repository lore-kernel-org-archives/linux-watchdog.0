Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:58761 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945AbbA3P2I (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Jan 2015 10:28:08 -0500
Date: Fri, 30 Jan 2015 10:28:07 -0500 (EST)
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	kernel@savoirfairelinux.com, linux-watchdog@vger.kernel.org
Message-ID: <1529155290.150136.1422631687228.JavaMail.root@mail>
In-Reply-To: <54CB9994.1020503@roeck-us.net>
Subject: Re: [PATCH 2/4] watchdog: max63xx: cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> > -#define MAX6369_WDSET	(7 << 0)
> > -#define MAX6369_WDI	(1 << 3)
> 
> Not really sure I understand why you remove those constants.
> that is personal preference, not cleanup. Someone else might
> submit another cleanup later on and re-introduce them.

Indeed, I should have explained this. My primary intention with this patchset
is to bring GPIO support to this driver. MAX6369_WDSET, which is a mask, is
specific to the memory mapped support. I first intented to rename it to
MAX6369_MMAP_WDSET to explicitly mention the connection, but I ended up
thinking that a clear comment in the related functions would be much clearer
that a generic named macro.

These masks are explained below in this patch:

In max63xx_mmap_ping():
+       /* WDI is the 4th bit of the memory mapped byte */
+       __raw_writeb(val | BIT(3), data->base);
+       __raw_writeb(val & ~BIT(3), data->base);

and max63xx_mmap_set():
+       /* SET0, SET1, SET2 are the 3 lower bits of the memory mapped byte */
+       val = __raw_readb(data->base);
+       val &= ~7;
+       val |= set & 7;
+       __raw_writeb(val, data->base);

Also, if it is possible for a platform to map these bits in a different way,
some platform settings would have to be added and thus these macros won't be
relevant.

Thanks,
-v
