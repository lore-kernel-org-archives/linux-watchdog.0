Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:59157 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752184AbcLKLVX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 11 Dec 2016 06:21:23 -0500
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
Date: Sun, 11 Dec 2016 13:21:16 +0200
MIME-Version: 1.0
In-Reply-To: <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/11/2016 12:26 PM, Uwe Kleine-König wrote:
> Hello Vladimir,
> 
> On Sun, Dec 11, 2016 at 12:01:08PM +0200, Vladimir Zapolskiy wrote:
>> On 12/11/2016 11:35 AM, Uwe Kleine-König wrote:
>>> On Sun, Dec 11, 2016 at 03:06:48AM +0200, Vladimir Zapolskiy wrote:
>>>> Power down counter enable/disable bit switch is located in WMCR
>>>> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
>>>> i.MX31 SoCs don't have this register. As a result of writing data to
>>>> the non-existing register on driver probe the SoC hangs up, to fix the
>>>> problem add more OF compatible strings and on this basis get
>>>> information about availability of the WMCR register.
>>>>
>>>> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
>>>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>>>> ---
>>
>> [snip]
>>
>>>>  
>>>>  static const struct of_device_id imx2_wdt_dt_ids[] = {
>>>> -	{ .compatible = "fsl,imx21-wdt", },
>>>> +	{ .compatible = "fsl,imx21-wdt", .data = IMX2_WDT_NO_WMCR },
>>>> +	{ .compatible = "fsl,imx25-wdt",  },
>>>> +	{ .compatible = "fsl,imx27-wdt", .data = IMX2_WDT_NO_WMCR },
>>>> +	{ .compatible = "fsl,imx31-wdt", .data = IMX2_WDT_NO_WMCR },
>>>> +	{ .compatible = "fsl,imx35-wdt",  },
>>>> +	{ .compatible = "fsl,imx50-wdt",  },
>>>> +	{ .compatible = "fsl,imx51-wdt",  },
>>>> +	{ .compatible = "fsl,imx53-wdt",  },
>>>> +	{ .compatible = "fsl,imx6q-wdt",  },
>>>> +	{ .compatible = "fsl,imx6sl-wdt", },
>>>> +	{ .compatible = "fsl,imx6sx-wdt", },
>>>> +	{ .compatible = "fsl,imx6ul-wdt", },
>>>> +	{ .compatible = "fsl,imx7d-wdt",  },
>>>> +	{ .compatible = "fsl,vf610-wdt",  },
>>>
>>> Up to now we only had fsl,imx21-wdt, now it seems that iMX31, i.MX27 and
>>> i.MX21 form a group of equal watchdog IPs and the others form another
>>> group, right?
>>>
>>> So conceptually we should differenciate between
>>>
>>> 	fsl,imx21-wdt (which is used on i.MX21, i.MX27 and i.MX31)
>>> 	fsl,imx35-wdt (which is used on all others)
>>>
>>
>> The problem is that "fsl,imx35-wdt" is not used on all others in the
>> existing DTS, i.e. in the old firmware, which shall be compatible with
>> new changes.
> 
> So old i.MX53 has
> 
> 	compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
> 
> . With the change to the driver it's like using the watchdog driver in
> it's pre-5fe65ce7ccbb4-state on it. If this is bad, we must indeed make
> fsl,imx53-wdt known to the driver. If not, just adding a single new
> compatible to the driver is just fine.

The change under discussion preserves the current runtime behaviour for
i.MX53 and its friends, the watchdog power down counter in WMCR is
disabled on boot (you may want to confirm it by testing though), another
question is if it is wanted for e.g. i.MX53 right from the beginning.

To keep the runtime compatibility of a newer kernel with old DTBs such
a long list of device compatibles has to be inserted.

> 
> If you want to call it imx25 or imx35 doesn't matter much. The reason I
> picked imx35 is that this one was already picked before for cspi. This
> suggests that i.MX35 is older than i.MX25 and so this is the canonical
> choice.

Accepted, from the Wikipedia both i.MX25 and i.MX35 are released in 2009,
which one is the first I don't know for sure, I supposed it could be
i.MX25 as a SoC with a weaker core.

> 
>> $ grep -H 'fsl,imx.*-wdt' arch/arm/boot/dts/*.dtsi
>> arch/arm/boot/dts/imx25.dtsi:				compatible = "fsl,imx25-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx27.dtsi:				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx35.dtsi:				compatible = "fsl,imx35-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx50.dtsi:				compatible = "fsl,imx50-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx51.dtsi:				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx51.dtsi:				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx53.dtsi:				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx53.dtsi:				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx6qdl.dtsi:				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx6qdl.dtsi:				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx6sl.dtsi:				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx6sl.dtsi:				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx6sx.dtsi:				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx6sx.dtsi:				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx6sx.dtsi:				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx6ul.dtsi:				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx6ul.dtsi:				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
>> arch/arm/boot/dts/ls1021a.dtsi:			compatible = "fsl,imx21-wdt";
>> arch/arm/boot/dts/vfxxx.dtsi:				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
>>
>> I don't see a confirmation of the fact that "fsl,imx35-wdt" is the best
>> selection, hence definitely "fsl,imx25-wdt" overscores it.
> 
> I stated my reason to pick imx35 over imx25 above. Why do yo prefer
> imx25?

As you said right now and until it is added into DTS files "fsl,imx25-wdt" and
"fsl,imx35-wdt" are equal as a compatible representation of WMCR-aware watchdogs.

I may be wrong, if I assume that i.MX25 is released before i.MX35 (looks like
they are released in parallel), but "imx25" precedes in alphanumerically sorted
list of SoC names.

>>> A reason to add e.g. fsl,imx6sl-wdt is that dtbs in the wild use
>>>
>>> 	"fsl,imx6sl-wdt", "fsl,imx21-wdt"
>>>
>>> . But then I wonder if 
>>>
>>> 	5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
>>>
>>> is that important to justify to add these all.
>>
>> About this comment I don't know, you may have better insight about the original
>> change. By the way, in barebox you may want to fix the same hang-up, because
>> you touch WMCR unconditionally.
> 
> Sure.
>  
>>> Independant of this I'd like to have all dtsi for the newer SoCs changed
>>> to get
>>>
>>> 	"fsl,imx6sl-wdt", "fsl,imx35-wdt"
>>>
>>> and if you really want to add all these compatibles, add a comment that
>>> these are really fsl,imx35-wdt and were added to work around broken
>>> dtbs.
>>
>> No objections, but
>>
>> 1) I'd like to see "fsl,imx25-wdt" as a new common compatible, and that's
>> what have been proposed and shared in RFC 2/2.
> 
> Yeah, I missed that other patch (which was not part of this series).
> 
>> 2) Please remind me, why do you ask to drop "fsl,imx21-wdt" from the list?
>>
>>      compatible = "fsl,imx6sx-wdt", "fsl,imx25-wdt", "fsl,imx21-wdt";
>>
>> The list of compatibles above is valid (from the most specific on the left
>> to the most generic on the right), and that compatible property is rightly
>> handled in the driver with this change applied. I don't see a need to
>> drop "fsl,imx21-wdt".
> 
> If the wdt in the i.MX6SX can be operated by the watchdog driver in it's
> imx21 mode, you should keep the imx21 entry. If not, you shouldn't.

The DTS description shall be rather independent from any particular software
implementation, someone may want to reuse the same DTB in bootloaders and OS
kernels of different versions. Assuming that I have a bootloader/kernel
with a pure i.MX21 watchdog driver and run it on i.MX6SX, I'd prefer to match
"fsl,imx21-wdt" compatible.

--
With best wishes,
Vladimir
