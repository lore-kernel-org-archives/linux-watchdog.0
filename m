Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37522 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbaIUQdS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 21 Sep 2014 12:33:18 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XVk4c-001tpo-78
	for linux-watchdog@vger.kernel.org; Sun, 21 Sep 2014 16:33:18 +0000
Message-ID: <541EFDB5.5040503@roeck-us.net>
Date: Sun, 21 Sep 2014 09:32:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Chen-Yu Tsai <wens@csie.org>, Wim Van Sebroeck <wim@iguana.be>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] watchdog: sunxi: Add A31 watchdog support
References: <1411315519-26257-1-git-send-email-wens@csie.org> <1411315519-26257-3-git-send-email-wens@csie.org>
In-Reply-To: <1411315519-26257-3-git-send-email-wens@csie.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/21/2014 09:05 AM, Chen-Yu Tsai wrote:
> This patch adds support for the watchdog hardware found in A31 and
> newer SoCs. This new hardware has registers at different offsets, and
> the system reset control has been split out of the "mode" register
> into a new "configuration" register.
>
> Differences not supported by this driver include separate interrupt
> lines for each watchdog, instead of sharing an interrupt line and
> registers with the timer block.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


