Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35608 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760532AbdDYGvw (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 Apr 2017 02:51:52 -0400
Subject: Re: [PATCH 11/13] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-12-hauke@hauke-m.de>
 <CAFBinCAB=vaDpzCoMFX8w9j0R04i6Zr4mbjDtteKsQ_LkKAaLg@mail.gmail.com>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <b1d3a133-932c-a427-4b32-f3fad676b4a4@hauke-m.de>
Date: Tue, 25 Apr 2017 08:51:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAFBinCAB=vaDpzCoMFX8w9j0R04i6Zr4mbjDtteKsQ_LkKAaLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 04/17/2017 11:23 PM, Martin Blumenstingl wrote:
> On Mon, Apr 17, 2017 at 9:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> you should probably send this patch to the PHY maintainer as well
> (Kishon Vijay Abraham I <kishon@ti.com>)
> 
>> ---
>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  59 ++++
>>  arch/mips/lantiq/xway/reset.c                      |  43 ---
>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 325 +++++++++++++++++++++
>>  6 files changed, 405 insertions(+), 55 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>> new file mode 100644
>> index 000000000000..0ec9f790b6e0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>> @@ -0,0 +1,59 @@
>> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
>> +===========================================
>> +
>> +This binding describes the USB PHY hardware provided by the RCU module on the
>> +Lantiq XWAY SoCs.
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties (controller (parent) node):
>> +- compatible           : Should be one of
>> +                               "lantiq,ase-rcu-usb2-phy"
>> +                               "lantiq,danube-rcu-usb2-phy"
>> +                               "lantiq,xrx100-rcu-usb2-phy"
>> +                               "lantiq,xrx200-rcu-usb2-phy"
>> +                               "lantiq,xrx300-rcu-usb2-phy"
>> +- lantiq,rcu-syscon    : A phandle to the RCU module and the offsets to the
>> +                         USB PHY configuration and USB MAC registers.
>> +- address-cells                : should be 1
>> +- size-cells           : should be 0
>> +- phy-cells            : from the generic PHY bindings, must be 1
>> +
>> +Optional properties (controller (parent) node):
>> +- vbus-gpio            : References a GPIO which enables VBUS all given USB
>> +                         ports.
> the PHY framework already handles this if you wrap the GPIO in a
> "regulator-fixed" node, see [0] how to define a fixed regulator with a
> GPIO (the regulator in this example has two states: off = 0V and on =
> 5V, probably exactly what you need) and [1] how to pass it to the PHY
> (phy-core.c handles this already, no driver specific code needed)

Thanksy, I will change the code and use a regulator.

......

>> diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
>> index 3f30fb81a50f..5aec1f54275b 100644
>> --- a/arch/mips/lantiq/xway/reset.c
>> +++ b/arch/mips/lantiq/xway/reset.c
> could these arch/mips/lantiq/xway/reset.c changes to into PATCH #3 as well?

I do not get this.

......

> [0] https://github.com/torvalds/linux/blob/2fbbc4bf69f293df317559a267f4120f290b8fc4/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi#L67
> [1] https://github.com/torvalds/linux/blob/2fbbc4bf69f293df317559a267f4120f290b8fc4/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi#L133
> 
