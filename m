Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:42750 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755229Ab2FZS73 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jun 2012 14:59:29 -0400
Date: Tue, 26 Jun 2012 20:59:28 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] watchdog: coh901327_wdt: use clk_prepare/unprepare
Message-ID: <20120626185928.GG735@spo001.leaseweb.com>
References: <1339521541-30183-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1339521541-30183-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Make sure we prepare/unprepare the COH901327 watchdog timer
> as is required by the clk API especially if you use common
> clock.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Added to linux-watchdog-next.

Kind regards,
Wim.

