Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44603 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbA0CMb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Jan 2015 21:12:31 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YFvdn-002iHV-T1
	for linux-watchdog@vger.kernel.org; Tue, 27 Jan 2015 02:12:32 +0000
Message-ID: <54C6F409.2030206@roeck-us.net>
Date: Mon, 26 Jan 2015 18:12:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Doug Anderson <dianders@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Heiko Stuebner <heiko@sntech.de>,
	Lunxue Dai <lunxue.dai@rock-chips.com>,
	Jisheng Zhang <jszhang@marvell.com>,
	Dinh Nguyen <dinguyen@altera.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: dw_wdt: pat the watchdog before enabling
 it
References: <1422314836-30516-1-git-send-email-dianders@chromium.org>
In-Reply-To: <1422314836-30516-1-git-send-email-dianders@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/26/2015 03:27 PM, Doug Anderson wrote:
> On some dw_wdt implementations the "top" register may be initted to 0
> at bootup.  In such a case, each "pat" of the watchdog will reset the
> timer to 0xffff.  That's pretty short.
>
> The input clock of the wdt can be any of a wide range of values.  On
> an rk3288 system, I've seen the wdt clock be 24.75 MHz.  That means
> each tick is ~40ns and we'll count to 0xffff in ~2.6ms.
>
> Because of the above two facts, it's a really good idea to pat the
> watchdog after initting the "top" register properly and before
> enabling the watchdog.  If you don't then there's no way we'll get the
> next heartbeat in time.
>
> Jisheng Zhang fixed this problem on some dw_mmc versions by using the
> TOP_INIT feature.  However, the dw_wdt on rk3288 doesn't have TOP_INIT
> so it's a good idea to also pat the watchdog manually.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

