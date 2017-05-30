Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34289 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdE3XLs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 May 2017 19:11:48 -0400
Date: Tue, 30 May 2017 18:11:46 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH v2 07/15] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
Message-ID: <20170530231146.sk2zdq24a2oul6v4@rob-hp-laptop>
References: <20170521130918.27446-1-hauke@hauke-m.de>
 <20170521130918.27446-8-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170521130918.27446-8-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, May 21, 2017 at 03:09:10PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This allows using the xbar driver on ARX300 based SoCs which require the
> same xbar setup as the xRX200 chipsets because the xbar driver
> initialization is not guarded by an xRX200 specific
> of_machine_is_compatible condition anymore. Additionally the new driver
> takes a syscon phandle to configure the XBAR endianness bits in RCU
> (before this was done in arch/mips/lantiq/xway/reset.c and also
> guarded by an VRX200 specific if-statement).
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  24 +++++
>  MAINTAINERS                                        |   1 +
>  arch/mips/lantiq/xway/reset.c                      |   4 -
>  arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/lantiq/Makefile                        |   1 +
>  drivers/soc/lantiq/xbar.c                          | 101 +++++++++++++++++++++
>  7 files changed, 128 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/xbar.c
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> new file mode 100644
> index 000000000000..7e1ea5299744
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> @@ -0,0 +1,24 @@
> +Lantiq XWAY SoC XBAR binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: Should be one of
> +				"lantiq,xbar-xway"
> +				"lantiq,xbar-xrx200"

The normal form is <vendor>,<soc>-<block>.

> +- reg		: The address and length of the XBAR registers
> +
> +Optional properties:
> +- lantiq,rcu-syscon	: A phandle and offset to the endianness configuration
> +			  registers in the RCU module
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the XBAR on the xRX200 SoCs:
> +	xbar0: xbar@400000 {
> +		compatible = "lantiq,xbar-xway";
> +		reg = <0x400000 0x1000>;
> +		big-endian;
> +		lantiq,rcu-syscon = <&rcu0 0x4c>;
> +	};
