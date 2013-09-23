Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:41195 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab3IWHp2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Sep 2013 03:45:28 -0400
Received: by mail-qa0-f49.google.com with SMTP id k15so1263445qaq.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Sep 2013 00:45:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <523F07E4.8090801@roeck-us.net>
References: <1379832237-3833-1-git-send-email-Baohua.Song@csr.com> <523F07E4.8090801@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 23 Sep 2013 15:45:08 +0800
Message-ID: <CAGsJ_4xaNgitmRxSucfgT47ULh=wVhp09of4id0JEkx0mSyY5Q@mail.gmail.com>
Subject: Re: [PATCH v3] watchdog: sirf: add watchdog driver of CSR SiRFprimaII
 and SiRFatlasVI
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>,
	Xianglong Du <Xianglong.Du@csr.com>,
	Barry Song <Baohua.Song@csr.com>,
	Romain Izard <romain.izard.pro@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2013/9/22 Guenter Roeck <linux@roeck-us.net>:
> On 09/21/2013 11:43 PM, Barry Song wrote:
>>
>> From: Xianglong Du <Xianglong.Du@csr.com>
>>
>> On CSR SiRFprimaII and SiRFatlasVI, the 6th timer can act as a watchdog
>> timer when the Watchdog mode is enabled.
>>
>> watchdog occur when TIMER watchdog counter matches the value software
>> pre-set, when this event occurs, the effect is the same as the system
>> software reset.
>>
>> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> Cc: Romain Izard <romain.izard.pro@gmail.com>
>> ---
>>   -v3: cleanup according to feedback from Romain Izard, thanks!
>>   .../devicetree/bindings/watchdog/sirfsoc_wdt.txt   |  15 ++
>>   arch/arm/configs/prima2_defconfig                  |   1 +
>>   drivers/watchdog/Kconfig                           |   9 +
>>   drivers/watchdog/Makefile                          |   1 +
>>   drivers/watchdog/sirfsoc_wdt.c                     | 242
>> +++++++++++++++++++++
>>   5 files changed, 268 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
>>   create mode 100644 drivers/watchdog/sirfsoc_wdt.c
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
>> b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
>> new file mode 100644
>> index 0000000..7d11960
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
>> @@ -0,0 +1,15 @@
>> +SiRFSoC Timer and Watchdog Timer(WDT) Controller
>> +
>> +Required properties:
>> +- compatible: "sirf,prima2-tick"
>> +- reg: Address range of tick timer/WDT register set
>> +- interrupts: interrupt number to the cpu
>> +
>> +Example:
>> +
>> +timer@b0020000 {
>> +       compatible = "sirf,prima2-tick";
>> +       reg = <0xb0020000 0x1000>;
>> +       interrupts = <0>;
>> +};
>> +
>> diff --git a/arch/arm/configs/prima2_defconfig
>> b/arch/arm/configs/prima2_defconfig
>> index 002a1ce..23591db 100644
>> --- a/arch/arm/configs/prima2_defconfig
>> +++ b/arch/arm/configs/prima2_defconfig
>> @@ -39,6 +39,7 @@ CONFIG_SPI=y
>>   CONFIG_SPI_SIRF=y
>>   CONFIG_SPI_SPIDEV=y
>>   # CONFIG_HWMON is not set
>> +CONFIG_WATCHDOG=y
>>   CONFIG_USB_GADGET=y
>>   CONFIG_USB_MASS_STORAGE=m
>>   CONFIG_MMC=y
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index d1d53f3..98fb560 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -392,6 +392,15 @@ config RETU_WATCHDOG
>>           To compile this driver as a module, choose M here: the
>>           module will be called retu_wdt.
>>
>> +config SIRFSOC_WATCHDOG
>> +       tristate "SiRFSOC watchdog"
>> +       depends on ARCH_SIRF
>> +       select WATCHDOG_CORE
>> +       default y
>> +       help
>> +         Support for CSR SiRFprimaII and SiRFatlasVI watchdog. When
>> +         the watchdog triggers the system will be reset.
>> +
>
>
> You might add "To compile this driver as a module ..."; this would
> help the user to know how the module is named, and have the nice side
> effect of silencing the watchdog warning.

here coming v4 which fixes the issues in your comments. thanks!

-barry
