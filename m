Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42813 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750880AbdE2KUq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 May 2017 06:20:46 -0400
Message-ID: <1496053214.17695.49.camel@pengutronix.de>
Subject: Re: [PATCH v3 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org,
        andy.shevchenko@gmail.com
Date: Mon, 29 May 2017 12:20:14 +0200
In-Reply-To: <20170528184006.31668-11-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
         <20170528184006.31668-11-hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Hauke,

On Sun, 2017-05-28 at 20:40 +0200, Hauke Mehrtens wrote:
[...]
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
> @@ -0,0 +1,30 @@
> +Lantiq XWAY SoC RCU reset controller binding
> +============================================
> +
> +This binding describes a reset-controller found on the RCU module on Lantiq
> +XWAY SoCs.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,reset-danube"
> +				"lantiq,reset-xrx200"
> +- regmap		: A phandle to the RCU syscon
> +- offset-set		: Offset of the reset set register
> +- offset-status		: Offset of the reset status register
> +- #reset-cells		: Specifies the number of cells needed to encode the
> +			  reset line, should be 2.
> +			  The first cell takes the reset set bit and the
> +			  second cell takes the status bit.
> +
> +-------------------------------------------------------------------------------
> +Example for the reset-controllers on the xRX200 SoCs:
> +	reset0: reset-controller@0 {
> +		compatible = "lantiq,reset-xrx200";
> +
> +		regmap = <&rcu0>;

Why not place these nodes as children of &rcu0 ? This property would be
superfluous then.

> +		offset-set = <0x10>;
> +		offset-status = <0x14>;
> +		#reset-cells = <2>;
> +	};
[...]
> --- /dev/null
> +++ b/drivers/reset/reset-lantiq.c
> @@ -0,0 +1,205 @@
[...]
> +static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
> +				   unsigned long id, bool assert)
> +{
> +	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
> +	int ret, retry = LANTIQ_RCU_RESET_TIMEOUT;
> +	unsigned int set = id & 0x1f;
> +	u32 val;
> +
> +	if (assert)
> +		val = BIT(set);
> +	else
> +		val = 0;
> +
> +	ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set),
> +				 val);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to set reset bit %u\n", set);
> +		return ret;
> +	}
> +
> +	do {
> +		ret = lantiq_rcu_reset_status(rcdev, id);
> +		if (ret < 0)
> +			return ret;
> +		if (ret == assert)
> +			break;
> +		usleep_range(20, 40);
> +	} while (--retry);

How about wrapping this in a lantiq_rcu_poll_status(_timeout) function?
I still think this is a case where regmap_read_poll_timeout could be
used.

[...]
> +static int lantiq_rcu_reset_of_probe(struct platform_device *pdev,
> +			       struct lantiq_rcu_reset_priv *priv)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	priv->regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");

Why not use syscon_node_to_regmap(dev->of_node->parent) ?

regards
Philipp

