Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35621 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165261AbdDYG4Z (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 Apr 2017 02:56:25 -0400
Subject: Re: [PATCH 06/13] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
To: Rob Herring <robh@kernel.org>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-7-hauke@hauke-m.de>
 <20170420144848.hwvtrhnwxcsxyv7x@rob-hp-laptop>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <8742e3b3-4dc2-bc74-f607-00d96f74512c@hauke-m.de>
Date: Tue, 25 Apr 2017 08:56:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170420144848.hwvtrhnwxcsxyv7x@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 04/20/2017 04:48 PM, Rob Herring wrote:
> On Mon, Apr 17, 2017 at 09:29:35PM +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> This allows using the xbar driver on ARX300 based SoCs which require the
>> same xbar setup as the xRX200 chipsets because the xbar driver
>> initialization is not guarded by an xRX200 specific
>> of_machine_is_compatible condition anymore. Additionally the new driver
>> takes a syscon phandle to configure the XBAR endianness bits in RCU
>> (before this was done in arch/mips/lantiq/xway/reset.c and also
>> guarded by an xRX200 specific if-statement).
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 +++++
>>  MAINTAINERS                                        |   1 +
>>  arch/mips/lantiq/xway/reset.c                      |   4 -
>>  arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>>  drivers/soc/Makefile                               |   1 +
>>  drivers/soc/lantiq/Makefile                        |   1 +
>>  drivers/soc/lantiq/xbar.c                          | 100 +++++++++++++++++++++
>>  7 files changed, 125 insertions(+), 45 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>>  create mode 100644 drivers/soc/lantiq/Makefile
>>  create mode 100644 drivers/soc/lantiq/xbar.c
>>
>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>> new file mode 100644
>> index 000000000000..86e53ff3b0d5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>> @@ -0,0 +1,22 @@
>> +Lantiq XWAY SoC XBAR binding
>> +============================
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties:
>> +- compatible	: Should be "lantiq,xbar-xway"
> 
> This compatible is already in use so it is fine, but you should also 
> have per SoC compatible strings.

I will add a new SoC specific one.
What does per SoC device tree mean? Does it mean for the same silicon,
for the same silicon revision, for the same fusing of a silicon or for
the same marketing name?

I would like to make it per silicon or per silicon revision for the IP
cores which I know are different.

Hauke
