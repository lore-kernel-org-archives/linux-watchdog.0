Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46194 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdJKEbE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Oct 2017 00:31:04 -0400
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>,
        "wim@iguana.be" <wim@iguana.be>,
        "gregory.clement@free-electrons.com"
        <gregory.clement@free-electrons.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] watchdog: orion: don't enable rstout if an interrupt
 is configured
Date: Wed, 11 Oct 2017 04:30:50 +0000
Message-ID: <4f82b24c3b244d3eba0f8de8cb25049f@svr-chch-ex1.atlnz.lc>
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
 <20171011022958.31268-3-chris.packham@alliedtelesis.co.nz>
 <227eed69-c4c8-01a1-3c6b-6cf95e84a9cd@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/10/17 16:42, Guenter Roeck wrote:=0A=
> On 10/10/2017 07:29 PM, Chris Packham wrote:=0A=
>> The orion_wdt_irq invokes panic() so we are going to reset the CPU=0A=
>> regardless.  By not setting this bit we get a chance to gather debug=0A=
>> from the panic output before the system is reset.=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> =0A=
> Unless I am missing something, this assumes that the interrupt is=0A=
> handled, ie that the system is not stuck with interrupts disabled.=0A=
> This makes the watchdog less reliable. This added verbosity comes=0A=
> at a significant cost. I'd like to get input from others if this=0A=
> is acceptable.=0A=
> =0A=
> That would be different if there was a means to configure a pretimeout,=
=0A=
> ie a means to tell the system to generate an irq first, followed by a=0A=
> hard reset if the interrupt is not served. that does not seem to be=0A=
> the case here, though.=0A=
> =0A=
=0A=
As far as I can tell there is no pretimeout capability in the orion =0A=
/armada WDT. I have got a work-in-progress patch that enables the RSTOUT =
=0A=
in the interrupt handler which some-what mitigates your concern but =0A=
still requires the interrupt to be handled at least once.=0A=
=0A=
Another option would be to use one of the spare global timers to provide =
=0A=
the interrupt-driven aspect.=0A=
=0A=
Of course if the irq isn't specified then the existing behaviour is =0A=
retained which would make the 3/3 patch of this series the debatable part.=
=0A=
=0A=
=0A=
> Guenter=0A=
> =0A=
>> ---=0A=
>>    drivers/watchdog/orion_wdt.c | 25 +++++++++++++++++--------=0A=
>>    1 file changed, 17 insertions(+), 8 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c=
=0A=
>> index ea676d233e1e..ce88f339ef7f 100644=0A=
>> --- a/drivers/watchdog/orion_wdt.c=0A=
>> +++ b/drivers/watchdog/orion_wdt.c=0A=
>> @@ -71,6 +71,7 @@ struct orion_watchdog {=0A=
>>    	unsigned long clk_rate;=0A=
>>    	struct clk *clk;=0A=
>>    	const struct orion_watchdog_data *data;=0A=
>> +	int irq;=0A=
>>    };=0A=
>>    =0A=
>>    static int orion_wdt_clock_init(struct platform_device *pdev,=0A=
>> @@ -203,9 +204,11 @@ static int armada375_start(struct watchdog_device *=
wdt_dev)=0A=
>>    						dev->data->wdt_enable_bit);=0A=
>>    =0A=
>>    	/* Enable reset on watchdog */=0A=
>> -	reg =3D readl(dev->rstout);=0A=
>> -	reg |=3D dev->data->rstout_enable_bit;=0A=
>> -	writel(reg, dev->rstout);=0A=
>> +	if (!dev->irq) {=0A=
>> +		reg =3D readl(dev->rstout);=0A=
>> +		reg |=3D dev->data->rstout_enable_bit;=0A=
>> +		writel(reg, dev->rstout);=0A=
>> +	}=0A=
>>    =0A=
>>    	atomic_io_modify(dev->rstout_mask, dev->data->rstout_mask_bit, 0);=
=0A=
>>    	return 0;=0A=
>> @@ -228,9 +231,12 @@ static int armada370_start(struct watchdog_device *=
wdt_dev)=0A=
>>    						dev->data->wdt_enable_bit);=0A=
>>    =0A=
>>    	/* Enable reset on watchdog */=0A=
>> -	reg =3D readl(dev->rstout);=0A=
>> -	reg |=3D dev->data->rstout_enable_bit;=0A=
>> -	writel(reg, dev->rstout);=0A=
>> +	if (!dev->irq) {=0A=
>> +		reg =3D readl(dev->rstout);=0A=
>> +		reg |=3D dev->data->rstout_enable_bit;=0A=
>> +		writel(reg, dev->rstout);=0A=
>> +	}=0A=
>> +=0A=
>>    	return 0;=0A=
>>    }=0A=
>>    =0A=
>> @@ -247,8 +253,9 @@ static int orion_start(struct watchdog_device *wdt_d=
ev)=0A=
>>    						dev->data->wdt_enable_bit);=0A=
>>    =0A=
>>    	/* Enable reset on watchdog */=0A=
>> -	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,=0A=
>> -				      dev->data->rstout_enable_bit);=0A=
>> +	if (!dev->irq)=0A=
>> +		atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,=0A=
>> +					      dev->data->rstout_enable_bit);=0A=
>>    =0A=
>>    	return 0;=0A=
>>    }=0A=
>> @@ -595,6 +602,8 @@ static int orion_wdt_probe(struct platform_device *p=
dev)=0A=
>>    			dev_err(&pdev->dev, "failed to request IRQ\n");=0A=
>>    			goto disable_clk;=0A=
>>    		}=0A=
>> +=0A=
>> +		dev->irq =3D irq;=0A=
>>    	}=0A=
>>    =0A=
>>    	watchdog_set_nowayout(&dev->wdt, nowayout);=0A=
>>=0A=
> =0A=
> =0A=
=0A=
