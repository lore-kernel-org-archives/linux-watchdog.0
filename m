Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41653 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbbGaRSr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 Jul 2015 13:18:47 -0400
Date: Fri, 31 Jul 2015 10:18:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: gpio-wdt: ping already at startup for always
 running devices
Message-ID: <20150731171844.GA6277@roeck-us.net>
References: <1438327296-17904-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438327296-17904-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jul 31, 2015 at 09:21:36AM +0200, Uwe Kleine-König wrote:
> During probe for an always-running watchdog a timer is setup to
> constantly ping the watchdog while the device is not open. The gpio to
> ping the watchdog is setup to inactive.
> 
> For a watchdog with hw_algo = "toggle" this results in a ping depending
> on the initial state of the gpio, for hw_algo = "level" no ping is
> generated.
> 
> Make sure that the first automatic ping is sent immediately and not only
> when the timer expires the first time. This makes the machine survive in
> case more than half of the watchdog timeout is already elapsed. (Which
> is very probable for the chip I'm faced with that has a timeout of one
> second.)
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Makes sense.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
