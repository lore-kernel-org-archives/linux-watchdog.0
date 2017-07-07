Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:55258 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbdGGSt2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 14:49:28 -0400
Subject: Re: [PATCH v7 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To: Rob Herring <robh@kernel.org>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-15-hauke@hauke-m.de>
 <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de, Kishon Vijay Abraham I <kishon@ti.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <534b3592-2803-ac95-ad60-3cf5d1252413@hauke-m.de>
Date: Fri, 7 Jul 2017 20:49:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 07/07/2017 04:23 PM, Rob Herring wrote:
> On Mon, Jul 03, 2017 at 12:40:49AM +0200, Hauke Mehrtens wrote:
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++
>>  5 files changed, 338 insertions(+), 12 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>> new file mode 100644
>> index 000000000000..c538baa2ba54
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>> @@ -0,0 +1,42 @@
>> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
>> +===========================================
>> +
>> +This binding describes the USB PHY hardware provided by the RCU module on the
>> +Lantiq XWAY SoCs.
>> +
>> +This driver has to be a sub node of the Lantiq RCU block.
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties (controller (parent) node):
>> +- compatible	: Should be one of
>> +			"lantiq,ase-usb2-phy"
>> +			"lantiq,danube-usb2-phy"
>> +			"lantiq,xrx100-usb2-phy"
>> +			"lantiq,xrx200-usb2-phy"
>> +			"lantiq,xrx300-usb2-phy"
>> +- offset-phy	: Offset of the USB PHY configuration register
>> +- offset-ana	: Offset of the USB Analog configuration register
> 
> These are not needed with the reg property used instead.

Hi Rob,

These register are also used by completely different drivers, the
hardware engineers used some bits of these registers for completely
different purposes, some bits are used for DSL instead of USB PHY. When
I io map them, they can only be access through this driver.

Should I get the register from the reg property and access them though
regmap or how should I make sure also other drivers can access the other
bits.

Hauke
