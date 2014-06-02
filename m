Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:16301
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754521AbaFBN3S (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Jun 2014 09:29:18 -0400
Date: Mon, 2 Jun 2014 15:28:49 +0200
From: Michal Simek <michal.simek@xilinx.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
	Michal Simek <monstr@monstr.eu>
CC: Harini Katakam <harinik@xilinx.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"rob@landley.net" <rob@landley.net>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] watchdog: Add Cadence WDT driver
References: <1401185895-3677-1-git-send-email-harinik@xilinx.com>
 <20140529092106.GC24233@leverpostej> <53870129.5010505@monstr.eu>
 <20140529131940.GG24233@leverpostej> <538C18CC.6040105@monstr.eu>
 <20140602131704.GE13573@leverpostej>
In-Reply-To: <20140602131704.GE13573@leverpostej>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <a0938c62-2b96-447b-b8fb-a9b936b6ba00@BY2FFO11FD049.protection.gbl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/02/2014 03:17 PM, Mark Rutland wrote:
> On Mon, Jun 02, 2014 at 07:25:16AM +0100, Michal Simek wrote:
>> On 05/29/2014 03:19 PM, Mark Rutland wrote:
>>> On Thu, May 29, 2014 at 10:43:05AM +0100, Michal Simek wrote:
>>>> Hi Mark,
>>>>
>>>>>> +static struct of_device_id cdns_wdt_of_match[] = {
>>>>>> +       { .compatible = "xlnx,zynq-wdt-r1p2", },
>>>>>> +       { .compatible = "cdns,wdt-r1p2", },
>>>>>
>>>>> If these can currently be handled identically, why not just have
>>>>> "cdns,wdt-r1p2" in the driver and in your dts have:
>>>>>
>>>>> compatible = "xlnx,zynq-wdt-r1p2", "cdns,wdt-r1p2";
>>>>>
>>>>> If we need to distinguish the two for some reason later we can always
>>>>> add the "xlnx,zynq-wdt-r1p2" string to the driver.
>>>>
>>>> I would prefer to have 2 compatible strings just because
>>>> of that we don't know what is different compare to origin cadence
>>>> version. We have done the same for spi-cadence.c that's why
>>>> it shouldn't be any problem to keep it as is.
>>>> Having zynq compatible property here and using it give us option
>>>> that if another SoC vendor come with new configuration or clean
>>>> cadence one we can simple handle it without changing compatible
>>>> property for us.
>>>
>>> Sure, we can have two documented strings. But as I mention for the
>>> moment the driver only needs to support the one string so long as a
>>> given dts has both. Then we can later distinguish the zynq variant (or
>>> any other) as necessary.
>>
>> ok then. Let's use just "xlnx,zynq-wdt-r1p2" compatible string here
>> and remove "cdns,wdt-r1p2"
> 
> That if anything seems backwards -- the driver should jsut take the most
> general string for now: "cdns,wdt-r1p2", while the dtb will have both:
> 
> compatible = "xlnx,zynq-wdt-r1p2", "cdns,wdt-r1p2";
> 
> The driver can later disintguish "xlnx,zynq-wdt-r1p2" specially if
> necessary.

ah. Ok I see your point now. No problem to do it in this way.

Thanks,
Michal



