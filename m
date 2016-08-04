Return-path: <michal.simek@xilinx.com>
Subject: Re: [PATCHv2] watchdog: xilinx: Add clock support
To: Guenter Roeck <linux@roeck-us.net>, Shubhrajyoti Datta
	<shubhrajyoti.datta@xilinx.com>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>
References: <1470198518-22286-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <57A21A64.4090509@roeck-us.net>
CC: <soren.brinkmann@xilinx.com>, <shubhrajyoti.datta@gmail.com>,
	<michal.simek@xilinx.com>, <wim@iguana.be>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <bf0f7196-0bdd-581f-ffdd-d5e6c151c55e@xilinx.com>
Date: Thu, 4 Aug 2016 08:43:58 +0200
MIME-Version: 1.0
In-Reply-To: <57A21A64.4090509@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 3.8.2016 18:23, Guenter Roeck wrote:
> On 08/02/2016 09:28 PM, Shubhrajyoti Datta wrote:
>> Add support for the clock. Currently we enable
>> at probe and relinquish at remove.
>>
>> Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Patch itself looks good.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Do you have a separate patch to add the clock to virtex440-ml507.dts ?
> 
> Not that it matters much, I guess - virtex440-ml507.dts says
>         compatible = "xlnx,xps-timebase-wdt-1.00.b";
> which isn't supported by of_xilinx_wdt.c, and not documented in
> of-xilinx-wdt.txt. Is that an oversight or on purpose ?

We had an internal discussion about ppc405 and ppc440 support and truth
is Xilinx is not doing any testing on these cpus and the part of that is
that none is keeping stuff up2date.

I tried to remove xilinx ppc support from U-Boot because I didn't see
activity there but there were people who invested their time to do
necessary changes to keep it alive. I think kernel is just a same case.
I am happy to remove these xilinx ppc4xx dtses from the kernel but I
expect that there will be others who want to have it there.
And this is the group who should keep these dtses up2date and test them
regularly.

Thanks,
Michal
