Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34532 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdE3SX2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 May 2017 14:23:28 -0400
MIME-Version: 1.0
In-Reply-To: <20170528184006.31668-9-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de> <20170528184006.31668-9-hauke@hauke-m.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 May 2017 21:23:26 +0300
Message-ID: <CAHp75VcU3cF07GQG5vPV9uhmpOzO2aGD8Fj9-Do4yN3BXNN1Rg@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] MIPS: lantiq: Convert the fpi bus driver to a platform_driver
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

On Sun, May 28, 2017 at 9:39 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.

> +Optional properties:
> +- regmap               : A phandle to the RCU syscon

> +- offset-endianness    : Offset of the endianness configuration register

Shouldn't be one of

big-endian;
little-endian;
native-endian;

?

For what purpose that register is used?
Is it configurable in RTL? IOW why you need to have it in DT?

> +               offset-endianness = <0x4c>;
> +               big-endian;

> +       /* RCU configuration is optional */
> +       rcu_regmap = syscon_regmap_lookup_by_phandle(np, "regmap");

> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {

_OR_NULL is suspicious. You are doing something wrong.

-- 
With Best Regards,
Andy Shevchenko
