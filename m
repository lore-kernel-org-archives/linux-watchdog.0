Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28412 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752308AbaAUMsL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 07:48:11 -0500
Date: Tue, 21 Jan 2014 07:47:46 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 15/15] ARM: mvebu: Enable watchdog support in
 defconfig
Message-ID: <20140121124746.GZ29184@titan.lakedaemon.net>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-16-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390295561-3466-16-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 06:12:41AM -0300, Ezequiel Garcia wrote:
> Now that we have proper support for Armada 370/XP watchdog
> let's enable it in the defconfig.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Just a note to myself more than anything: I need to square up multi_v7
with mvebu.  As we make these changes next cycle, we need to be able to
easily test that we aren't breaking multiplat build or boot.

Hopefully I can get some defconfig changes in for -rc1? :)

thx,

Jason.

> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 594d706..84ec924 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -60,6 +60,8 @@ CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_THERMAL=y
>  CONFIG_ARMADA_THERMAL=y
> +CONFIG_WATCHDOG=y
> +CONFIG_ORION_WATCHDOG=y
>  CONFIG_USB_SUPPORT=y
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
> -- 
> 1.8.1.5
> 
