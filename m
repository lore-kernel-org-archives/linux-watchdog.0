Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:55278 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751089AbdGGTB7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 15:01:59 -0400
Subject: Re: [PATCH v7 05/16] watchdog: lantiq: add device tree binding
 documentation
To: Rob Herring <robh@kernel.org>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-6-hauke@hauke-m.de>
 <20170707140834.nugjw5jxkyzwrmzq@rob-hp-laptop>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <704b3b8b-3f33-3d51-82d7-a9515fc39742@hauke-m.de>
Date: Fri, 7 Jul 2017 21:01:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170707140834.nugjw5jxkyzwrmzq@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 07/07/2017 04:08 PM, Rob Herring wrote:
> On Mon, Jul 03, 2017 at 12:40:40AM +0200, Hauke Mehrtens wrote:
>> The binding was not documented before, add the documentation now.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 24 ++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>> new file mode 100644
>> index 000000000000..c3967feebb6c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>> @@ -0,0 +1,24 @@
>> +Lantiq WTD watchdog binding
>> +============================
>> +
>> +This describes the binding of the Lantiq watchdog driver.
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties:
>> +- compatible		: Should be one of
>> +				"lantiq,wdt"
>> +				"lantiq,xrx100-wdt"
>> +				"lantiq,xrx200-wdt"
>> +				"lantiq,falcon-wdt"
>> +- lantiq,rcu		: A phandle to the RCU syscon (required for
>> +			  "lantiq,falcon-wdt", "lantiq,xrx200-wdt" and
>> +			  "lantiq,xrx100-wdt")
>> +
>> +-------------------------------------------------------------------------------
>> +Example for the watchdog on the xRX200 SoCs:
>> +		watchdog@803f0 {
>> +			compatible = "lantiq,xrx200-wdt", "lantiq,xrx100-wdt";
> 
> This is still mismatched. If the example is correct, then the compatible 
> list should be:
> 
> "lantiq,wdt"
> "lantiq,xrx100-wdt"
> "lantiq,xrx200-wdt", "lantiq,xrx100-wdt"
> "lantiq,falcon-wdt"
> 
> You can also remove "lantiq,xrx200-wdt" from the driver if you want as 
> "lantiq,xrx100-wdt" is good enough to match on.
> 
> Rob
> 
Ok thank you.

All the features that are supported by the wtd drivers use the same
register offsets on the xrx100 and xrx200 SoCs. I added the xrx200 only
if in the future we find some mismatch and I want to be able to use some
other code for this SoC.
In this case I would then list complete compatible line which should be
used for this SoC in the description of the compatible line, is that
correct?

I will update the patch, this makes sense to me.

Hauke
