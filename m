Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34129 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934842AbdEWHwO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 May 2017 03:52:14 -0400
MIME-Version: 1.0
In-Reply-To: <20170521130918.27446-12-hauke@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de> <20170521130918.27446-12-hauke@hauke-m.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 23 May 2017 10:52:12 +0300
Message-ID: <CAHp75VdSAGv0md8YsvwdZJX4Eo-K6Tv3TcyAVKfOmdk6De1iGQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] MIPS: lantiq: Add a GPHY driver which uses the
 RCU syscon-mfd
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, May 21, 2017 at 4:09 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:

> Compared to the old xrx200_phy_fw driver the new version has multiple
> enhancements. The name of the firmware files does not have to be added
> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
> instead. Each GPHY can now also boot separate firmware (thus mixing of
> GE and FE GPHYs is now possible).
> The new implementation is based on the RCU syscon-mfd and uses the
> reeset_controller framework instead of raw RCU register reads/writes.

> +static int xway_gphy_load(struct platform_device *pdev,
> +                         const char *fw_name, dma_addr_t *dev_addr)
> +{
> +       const struct firmware *fw;
> +       void *fw_addr;
> +       size_t size;
> +       int ret;
> +

> +       dev_info(&pdev->dev, "requesting %s\n", fw_name);

Noise.

> +       ret = request_firmware(&fw, fw_name, &pdev->dev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to load firmware: %s, error: %i\n",
> +                       fw_name, ret);
> +               return ret;
> +       }
> +

> +       /*
> +        * GPHY cores need the firmware code in a persistent and contiguous
> +        * memory area with a 16 kB boundary aligned start address

Add period to the end.

> +        */

> +static int xway_gphy_of_probe(struct platform_device *pdev,
> +                               struct xway_gphy_priv *priv)
> +{

> +       priv->gphy_reset = devm_reset_control_get(&pdev->dev, "gphy");
> +       if (IS_ERR_OR_NULL(priv->gphy_reset)) {

_OR_NULL part looks suspicious.
There is _optional() variant of reset API, AFAIR.

> +               if (PTR_ERR(priv->gphy_reset) != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "Failed to lookup gphy reset\n");
> +               return PTR_ERR(priv->gphy_reset);
> +       }

> +       priv->gphy_reset2 = devm_reset_control_get_optional(&pdev->dev, "gphy2");
> +       if (IS_ERR(priv->gphy_reset2)) {
> +               if (PTR_ERR(priv->gphy_reset2) == -EPROBE_DEFER)
> +                       return PTR_ERR(priv->gphy_reset2);

> +               priv->gphy_reset2 = NULL;

Why?

If there is a problem in reset framework it should be fixed there, not here.

> +       }
> +
> +       if (of_property_read_u32(np, "lantiq,gphy-mode", &gphy_mode))

> +               /* Default to GE mode */

If you put more lines in the branch you perhaps need {}.

> +               gphy_mode = GPHY_MODE_GE;

> +static int xway_gphy_probe(struct platform_device *pdev)
> +{
> +       struct xway_gphy_priv *priv;
> +       dma_addr_t fw_addr = 0;
> +       int ret;

> +       if (!IS_ERR_OR_NULL(priv->gphy_clk_gate))

_OR_NULL is redundant.
IS_ERR should not happen here if clock is mandatory.

Thus, complete line is redundant.

> +               clk_prepare_enable(priv->gphy_clk_gate);

You need to check return value.

-- 
With Best Regards,
Andy Shevchenko
