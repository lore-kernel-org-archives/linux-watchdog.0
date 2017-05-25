Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:46610 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938825AbdEYSyg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 25 May 2017 14:54:36 -0400
Subject: Re: [PATCH v2 07/15] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170521130918.27446-1-hauke@hauke-m.de>
 <20170521130918.27446-8-hauke@hauke-m.de>
 <CAHp75VeQgekiWc+YxP5sDFBB4fvmRs1=heFcdYS6mAgqPACW7g@mail.gmail.com>
 <aa0f9259-b96f-f072-93d4-a42e05fadc82@hauke-m.de>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi <linux-spi@vger.kernel.org>, hauke.mehrtens@intel.com,
        Rob Herring <robh@kernel.org>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5a7ebea5-d98b-f84b-64a0-86127ed31feb@hauke-m.de>
Date: Thu, 25 May 2017 20:54:34 +0200
MIME-Version: 1.0
In-Reply-To: <aa0f9259-b96f-f072-93d4-a42e05fadc82@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/25/2017 08:22 PM, Hauke Mehrtens wrote:
> On 05/22/2017 08:05 AM, Andy Shevchenko wrote:
>> On Sun, May 21, 2017 at 4:09 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>
>>> This allows using the xbar driver on ARX300 based SoCs which require the
>>> same xbar setup as the xRX200 chipsets because the xbar driver
>>> initialization is not guarded by an xRX200 specific
>>> of_machine_is_compatible condition anymore. Additionally the new driver
>>> takes a syscon phandle to configure the XBAR endianness bits in RCU
>>> (before this was done in arch/mips/lantiq/xway/reset.c and also
>>> guarded by an VRX200 specific if-statement).
>>
>>
>>> +builtin_platform_driver(xbar_driver);
>>
>> Why it can't be module?
> 
> Currently this is used to load it early. This sets the AHB bus system
> which connects the USB and the PCIe controllers to the system to big
> Endian mode, this is needed for at least some accesses to these
> components. It would be better to have a dependency in device tree to
> reflect this.
> Should I use a phandle to connect them?
> 
> Hauke
> 

I will try to make this a bus driver which should be used instead of the
smiple-bus.

Hauke

