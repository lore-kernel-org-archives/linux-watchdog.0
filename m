Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54546 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab3IOSJf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 15 Sep 2013 14:09:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: Re: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
Date: Sun, 15 Sep 2013 20:09:26 +0200
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Olof Johansson <olof@lixom.net>,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
References: <20130914152032.401907974@gmail.com> <20130914152124.317379835@gmail.com>
In-Reply-To: <20130914152124.317379835@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201309152009.26462.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Saturday 14 September 2013, Domenico Andreoli wrote:
> +
> +static int __init bcm4760_wdt_init(void)
> +{
> +	struct device_node *node;
> +
> +	node = of_find_matching_node(NULL, bcm4760_pm_wdt_match);
> +	if (!node) {
> +		pr_info("No bcm4760 watchdog node\n");
> +		return -1;
> +	}
> +
> +	wdt_regs = of_iomap(node, 0);
> +	of_node_put(node);

Since this is now in the drivers directory and initialized at regular
module_init level, I'd ask you to register it as a proper platform_driver
and move the initialization into the probe() callback. You also need to
put Wim as the watchdog subsystem maintainer on Cc (I did in this reply)
and ask him to merge the driver.

I assume that Wim will ask you to add a watchdog_register_device() call
and a set of watchdog_ops to make this a functional driver. From the
platform perspective, I don't care, but it is certainly a logical step.

	Arnd
