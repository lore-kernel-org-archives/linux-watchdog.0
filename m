Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.114]:11072 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753587Ab3J2Jm3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 05:42:29 -0400
Date: Tue, 29 Oct 2013 10:42:19 +0100
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	Rob Landley <rob@landley.net>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ian.campbell@citrix.com>,
	Guenter Roeck <linux@roeck-us.net>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH] documentation/devicetree: Move DT bindigns from gpio to
 watchdog
Message-ID: <20131029094219.GA25358@jtlinux>
References: <1377088929-23694-1-git-send-email-johannes.thumshirn@men.de>
 <20131029074153.GE19569@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20131029074153.GE19569@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 29, 2013 at 08:41:53AM +0100, Wim Van Sebroeck wrote:
> Hi Johannes,
>
> > I accidently put the devicetree bindings for the MEN A21 watchdog driver in
> > Documentation/devicetree/bindings/gpio instead of
> > Documentation/devicetree/bindings/watchdog, this patch addresses this error.
> >
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Ian Campbell <ian.campbell@citrix.com>
> > Cc: Rob Landley <rob@landley.net>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  .../bindings/{gpio => watchdog}/men-a021-wdt.txt   |    0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename Documentation/devicetree/bindings/{gpio => watchdog}/men-a021-wdt.txt (100%)
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/men-a021-wdt.txt b/Documentation/devicetree/bindings/watchdog/men-a021-wdt.txt
> > similarity index 100%
> > rename from Documentation/devicetree/bindings/gpio/men-a021-wdt.txt
> > rename to Documentation/devicetree/bindings/watchdog/men-a021-wdt.txt
>
> This patch has been added to linux-watchdog-next.
>
> Kind regards,
> Wim.
>

Thanks Wim

       Johannes
