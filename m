Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33198 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbBWT0q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 14:26:46 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YPyeU-003ZFI-4Q
	for linux-watchdog@vger.kernel.org; Mon, 23 Feb 2015 19:26:46 +0000
Date: Mon, 23 Feb 2015 11:26:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: James Hogan <james.hogan@imgtec.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	James Hogan <james@albanarts.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: Re: [PATCH 1/2] watchdog: imgpdc: Fix probe NULL pointer dereference
Message-ID: <20150223192634.GA26070@roeck-us.net>
References: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
 <1424475945-30009-2-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424475945-30009-2-git-send-email-james.hogan@imgtec.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 20, 2015 at 11:45:44PM +0000, James Hogan wrote:
> The IMG PDC watchdog probe function calls pdc_wdt_stop() prior to
> watchdog_set_drvdata(), causing a NULL pointer dereference when
> pdc_wdt_stop() retrieves the struct pdc_wdt_dev pointer using
> watchdog_get_drvdata() and reads the register base address through it.
> 
> Fix by moving the watchdog_set_drvdata() call earlier, to where various
> other pdc_wdt->wdt_dev fields are initialised.
> 
> Fixes: 93937669e9b5 ("watchdog: ImgTec PDC Watchdog Timer Driver")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> Cc: Jude Abraham <Jude.Abraham@imgtec.com>
> Cc: linux-watchdog@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
