Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35974 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175Ab3CZIzB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Mar 2013 04:55:01 -0400
Date: Tue, 26 Mar 2013 09:54:54 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86: Add basic support for the Congatec CGEB BIOS
 interface
Message-ID: <20130326085454.GK1906@pengutronix.de>
References: <1360663374-30951-1-git-send-email-s.hauer@pengutronix.de>
 <1360663374-30951-2-git-send-email-s.hauer@pengutronix.de>
 <CAH9NwWdOCo642KqUXk1y5hbwdtW5RYgQnQfZFUEe4FOJzSiByQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWdOCo642KqUXk1y5hbwdtW5RYgQnQfZFUEe4FOJzSiByQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 25, 2013 at 09:31:35AM +0100, Christian Gmeiner wrote:
> Hi Sascha
> 
> 
> > +struct cgeb_pdata {
> > +       struct cgeb_board_data          *board;
> > +       int unit;
> > +};
> > +
> > +#endif /* __CONGATEC_CGEB_H */
> > diff --git a/arch/x86/platform/Makefile b/arch/x86/platform/Makefile
> > index 8d87439..9de1789 100644
> > --- a/arch/x86/platform/Makefile
> > +++ b/arch/x86/platform/Makefile
> > @@ -1,5 +1,6 @@
> >  # Platform specific code goes here
> >  obj-y  += ce4100/
> > +obj-y  += congatec/
> >  obj-y  += efi/
> >  obj-y  += geode/
> >  obj-y  += iris/
> 
> 
> Fails to build

Ups, sorry. It seems I forgot to git add
arch/x86/platform/congatec/Makefile. It should look like this:

obj-$(CONFIG_CONGATEC_CGEB) += congatec-cgeb.o

I will include this next time.


Any other comments to this series? Is the base cgeb support ok to
include?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
