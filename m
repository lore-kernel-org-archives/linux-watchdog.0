Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37474 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbaIUQc6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 21 Sep 2014 12:32:58 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XVk4I-001tKv-8K
	for linux-watchdog@vger.kernel.org; Sun, 21 Sep 2014 16:32:58 +0000
Message-ID: <541EFD9A.2000406@roeck-us.net>
Date: Sun, 21 Sep 2014 09:32:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Chen-Yu Tsai <wens@csie.org>, Wim Van Sebroeck <wim@iguana.be>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] watchdog: sunxi: support parameterized compatible
 strings
References: <1411315519-26257-1-git-send-email-wens@csie.org> <1411315519-26257-2-git-send-email-wens@csie.org>
In-Reply-To: <1411315519-26257-2-git-send-email-wens@csie.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/21/2014 09:05 AM, Chen-Yu Tsai wrote:
> This patch adds support for hardware parameters tied to compatible
> strings, so similar hardware can reuse the driver.
>
> This will be used to support the newer watchdog found in A31 and
> later SoCs. Differences in the new hardware include separate
> interrupt lines for each watchdog, and corresponding interrupt
> control/status registers. Watchdog control registers were also
> slightly rearranged.
>
> Also replace ioread32()/iowrite32() with readl()/writel() in various
> places changed.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

