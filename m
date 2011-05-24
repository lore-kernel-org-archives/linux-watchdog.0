Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:58388 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753942Ab1EXHR1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 May 2011 03:17:27 -0400
Date: Tue, 24 May 2011 09:17:24 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cleanup pc87413 watchdog driver to use
	request_muxed_region for SuperIO area
Message-ID: <20110524071724.GD17887@infomag.iguana.be>
References: <20110414190238.GI4835@earth.li> <20110430182512.GK4835@earth.li> <20110520122129.GT17887@infomag.iguana.be> <20110520162054.GI28362@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110520162054.GI28362@earth.li>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jonathan,

> > I don't think this is the correct way to do this. You do the
> > request_muxed_region only at init and exit of the module.
> 
> I do a single request_muxed_region in the init function, and release it
> at the end of the init function. It's only necessary to hold the LPC
> region while the WDT functionality is enabled and the base address for
> the SWC block is retrieved.
> 
> After that point all access is via the SWC region, so there's no need to
> call request_muxed_region. The call in the exit function releases the
> SWC block. We're not holding the LPC region for the entire duration of
> the driver being loaded.

Added to linux-2.6-watchdog-next.

Kind regards,
Wim.

