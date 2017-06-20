Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35996 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752698AbdFTWRJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Jun 2017 18:17:09 -0400
Subject: Re: [PATCH v4 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170619222608.13344-1-hauke@hauke-m.de>
 <20170619222608.13344-11-hauke@hauke-m.de>
 <CAHp75Vc+UGCat0QcVeDuxEugc9r=yB5HNPnHuzAdmQnkK2=hGg@mail.gmail.com>
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
Message-ID: <9a0479f2-e40d-fabb-38ce-8ea366f3da40@hauke-m.de>
Date: Wed, 21 Jun 2017 00:17:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc+UGCat0QcVeDuxEugc9r=yB5HNPnHuzAdmQnkK2=hGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/20/2017 01:29 AM, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> The reset controllers (on xRX200 and newer SoCs have two of them) are
>> provided by the RCU module. This was initially implemented as a simple
>> reset controller. However, the RCU module provides more functionality
>> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
>> The old reset controller driver implementation from
>> arch/mips/lantiq/xway/reset.c did not honor this fact.
>>
>> For some devices the request and the status bits are different.
>>
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> One nit below.
> 
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> ---
>>  .../devicetree/bindings/reset/lantiq,reset.txt     |  29 +++
>>  drivers/reset/Kconfig                              |   6 +
>>  drivers/reset/Makefile                             |   1 +
>>  drivers/reset/reset-lantiq.c                       | 215 +++++++++++++++++++++
>>  4 files changed, 251 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
>>  create mode 100644 drivers/reset/reset-lantiq.c

......

>> +static int lantiq_rcu_reset_status_timeout(struct reset_controller_dev *rcdev,
>> +                                          unsigned long id, bool assert)
>> +{
>> +       int ret;
>> +       int retry = LANTIQ_RCU_RESET_TIMEOUT;
>> +
>> +       do {
>> +               ret = lantiq_rcu_reset_status(rcdev, id);
>> +               if (ret < 0)
>> +                       return ret;
> 
>> +               if (ret == assert)
>> +                       break;
> 
> return 0;
> 
>> +               usleep_range(20, 40);
>> +       } while (--retry);
>> +
> 
>> +       return retry ? 0 : -ETIMEDOUT;
> 
> return -ETIMEDOUT;
> 
Changed

...

Hauke


