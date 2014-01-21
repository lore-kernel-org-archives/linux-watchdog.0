Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:43387 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbaAUJlW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:41:22 -0500
Message-ID: <52DE40BD.10700@gmail.com>
Date: Tue, 21 Jan 2014 10:41:17 +0100
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 14/15] watchdog: orion: Allow to build on any Orion
 platform
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390295561-3466-15-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390295561-3466-15-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/21/14 10:12, Ezequiel Garcia wrote:
> After getting rid of all the mach-specific code, it's now possible
> to allow builds in any Orion platform.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5be6e91..1689f72 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -282,7 +282,7 @@ config DAVINCI_WATCHDOG
>
>   config ORION_WATCHDOG
>   	tristate "Orion watchdog"
> -	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE
> +	depends on PLAT_ORION

Ezequiel,

while above is true now, I tend to rather have ARCH_MVEBU added here.
We really want to get rid of both !ARCH_MVEBU and PLAT_ORION and this
unnecessarily will make it more complicated.

I haven't checked why ARCH_MVEBU at all added PLAT_ORION as dependency,
but IIRC it was just because of a missing mbus driver? If it is just
this, we should also remove PLAT_ORION from ARCH_MVEBU to have a clean
cut between new common arch and existing sub-archs.

Sebastian

>   	select WATCHDOG_CORE
>   	help
>   	  Say Y here if to include support for the watchdog timer
>

