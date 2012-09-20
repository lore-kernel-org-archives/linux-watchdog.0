Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:47731 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751322Ab2ITK2C (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Sep 2012 06:28:02 -0400
Received: from mail404.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 1C4E110141D8
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Sep 2012 12:15:47 +0200 (CEST)
Date: Thu, 20 Sep 2012 12:07:24 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/2] ARM: at91: add at91sam9_wdt driver to
 at91sam9260
Message-ID: <20120920100724.GF17667@game.jcrosoft.org>
References: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
 <1348055861-7857-3-git-send-email-fabio.porcedda@gmail.com>
 <20120920052928.GE17667@game.jcrosoft.org>
 <CAHkwnC9jqUmb+AGCnxV9QeSv=5JjS4+AWnutkm6TZPJJRcxGAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkwnC9jqUmb+AGCnxV9QeSv=5JjS4+AWnutkm6TZPJJRcxGAA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09:52 Thu 20 Sep     , Fabio Porcedda wrote:
> Hi Jean-Christophe,
> 
> On Thu, Sep 20, 2012 at 7:29 AM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 13:57 Wed 19 Sep     , Fabio Porcedda wrote:
> >> Tested on an at91sam9260 board (evk-pro3)
> >>
> >> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> >> ---
> >>  arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> >> index 66389c1..680b1c8 100644
> >> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> >> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> >> @@ -233,6 +233,12 @@
> >>                                       trigger-external;
> >>                               };
> >>                       };
> >> +
> >> +                     watchdog@fffffd40 {
> > disable dy default
> 
> All the others watchdog drivers in arch/arm/boot/dts/* are enabled by default.
> IMHO the watchdog driver it's like the "rtstc" and "shdwc" driver,
> they are safe to be enabled by default.
> I'm missing something?
no the other watchdog will not reset if not managed

this one will

so I'm not confortable by enabling it by default

Best Regards,
J.
