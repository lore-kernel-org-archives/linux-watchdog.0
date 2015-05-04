Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50358 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbbEDT0p (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 May 2015 15:26:45 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YpM0r-003Che-2r
	for linux-watchdog@vger.kernel.org; Mon, 04 May 2015 19:26:45 +0000
Date: Mon, 4 May 2015 12:26:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Weinberger <richard@nod.at>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: cadence: Add dependency on HAS_IOMEM
Message-ID: <20150504192638.GA6460@roeck-us.net>
References: <1430766085-500-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430766085-500-1-git-send-email-richard@nod.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 04, 2015 at 09:01:25PM +0200, Richard Weinberger wrote:
> Not all architectures have io memory.
> 
> Fixes:
> drivers/built-in.o: In function `cdns_wdt_probe':
> cadence_wdt.c:(.text+0x33b7c9): undefined reference to `devm_ioremap_resource'
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
