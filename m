Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36221 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdF3MW5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 30 Jun 2017 08:22:57 -0400
MIME-Version: 1.0
In-Reply-To: <20170629213951.31176-11-hauke@hauke-m.de>
References: <20170629213951.31176-1-hauke@hauke-m.de> <20170629213951.31176-11-hauke@hauke-m.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 30 Jun 2017 15:22:56 +0300
Message-ID: <CAHp75Ve+oO7Zzk4jN3BOVCWWsEVki0yNQfpkfuw4Q5K85CMQHg@mail.gmail.com>
Subject: Re: [PATCH v6 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
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

> +static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
> +                                  unsigned long id, bool assert)
> +{
> +       struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
> +       unsigned int set = id & 0x1f;


> +       int ret;
> +       u32 val;
> +
> +       if (assert)
> +               val = BIT(set);
> +       else
> +               val = 0;

I would put this as

u32 val = assert ? BIT(set) : 0;
int ret;

...but it's up to you.

The rest looks fine.

> +
> +       ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set),
> +                                val);
> +       if (ret) {
> +               dev_err(priv->dev, "Failed to set reset bit %u\n", set);
> +               return ret;
> +       }
> +
> +
> +       ret = lantiq_rcu_reset_status_timeout(rcdev, id, assert);
> +       if (ret)
> +               dev_err(priv->dev, "Failed to %s bit %u\n",
> +                       assert ? "assert" : "deassert", set);
> +
> +       return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
