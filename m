Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36023 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752401AbdFTWUz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Jun 2017 18:20:55 -0400
Subject: Re: [PATCH v4 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170619222608.13344-1-hauke@hauke-m.de>
 <20170619222608.13344-15-hauke@hauke-m.de>
 <CAHp75VcYoPBd651s7a=y5yB3mjRG4W+=gWbeKFzwyw04qcg-MQ@mail.gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <a35bc5b3-fe52-8a06-6bc3-7f974c8b2740@hauke-m.de>
Date: Wed, 21 Jun 2017 00:20:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VcYoPBd651s7a=y5yB3mjRG4W+=gWbeKFzwyw04qcg-MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/20/2017 01:39 AM, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  41 ++++
>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 272 +++++++++++++++++++++
>>  5 files changed, 334 insertions(+), 12 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>>

....

>> +       /*
>> +        * Power on the USB PHY. We have to do it early because
>> +        * otherwise the second core won't turn on properly.
>> +        */
>> +       ret = clk_prepare_enable(priv->phy_gate_clk);
>> +       if (ret) {
>> +               dev_err(dev, "failed to enable PHY gate\n");
> 
> Disable and unprepare control clock.

Done, is there no devm_ version of this?

>> +               return ret;
>> +       }

...

>> +       ret = ltq_rcu_usb2_start_cores(priv);
>> +       if (ret)
>> +               return ret;
>> +
> 
>> +       provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +       if (IS_ERR(provider))
> 
> Remove line in between.

Done

>> +               return PTR_ERR(provider);
>> +
>> +       dev_set_drvdata(priv->dev, priv);
>> +       return 0;
> 
> You need to carefully check error path that you disabled clocks.

Done

>> +}
>> +

.....

Hauke

