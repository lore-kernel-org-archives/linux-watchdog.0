Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36011 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752401AbdFTWTN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Jun 2017 18:19:13 -0400
Subject: Re: [PATCH v4 12/16] MIPS: lantiq: Add a GPHY driver which uses the
 RCU syscon-mfd
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170619222608.13344-1-hauke@hauke-m.de>
 <20170619222608.13344-13-hauke@hauke-m.de>
 <CAHp75VcDgC7n3FVig0r0RBg=B655sv_jWQt7RWXU9uPx9QGvqA@mail.gmail.com>
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
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <c3fae486-6ded-0bb2-d7e4-89ada96986d0@hauke-m.de>
Date: Wed, 21 Jun 2017 00:19:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VcDgC7n3FVig0r0RBg=B655sv_jWQt7RWXU9uPx9QGvqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/20/2017 01:36 AM, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> Compared to the old xrx200_phy_fw driver the new version has multiple
>> enhancements. The name of the firmware files does not have to be added
>> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
>> instead. Each GPHY can now also boot separate firmware (thus mixing of
>> GE and FE GPHYs is now possible).
>> The new implementation is based on the RCU syscon-mfd and uses the
>> reeset_controller framework instead of raw RCU register reads/writes.
>>
> 
> Couple of comments, otherwise FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  36 +++
>>  arch/mips/lantiq/xway/sysctrl.c                    |   6 +-
>>  drivers/soc/lantiq/Makefile                        |   1 +
>>  drivers/soc/lantiq/gphy.c                          | 261 +++++++++++++++++++++
>>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 ++
>>  5 files changed, 317 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>>  create mode 100644 drivers/soc/lantiq/gphy.c
>>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h

......

>> +
>> +       /*
>> +        * GPHY cores need the firmware code in a persistent and contiguous
>> +        * memory area with a 16 kB boundary aligned start address.
>> +        */
>> +       priv->size = fw->size + XRX200_GPHY_FW_ALIGN;
>> +
>> +       priv->fw_addr = dma_alloc_coherent(dev, priv->size,
>> +                                          &priv->dma_addr, GFP_KERNEL);
> 
> dmam_ ?

Thanks, didn't know this functions was looking for something with devm_
prefix, but dmam_ makes the code simpler.

....

>> +
>> +       ret = xway_gphy_load(dev, priv, &fw_addr);
>> +       if (ret)
> 
> You need to disable and unprepare a clock.

Done

>> +               return ret;
>> +

....
> 
>> +       dma_free_coherent(dev, priv->size, priv->fw_addr, priv->dma_addr);
> 
> It will go away if dmam_ variant is in use.

Done

>> +
>> +       ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
>> +       if (ret)
>> +               dev_warn(dev, "Failed to unregister reboot notifier\n");
...

Hauke

