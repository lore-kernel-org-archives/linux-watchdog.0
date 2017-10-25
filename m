Return-Path: <andrew.smirnov@gmail.com>
Return-path: <andrew.smirnov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171024190719.w4wy3omflkugkocg@rob-hp-laptop>
References: <20171018170136.12347-1-andrew.smirnov@gmail.com>
 <20171018170136.12347-6-andrew.smirnov@gmail.com> <20171024190719.w4wy3omflkugkocg@rob-hp-laptop>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 25 Oct 2017 08:00:32 -0700
Message-ID: <CAHQ1cqEHqdhUtPRUQG9KxbaRJXb_ZerhheO9R=eN=uDKpwT24g@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] dt-bindings: watchdog: Add bindings for RAVE SP
 watchdog driver
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lee Jones <lee.jones@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
	Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Oct 24, 2017 at 12:07 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Oct 18, 2017 at 10:01:36AM -0700, Andrey Smirnov wrote:
>
> Commit msg?
>

OK, will add in v9.

>> Cc: linux-kernel@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-watchdog@vger.kernel.org
>> Cc: cphealy@gmail.com
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Johan Hovold <johan@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
>> new file mode 100644
>> index 000000000000..f242c3eed0dc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
>> @@ -0,0 +1,10 @@
>> +Zodiac Inflight Innovations RAVE Supervisory Processor Watchdog
>> +
>> +Required properties:
>> +
>> + - compatible: Should be "zii,rave-sp-watchdog"
>> +
>
> Must be a child of ? defined in ?

Good point, will add.

>
>> +Optional properties:
>> +
>> + - Two byte nvmem cell "wdt_timeout", specified as per
>> +   Documentation/devicetree/bindings/nvmem/nvmem.txt
>
> prop name: definition... is the normal format.
>
> Also, don't use '_' in property names.
>

OK, will fix.

Thanks,
Andrey Smirnov
