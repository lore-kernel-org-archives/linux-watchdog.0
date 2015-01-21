Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39707 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbbAUXgL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Jan 2015 18:36:11 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YE4ol-001FwI-DO
	for linux-watchdog@vger.kernel.org; Wed, 21 Jan 2015 23:36:11 +0000
Message-ID: <54C037E6.1000208@roeck-us.net>
Date: Wed, 21 Jan 2015 15:36:06 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Doug Anderson <dianders@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Heiko Stuebner <heiko@sntech.de>,
	Lunxue Dai <lunxue.dai@rock-chips.com>,
	Jisheng Zhang <jszhang@marvell.com>,
	Dinh Nguyen <dinguyen@altera.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: dw_wdt: Try to get a 30 second watchdog
 by default
References: <1421882243-3631-1-git-send-email-dianders@chromium.org> <1421882243-3631-2-git-send-email-dianders@chromium.org>
In-Reply-To: <1421882243-3631-2-git-send-email-dianders@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/21/2015 03:17 PM, Doug Anderson wrote:
> The dw_wdt_set_top() function takes in a value in seconds.  In
> dw_wdt_open() we were calling it with a value that's supposed to
> represent the maximum value programmed into the "top" register with a
> comment saying that we were trying to set the watchdog to its maximum
> value.  Instead we ended up setting the watchdog to ~15 seconds.
>
> Let's fix this.  However, setting things to the "max" gives me an 86
> second watchdog in the system I'm looking at.  86 seconds feels a
> little too long.  We'll explicitly choose 30 seconds as a more
> reasonable value.
>
> NOTE: Ideally this driver should be transitioned to be a real watchdog
> driver.  Then we could use "watchdog_init_timeout" and let the timeout
> be specified in a number of ways (device tree, module parameter, etc).
> This patch should be considered a bit of a stopgap solution.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


