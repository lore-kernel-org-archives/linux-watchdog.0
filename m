Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36614 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdF3MTR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 30 Jun 2017 08:19:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170629213951.31176-9-hauke@hauke-m.de>
References: <20170629213951.31176-1-hauke@hauke-m.de> <20170629213951.31176-9-hauke@hauke-m.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 30 Jun 2017 15:19:16 +0300
Message-ID: <CAHp75VeQ=i6LgTaMZeDWdiK-60C9=crBXoGWqQDfP4bsRWd-zA@mail.gmail.com>
Subject: Re: [PATCH v6 08/16] MIPS: lantiq: Convert the fpi bus driver to a platform_driver
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jun 30, 2017 at 12:39 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.

> +       /* RCU configuration is optional */
> +       rcu_regmap = syscon_regmap_lookup_by_phandle(np, "lantiq,rcu");
> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {

It's still concerning me.

If the API is correctly designed then it should look something like

if (IS_ERR(...))
 return PTR_ERR(...);

if (!...) {
 ...stuff for optional case...
}

> +               ret = device_property_read_u32(dev, "lantiq,offset-endianness",
> +                                          &rcu_ahb_endianness_reg_offset);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (regmap_update_bits(rcu_regmap,
> +                                       rcu_ahb_endianness_reg_offset,
> +                                       RCU_VR9_BE_AHB1S,
> +                                       RCU_VR9_BE_AHB1S))
> +                       dev_warn(&pdev->dev,
> +                               "Failed to configure RCU AHB endianness\n");
> +       }
> +
> +       /* disable fpi burst */
> +       ltq_w32_mask(XBAR_FPI_BURST_EN, 0, xbar_membase + XBAR_ALWAYS_LAST);
> +
> +       return of_platform_populate(dev->of_node, NULL, NULL, dev);
> +}

-- 
With Best Regards,
Andy Shevchenko
