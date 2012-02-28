Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44132 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab2B1OcU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Feb 2012 09:32:20 -0500
Date: Tue, 28 Feb 2012 14:32:17 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org,
	Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH 1/3] mfd: Add basic support for the Congatec CGEB BIOS
 interface
Message-ID: <20120228143217.GB25472@sirena.org.uk>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
 <1328102793-4313-2-git-send-email-s.hauer@pengutronix.de>
 <20120220163927.GY5387@sortiz-mobl>
 <20120220180752.GV3852@pengutronix.de>
 <20120227135827.GM27687@sortiz-mobl>
 <20120227172443.GD3852@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120227172443.GD3852@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 27, 2012 at 06:24:43PM +0100, Sascha Hauer wrote:
> On Mon, Feb 27, 2012 at 02:58:27PM +0100, Samuel Ortiz wrote:

> > Yes, this seems to be the trend apparently. Could you try pushing that into
> > the x86/platform, please ? If they put you under fire, I guess I could take
> > this patchset. But they have several "BIOS interfaces" there already...

> Ok, I'll put on my asbestos suit and give it a try.

You might want to jump into the thread Linus Walleij started about
system controllers today.
