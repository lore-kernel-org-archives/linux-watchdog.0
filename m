Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32770 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbdGGOXO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 10:23:14 -0400
Date: Fri, 7 Jul 2017 09:23:12 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de, Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v7 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
Message-ID: <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-15-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170702224051.15109-15-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 03, 2017 at 12:40:49AM +0200, Hauke Mehrtens wrote:
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++
>  5 files changed, 338 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> new file mode 100644
> index 000000000000..c538baa2ba54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> @@ -0,0 +1,42 @@
> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
> +===========================================
> +
> +This binding describes the USB PHY hardware provided by the RCU module on the
> +Lantiq XWAY SoCs.
> +
> +This driver has to be a sub node of the Lantiq RCU block.
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible	: Should be one of
> +			"lantiq,ase-usb2-phy"
> +			"lantiq,danube-usb2-phy"
> +			"lantiq,xrx100-usb2-phy"
> +			"lantiq,xrx200-usb2-phy"
> +			"lantiq,xrx300-usb2-phy"
> +- offset-phy	: Offset of the USB PHY configuration register
> +- offset-ana	: Offset of the USB Analog configuration register

These are not needed with the reg property used instead.

Rob
