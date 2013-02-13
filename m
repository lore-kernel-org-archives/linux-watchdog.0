Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:34789 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758641Ab3BMJoF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 04:44:05 -0500
Date: Wed, 13 Feb 2013 10:44:01 +0100
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
Subject: Re: [PATCH v7 1/6] watchdog: core: dt: add support for the timeout-sec dt property
Message-ID: <20130213094401.GB7867@spo001.leaseweb.com>
References: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com> <1357639455-21935-2-git-send-email-fabio.porcedda@gmail.com> <20130212230303.GA7867@spo001.leaseweb.com> <CAHkwnC_XdgHSo8Vkz5Ae=DQ48BBhLPVx_hXTzLTcw+xZJaEi5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkwnC_XdgHSo8Vkz5Ae=DQ48BBhLPVx_hXTzLTcw+xZJaEi5A@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabio,

> > I must admit that the different iterations of this patch only made it better.
> > I like the idea that you are proposing here (put the default timeout in the
> > watchdog_device struct and use a helper function to set the timeout parameter
> > value or the timeout-sec dt value). To be able to use other mechanism in the
> > future also, I think it make more sense to pass the device instead of the
> > device_node.
> 
> If i understand correctly you want to use "struct platform_device"
> instead of "struct device_node",
> in the function watchdog_init_timeout?

No struct device instead of struct device_node.

> > I also detailed your documentation a bit more and incorporated above changes
> > in an adjusted patch. Can you have a look at it and if OK for you I will put
> > it in linux-watchdog-next as your v10 :-).
> 
> That's good for sure :)

Will add it to the linux-watchdog-next tree today.

Kind regards,
Wim.

