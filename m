Return-path: <akshay.bhat@timesys.com>
Subject: Re: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support via
 'ext-reset-output' dt prop
To: Rob Herring <robh+dt@kernel.org>
References: <1446758362-11702-1-git-send-email-akshay.bhat@timesys.com>
 <1446758362-11702-2-git-send-email-akshay.bhat@timesys.com>
 <20151105222325.GA26159@roeck-us.net>
 <CAJ+vNU2fSxRJ7YvxOfNzoEoiKgzv-dHj=+eksKxH48ekHiUw2Q@mail.gmail.com>
 <20151106220249.GA19791@roeck-us.net> <565F4244.7090502@timesys.com>
 <CAJ+vNU00Bf97HUqkkW9KqOUzHXh482R9O1gasz6ju3Pn-_5chA@mail.gmail.com>
 <CAJ+vNU2qHQPSJ1KWp_3f3vAdeuOcF0ooZHmHsdafabZLXJv=Bw@mail.gmail.com>
 <20151228162923.GA31680@spo001.leaseweb.nl>
Cc: Wim Van Sebroeck <wim@iguana.be>, Tim Harvey <tharvey@gateworks.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, justin.waters@timesys.com,
 Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Stefan Roese <sr@denx.de>
From: Akshay Bhat <akshay.bhat@timesys.com>
Message-ID: <56AA79DA.2010305@timesys.com>
Date: Thu, 28 Jan 2016 15:28:10 -0500
MIME-Version: 1.0
In-Reply-To: <20151228162923.GA31680@spo001.leaseweb.nl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Rob,

On 12/28/2015 11:29 AM, Wim Van Sebroeck wrote:
> Hi Tim,
>
>> On Wed, Dec 2, 2015 at 12:54 PM, Tim Harvey <tharvey@gateworks.com> wrote:
>>>
>>> On Wed, Dec 2, 2015 at 11:11 AM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
>>>>
>>>>
>>>> On 11/06/2015 05:02 PM, Guenter Roeck wrote:
>>>>>
>>>>> On Fri, Nov 06, 2015 at 11:53:42AM -0800, Tim Harvey wrote:
>>>>>>
>>>>>> On Thu, Nov 5, 2015 at 2:23 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>>
>>>>>>> On Thu, Nov 05, 2015 at 04:19:21PM -0500, Akshay Bhat wrote:
>>>>>>>>
>>>>>>>> From: Tim Harvey <tharvey@gateworks.com>
>>>>>>>>
>>>>>>>> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
>>>>>>>> can be pinmux'd to an external pin. This is typically used for boards
>>>>>>>> that
>>>>>>>> have PMIC's in control of the IMX6 power rails. In fact, failure to use
>>>>>>>> such an external reset on boards with external PMIC's can result in
>>>>>>>> various
>>>>>>>> hangs due to the IMX6 not being fully reset [1] as well as the board
>>>>>>>> failing
>>>>>>>> to reset because its PMIC has not been reset to provide adequate
>>>>>>>> voltage for
>>>>>>>> the CPU when coming out of reset at 800Mhz.
>>>>>>>>
>>>>>>>> This uses a new device-tree property 'ext-reset-output' to indicate the
>>>>>>>> board has such a reset and to cause the watchdog to be configured to
>>>>>>>> assert
>>>>>>>> WDOG_B instead of an internal reset both on a watchdog timeout and in
>>>>>>>> system_restart.
>>>>>>>>
>>>>>>>> [1]
>>>>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
>>>>>>>>
>>>>>>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>>>>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>>>>>>> ---
>>>>>>>>    .../devicetree/bindings/watchdog/fsl-imx-wdt.txt     |  2 ++
>>>>>>>>    drivers/watchdog/imx2_wdt.c                          | 20
>>>>>>>> ++++++++++++++++++--
>>>>>>>>    2 files changed, 20 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
>>>>>>>> b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
>>>>>>>> index 8dab6fd..9b89b3a 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
>>>>>>>> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
>>>>>>>> @@ -9,6 +9,8 @@ Optional property:
>>>>>>>
>>>>>>>
>>>>>>> properties ?
>>>>>>>
>>>>>>>>    - big-endian: If present the watchdog device's registers are
>>>>>>>> implemented
>>>>>>>>      in big endian mode, otherwise in native mode(same with CPU), for
>>>>>>>> more
>>>>>>>>      detail please see:
>>>>>>>> Documentation/devicetree/bindings/regmap/regmap.txt.
>>>>>>>> +- ext-reset-output: If present the watchdog device is configured to
>>>>>>>> assert its
>>>>>>>
>>>>>>>
>>>>>>> Should that have a vendor prefix ? Also, not sure if "-output"
>>>>>>> has any real value in the property name. "fsl,external-reset", maybe ?
>>>>>>
>>>>>>
>>>>>> Hi Guenter,
>>>>>>
>>>>>> I don't see why a vendor prefix is necessary - its a feature of the
>>>>>> IMX6 watchdog supported by this driver to be able to trigger an
>>>>>> internal chip-level reset and/or an external signal that can be hooked
>>>>>> to additional hardware.
>>>>>>
>>>>> Sounded like vendor specific to me, but then I am not a devicetree
>>>>> maintainer,
>>>>> so I am not an authority on the subject.
>>>>
>>>>
>>>> Devicetree maintainers,
>>>>
>>>> Any thoughts?
>>>>
>>>> Tim,
>>>>
>>>> After looking at all the other watchdog drivers, it does not appear that
>>>> there is any other processor which uses a similar feature. Since imx is the
>>>> only processor that appears to support this feature, it might make sense in
>>>> making this vendor specific. If in the future it is found more processors
>>>> support a similar functionality, it can be revisited and moved out from
>>>> being vendor specific?
>>>>
>>>
>>> I'm certainly no expert on device-tree policy. I understand your
>>> point, but realize that the driver in question is imx2_wdt.c
>>> (compatible = "fsl,imx21-wdt"). This is an IP block inside the silicon
>>> of only Freescale chips, so its not like a future omap chip would be
>>> using this driver - only fsl devices. So why would it need a 'vendor'
>>> property any more than its other properties?
>>>
>>> Regards,
>>>
>>> Tim
>>
>> Wim,
>>
>> Does the lack of response mean overwhelming approval?
>>
>> I haven't heard any valid complaints - what does it take to get this approved?
>>
>> Regards,
>>
>> Tim
>
> I have no objections against the idea and the code itself.
> But as Guenter pointed out: it would be handy to get feedback from the devicetree maintainers on the above discussion.
>
> Kind regards,
> Wim.
>

Any suggestions on whether a vendor specific prefix is necessary?

Thanks,
Akshay
