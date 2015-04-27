Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39997 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbbD0QF1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 12:05:27 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YmlXD-0048di-0R
	for linux-watchdog@vger.kernel.org; Mon, 27 Apr 2015 16:05:27 +0000
Date: Mon, 27 Apr 2015 09:04:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Anholt <eric@anholt.net>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to
 the WDT driver.
Message-ID: <20150427160432.GD5701@roeck-us.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Apr 24, 2015 at 12:08:54PM -0700, Eric Anholt wrote:
> Since the WDT is what's used to drive restart and power off, it makes
> more sense to keep it there, where the regs are already mapped and
> definitions for them provided.  Note that this means you may need to
> add CONFIG_BCM2835_WDT to retain functionality of your kernel.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: linux-watchdog@vger.kernel.org

The patch will require a rebase to v4.0-rc1.

Thanks,
Guenter
