Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42116 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab3JaAs5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 20:48:57 -0400
Date: Thu, 31 Oct 2013 00:48:15 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: add module device table
Message-ID: <20131031004815.GT16735@n2100.arm.linux.org.uk>
References: <E1VbfdE-0003gA-4q@rmk-PC.arm.linux.org.uk> <20131031004338.GA20335@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131031004338.GA20335@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 30, 2013 at 05:43:38PM -0700, Guenter Roeck wrote:
> On Wed, Oct 30, 2013 at 11:57:00PM +0000, Russell King wrote:
> > Add the module device table declaration so the module can be loaded
> > automatically at boot time.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Hi Russell,
> 
> Wim should have this patch in his queue already, as 'watchdog: imx2_wdt:
> expose module alias for loading from device-tree', submitted by Niels
> de Vos back in July.

Any reason it hasn't made it in yet?  We had a merge window back in
September where, if we're not happy to apply it as a fix during -rc,
it could have gone in.  I see watchdog stuff did merge during the
last merge window...
