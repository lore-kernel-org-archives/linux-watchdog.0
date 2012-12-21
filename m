Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39653 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750729Ab2LULce (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Dec 2012 06:32:34 -0500
Date: Fri, 21 Dec 2012 12:32:29 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH v6 0/7] watchdog: dt: add support for the timeout-sec dt property
Message-ID: <20121221113229.GE13147@spo001.leaseweb.com>
References: <1353588716-28917-1-git-send-email-fabio.porcedda@gmail.com> <CAHkwnC-kOM2dzv9QmxbTgAYg5e2Ni39ixQR73cHt_5krMqwPbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkwnC-kOM2dzv9QmxbTgAYg5e2Ni39ixQR73cHt_5krMqwPbA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabio,

> > Hi all,
> > this patchset add the timeout-sec property to the watchdog core,
> > to the at91sam9_wdt driver and on all framework enabled watchdog driver
> > with dt support.
> > The at91sam9_wdt is tested on evk-pr3,
> > the other drivers are compile tested only.
> >
> > This patchset depends on the patchset already sent:
> > "[PATCH v9 0/3 RESEND] watchdog: at91sam9_wdt: add device tree support"
> > that is already pulled in arm-soc/for-next branch.
> 
> Ping.
> 
> The dependency is already merged.

Will not be for this merge window. Will review next week.

Kind regards,
Wim.

