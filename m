Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33328 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754545Ab2E2Rws (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 May 2012 13:52:48 -0400
Date: Tue, 29 May 2012 19:24:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] [PATCH] hwmon/sch56xx: Depend on watchdog for watchdog core functions
Message-ID: <20120529172439.GY3074@spo001.leaseweb.com>
References: <1337890738-26533-1-git-send-email-hdegoede@redhat.com> <20120524205426.GW3074@spo001.leaseweb.com> <1338307894.478.68.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1338307894.478.68.camel@groeck-laptop>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> > > Since the watchdog code in sch56xx-common now uses the watchdog core, the
> > > Kconfig entires for the sch5627 and sch5636 should depend on WATCHDOG
> > > being set.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > I added also the "select WATCHDOG_CORE" lines for both drivers.
> > In linux-watchdog-next now.
> > 
> Hi Wim,
> 
> looks like Hans' patches are all in your tree, so I assume I don't have
> to take anything through my hwmon tree. Please let me know if I got that
> wrong.

All is in my tree indeed. So you don't need to do anything on your side.

Kind regards,
Wim.

