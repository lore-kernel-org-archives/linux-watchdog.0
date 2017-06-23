Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33578 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbdFWWRh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Jun 2017 18:17:37 -0400
Date: Fri, 23 Jun 2017 17:17:35 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v5 12/16] MIPS: lantiq: Add a GPHY driver which uses the
 RCU syscon-mfd
Message-ID: <20170623221735.yxeqnn4javhboegx@rob-hp-laptop>
References: <20170620223743.13735-1-hauke@hauke-m.de>
 <20170620223743.13735-13-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620223743.13735-13-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 21, 2017 at 12:37:39AM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Compared to the old xrx200_phy_fw driver the new version has multiple
> enhancements. The name of the firmware files does not have to be added
> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
> instead. Each GPHY can now also boot separate firmware (thus mixing of
> GE and FE GPHYs is now possible).
> The new implementation is based on the RCU syscon-mfd and uses the
> reeset_controller framework instead of raw RCU register reads/writes.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  36 +++
>  arch/mips/lantiq/xway/sysctrl.c                    |   6 +-
>  drivers/soc/lantiq/Makefile                        |   1 +
>  drivers/soc/lantiq/gphy.c                          | 260 +++++++++++++++++++++
>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 ++
>  5 files changed, 316 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>  create mode 100644 drivers/soc/lantiq/gphy.c
>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
> new file mode 100644
> index 000000000000..ec09783da9b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
> @@ -0,0 +1,36 @@
> +Lantiq XWAY SoC GPHY binding
> +============================
> +
> +This binding describes a software-defined ethernet PHY, provided by the RCU
> +module on newer Lantiq XWAY SoCs (xRX200 and newer).
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,xrx200a1x-gphy"
> +				"lantiq,xrx200a2x-gphy"
> +				"lantiq,xrx300-gphy"
> +				"lantiq,xrx330-gphy"
> +- reg			: Addrress of the GPHY FW load address register
> +- resets		: Must reference the RCU GPHY reset bit
> +- reset-names		: One entry, value must be "gphy" or optional "gphy2"
> +- clocks		: A reference to the (PMU) GPHY clock gate
> +
> +Optional properties:
> +- lantiq,gphy-mode	: GPHY_MODE_GE (default) or GPHY_MODE_FE as defined in
> +			  <dt-bindings/mips/lantiq_xway_gphy.h>
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the GPHys on the xRX200 SoCs:
> +
> +#include <dt-bindings/mips/lantiq_rcu_gphy.h>
> +	gphy0: gphy@0 {

phy@20

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "lantiq,xrx200a2x-gphy";
> +		reg = <0x20 0x4>
> +
> +		resets = <&reset0 31 30>, <&reset1 7 7>;
> +		reset-names = "gphy", "gphy2";
> +		clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
> +		lantiq,gphy-mode = <GPHY_MODE_GE>
> +	};
