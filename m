Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36780 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965717AbdDTOsv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Apr 2017 10:48:51 -0400
Date: Thu, 20 Apr 2017 09:48:48 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 06/13] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
Message-ID: <20170420144848.hwvtrhnwxcsxyv7x@rob-hp-laptop>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-7-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-7-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 17, 2017 at 09:29:35PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This allows using the xbar driver on ARX300 based SoCs which require the
> same xbar setup as the xRX200 chipsets because the xbar driver
> initialization is not guarded by an xRX200 specific
> of_machine_is_compatible condition anymore. Additionally the new driver
> takes a syscon phandle to configure the XBAR endianness bits in RCU
> (before this was done in arch/mips/lantiq/xway/reset.c and also
> guarded by an xRX200 specific if-statement).
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 +++++
>  MAINTAINERS                                        |   1 +
>  arch/mips/lantiq/xway/reset.c                      |   4 -
>  arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/lantiq/Makefile                        |   1 +
>  drivers/soc/lantiq/xbar.c                          | 100 +++++++++++++++++++++
>  7 files changed, 125 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/xbar.c
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> new file mode 100644
> index 000000000000..86e53ff3b0d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> @@ -0,0 +1,22 @@
> +Lantiq XWAY SoC XBAR binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: Should be "lantiq,xbar-xway"

This compatible is already in use so it is fine, but you should also 
have per SoC compatible strings.

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
