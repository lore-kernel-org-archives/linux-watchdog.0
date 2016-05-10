Return-path: <joel.stan@gmail.com>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20160509203831.GA20352@rob-hp-laptop>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
 <1462797277-14969-2-git-send-email-joel@jms.id.au> <20160509203831.GA20352@rob-hp-laptop>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 10 May 2016 20:54:01 +0930
Message-ID: <CACPK8XeAhn=h=-LKjFZJ9UibnXiYLvy5R=1=FsNZJn0Hk1O36Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc/devicetree: Add Aspeed watchdog timer bindings
To: Rob Herring <robh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jeremy Kerr <jk@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, May 10, 2016 at 6:08 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, May 09, 2016 at 10:04:36PM +0930, Joel Stanley wrote:
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> new file mode 100644
>> index 000000000000..58184b161e0d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> @@ -0,0 +1,14 @@
>> +Aspeed Watchdog Timer
>> +
>> +Required properties:
>> + - compatible: must be "aspeed,wdt"
>
> This should have the specific SOCs listed.

Thanks, I'll fix it.

In the cases where the drivers had no change in the IP between
versions of the soc I wondered if it was neater to have a generic
string. You're saying that's wrong and we prefer using multiple
strings for all the SoCs instead?

>> +     wdt1: wdt@1e785000 {
>
> IIRC, "watchdog@..." is the correct generic name.

Cheers,

Joel
