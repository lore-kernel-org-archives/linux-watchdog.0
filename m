Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51152 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbbCINKI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Mar 2015 09:10:08 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YUxRf-0041AT-Ld
	for linux-watchdog@vger.kernel.org; Mon, 09 Mar 2015 13:10:07 +0000
Message-ID: <54FD9BAE.4040306@roeck-us.net>
Date: Mon, 09 Mar 2015 06:10:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu
CC: Zach Pfeffer <zachp@xilinx.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: cadence: Remove Kconfig dependency on ARCH
References: <491e97be16decb4901fa2b0be4b530774501b5c1.1425891008.git.michal.simek@xilinx.com>
In-Reply-To: <491e97be16decb4901fa2b0be4b530774501b5c1.1425891008.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/09/2015 01:50 AM, Michal Simek wrote:
> Remove Kconfig dependency and enable driver for
> all ARCHs.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Test for all archs done by Kbuild test robot without any problem.

Looks ok. To be sure, I'll run it through my test farm as well.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>   drivers/watchdog/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 16f202350997..6442412377a4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -169,7 +169,6 @@ config AT91SAM9X_WATCHDOG
>
>   config CADENCE_WATCHDOG
>   	tristate "Cadence Watchdog Timer"
> -	depends on ARM
>   	select WATCHDOG_CORE
>   	help
>   	  Say Y here if you want to include support for the watchdog
>

