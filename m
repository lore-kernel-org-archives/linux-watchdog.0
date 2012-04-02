Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58749 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab2DBTij (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Apr 2012 15:38:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH v2 3/8] net: Add device tree support to LPC32xx
Date: Mon, 2 Apr 2012 19:37:54 +0000
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	w.sang@pengutronix.de, srinivas.bakki@nxp.com, kevin.wells@nxp.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, wim@iguana.be, jonsmirl@gmail.com
References: <1333391587-26290-1-git-send-email-stigge@antcom.de> <1333391587-26290-4-git-send-email-stigge@antcom.de>
In-Reply-To: <1333391587-26290-4-git-send-email-stigge@antcom.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204021937.54567.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 02 April 2012, Roland Stigge wrote:
> 
> +       if (pdev->dev.of_node && of_get_property(pdev->dev.of_node,
> +                                                "use-iram", NULL))
> +               pldat->use_iram = true;
> +       else
> +               pldat->use_iram = false;
> +

One more thing I just noticed:

this is equivalent to the much shorter 

	pldat->use_iram = of_property_read_bool(pdev->dev.of_node, "use-iram");

Everything else looks good here.

	Arnd
