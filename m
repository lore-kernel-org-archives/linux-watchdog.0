Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:57891 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752461AbbBCAIV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Feb 2015 19:08:21 -0500
Date: Tue, 3 Feb 2015 01:08:11 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Support Opensource <support.opensource@diasemi.com>,
	linux-watchdog@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: da9063: Add restart handler support
Message-ID: <20150203000810.GA18245@spo001.leaseweb.nl>
References: <1422541565-19792-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422541565-19792-1-git-send-email-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Geert,

> Register a restart handler for the da9063 watchdog.  System restart is
> triggered by sending the shutdown command to the PMIC.
> As more-suitable restart handlers may exist, the priority of the
> watchdog restart handler is set to 128.
> 
> The actual restart method was inspired by a platform-specific patch from
> the BSP by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Added to linux-watchdog-next.

Kind regards,
Wim.

