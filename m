Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:34845 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751017Ab1FLREi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 12 Jun 2011 13:04:38 -0400
Date: Sun, 12 Jun 2011 10:04:19 -0700
From: Greg KH <greg@kroah.com>
To: Florian Fainelli <florian@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>, stable@kernel.org
Subject: Re: [stable] [PATCH 3/5 v2] WATCHDOG: mtx1-wdt: fix GPIO toggling
Message-ID: <20110612170419.GA20289@kroah.com>
References: <201106121856.28934.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106121856.28934.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Jun 12, 2011 at 06:56:28PM +0200, Florian Fainelli wrote:
> Commit e391be76 (MIPS: Alchemy: Clean up GPIO registers and accessors)
> changed the way the GPIO was toggled. Prior to this patch, we would
> always actively drive the GPIO output to either 0 or 1, this patch
> drove the GPIO active to 0, and put the GPIO in tristate to drive it
> to 1, unfortunately this does not work, revert back to active driving.
> 
> Using a signed variable (gstate) to hold the gpio state and using a bit-
> wise operation on it also resulted in toggling value from 1 to -2 since
> the variable is signed. This value was then passed on to gpio_direction_
> output, which always perform a if (value) ... to set the value to the
> gpio, so we were always writing a 1 to this GPIO instead of 1 -> 0 -> 1 ...
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Changes since v1:
> - use gpio_set_value() instead of gpio_direction_output(.., value)
> 
> Stable: [2.6.39+]
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
