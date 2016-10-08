Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 8 Oct 2016 16:14:16 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	shubhrajyoti.datta@gmail.com
Subject: Re: [PATCHv3] watchdog: cadence_wdt: Fix the suspend resume
Message-ID: <20161008141416.GI23290@spo001.leaseweb.nl>
References: <1473665029-15999-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473665029-15999-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Shubhrajyoti,

> Currently even if no users are there the suspend tries to
> stop the watchdog and resume starts it.
> 
> so after resume the watchdog starts and resets the board.
> Fix the same by adding a check for users.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2: use watchdog_active
> v3: Add Guenter Roeck reviewed by tag

This patch was added to linux-watchdog-next almost 2 weeks ago.

Kind regards,
Wim.
