Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33305 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbbBWT1d (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 14:27:33 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YPyfD-003ZSS-Hs
	for linux-watchdog@vger.kernel.org; Mon, 23 Feb 2015 19:27:32 +0000
Date: Mon, 23 Feb 2015 11:27:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: James Hogan <james.hogan@imgtec.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	James Hogan <james@albanarts.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: Re: [PATCH 2/2] watchdog: imgpdc: Fix default heartbeat
Message-ID: <20150223192722.GB26070@roeck-us.net>
References: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
 <1424475945-30009-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424475945-30009-3-git-send-email-james.hogan@imgtec.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 20, 2015 at 11:45:45PM +0000, James Hogan wrote:
> The IMG PDC watchdog driver heartbeat module parameter has no default so
> it is initialised to zero. This results in the following warning during
> probe:
> 
> imgpdc-wdt 2006000.wdt: Initial timeout out of range! setting max timeout
> 
> The module parameter description implies that the default value should
> be PDC_WDT_DEF_TIMEOUT, which isn't yet used, so initialise it to that.
> 
> Also tweak the heartbeat module parameter description for consistency.
> 
> Fixes: 93937669e9b5 ("watchdog: ImgTec PDC Watchdog Timer Driver")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> Cc: Jude Abraham <Jude.Abraham@imgtec.com>
> Cc: linux-watchdog@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
