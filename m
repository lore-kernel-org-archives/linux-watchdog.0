Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:65496 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762AbbA0VYM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Jan 2015 16:24:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	wim@iguana.be, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	paul@crapouillou.net
Subject: Re: [PATCH 2/2] watchdog: jz4740: Add DT support
Date: Tue, 27 Jan 2015 22:23:49 +0100
Message-ID: <3983977.h1XXMbpmZb@wuerfel>
In-Reply-To: <20150127205430.GB6983@roeck-us.net>
References: <1422371490-44402-1-git-send-email-Zubair.Kakakhel@imgtec.com> <2690526.hgsE0j4AZc@wuerfel> <20150127205430.GB6983@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 27 January 2015 12:54:30 Guenter Roeck wrote:
> On Tue, Jan 27, 2015 at 09:15:37PM +0100, Arnd Bergmann wrote:
> > On Tuesday 27 January 2015 15:11:30 Zubair Lutfullah Kakakhel wrote:
> > >  };
> > >  
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id jz4740_of_matches[] = {
> > > +       { .compatible = "ingenic,jz4740-watchdog", },
> > > +       { /* sentinel */ }
> > > +};
> > > +#endif
> > > +
> > >  static int jz4740_wdt_probe(struct platform_device *pdev)
> > >  {
> > >         struct jz4740_wdt_drvdata *drvdata;
> > > @@ -211,6 +219,7 @@ static struct platform_driver jz4740_wdt_driver = {
> > >         .remove = jz4740_wdt_remove,
> > >         .driver = {
> > >                 .name = "jz4740-wdt",
> > > +               .of_match_table = of_match_ptr(jz4740_of_matches),
> > >         },
> > > 
> > 
> > Why the #ifdef? Presumably we want to move over jz4740 to DT-only in the
> > long run, so you could just remove the #ifdef and the of_match_ptr()
> > wrapper.
> > 
> Only if "depends on OF" is added to its Kconfig entry, or am I missing
> something ?
> 

I'm pretty sure you don't need that, it will still compile and link
fine, the only downside being a few wasted bytes to store the compatible
string and the array.

	Arnd
