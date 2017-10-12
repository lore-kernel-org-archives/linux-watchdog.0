Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49208 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbdJLUMj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Oct 2017 16:12:39 -0400
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@iguana.be" <wim@iguana.be>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] ARM: mvebu: dts: connect interrupt for WD on
 armada-38x
Date: Thu, 12 Oct 2017 20:12:36 +0000
Message-ID: <69ab72d5008744df9455712c2c821730@svr-chch-ex1.atlnz.lc>
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
 <20171011022958.31268-4-chris.packham@alliedtelesis.co.nz>
 <874lr4bgdh.fsf@free-electrons.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 13/10/17 03:17, Gregory CLEMENT wrote:=0A=
> Hi Chris,=0A=
>   =0A=
>   On mer., oct. 11 2017, Chris Packham <chris.packham@alliedtelesis.co.nz=
> wrote:=0A=
> =0A=
>> The watchdog timer interrupt is available internally on the Armada-38x=
=0A=
>> SoCs. Connect it so that we can have the orion_wdt_irq generate debug=0A=
>> information when a watchdog timeout occurs.=0A=
> =0A=
> Given the patch 2, when an interrupt is provided by the dt, then the=0A=
> behavior of the watchdog changes. So we can't do it for all the=0A=
> platform.=0A=
> =0A=
> As you propose on your cover letter it is better to set it at board=0A=
> level.=0A=
> =0A=
> So instead of this patch you should update the binding documentation=0A=
> with this new resources. Thanks to this each board developer will be=0A=
> able to decide to use this feature or not.=0A=
=0A=
Agreed. I'll drop this patch in favor of a documentation update in v2.=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Gregory=0A=
> =0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>>   arch/arm/boot/dts/armada-38x.dtsi | 1 +=0A=
>>   1 file changed, 1 insertion(+)=0A=
>>=0A=
>> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armad=
a-38x.dtsi=0A=
>> index 7ff0811e61db..9ac76c54c9e5 100644=0A=
>> --- a/arch/arm/boot/dts/armada-38x.dtsi=0A=
>> +++ b/arch/arm/boot/dts/armada-38x.dtsi=0A=
>> @@ -408,6 +408,7 @@=0A=
>>   				reg =3D <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;=0A=
>>   				clocks =3D <&coreclk 2>, <&refclk>;=0A=
>>   				clock-names =3D "nbclk", "fixed";=0A=
>> +				interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;=0A=
>>   			};=0A=
>>   =0A=
>>   			cpurst: cpurst@20800 {=0A=
>> -- =0A=
>> 2.14.2=0A=
>>=0A=
> =0A=
=0A=
