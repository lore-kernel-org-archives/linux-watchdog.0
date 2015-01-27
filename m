Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34571 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbbA0Uys (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Jan 2015 15:54:48 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YGD9s-001aSc-CL
	for linux-watchdog@vger.kernel.org; Tue, 27 Jan 2015 20:54:48 +0000
Date: Tue, 27 Jan 2015 12:54:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	wim@iguana.be, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	paul@crapouillou.net
Subject: Re: [PATCH 2/2] watchdog: jz4740: Add DT support
Message-ID: <20150127205430.GB6983@roeck-us.net>
References: <1422371490-44402-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1422371490-44402-3-git-send-email-Zubair.Kakakhel@imgtec.com>
 <2690526.hgsE0j4AZc@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2690526.hgsE0j4AZc@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 27, 2015 at 09:15:37PM +0100, Arnd Bergmann wrote:
> On Tuesday 27 January 2015 15:11:30 Zubair Lutfullah Kakakhel wrote:
> >  };
> >  
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id jz4740_of_matches[] = {
> > +       { .compatible = "ingenic,jz4740-watchdog", },
> > +       { /* sentinel */ }
> > +};
> > +#endif
> > +
> >  static int jz4740_wdt_probe(struct platform_device *pdev)
> >  {
> >         struct jz4740_wdt_drvdata *drvdata;
> > @@ -211,6 +219,7 @@ static struct platform_driver jz4740_wdt_driver = {
> >         .remove = jz4740_wdt_remove,
> >         .driver = {
> >                 .name = "jz4740-wdt",
> > +               .of_match_table = of_match_ptr(jz4740_of_matches),
> >         },
> > 
> 
> Why the #ifdef? Presumably we want to move over jz4740 to DT-only in the
> long run, so you could just remove the #ifdef and the of_match_ptr()
> wrapper.
> 
Only if "depends on OF" is added to its Kconfig entry, or am I missing
something ?

Guenter
