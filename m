Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40036 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbbD0QGK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 12:06:10 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YmlXt-0048xX-Dq
	for linux-watchdog@vger.kernel.org; Mon, 27 Apr 2015 16:06:09 +0000
Date: Mon, 27 Apr 2015 09:05:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Anholt <eric@anholt.net>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to
 the WDT driver.
Message-ID: <20150427160517.GA11074@roeck-us.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
 <20150427160432.GD5701@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150427160432.GD5701@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 27, 2015 at 09:04:32AM -0700, Guenter Roeck wrote:
> On Fri, Apr 24, 2015 at 12:08:54PM -0700, Eric Anholt wrote:
> > Since the WDT is what's used to drive restart and power off, it makes
> > more sense to keep it there, where the regs are already mapped and
> > definitions for them provided.  Note that this means you may need to
> > add CONFIG_BCM2835_WDT to retain functionality of your kernel.
> > 
> > Signed-off-by: Eric Anholt <eric@anholt.net>
> > Cc: linux-watchdog@vger.kernel.org
> 
> The patch will require a rebase to v4.0-rc1.
> 
s/4.0/4.1/

Guenter
