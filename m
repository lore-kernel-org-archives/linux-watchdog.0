Return-path: <Marc_Gonzalez@sigmadesigns.com>
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed
 functions
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Mans
 Rullgard <mans@mansr.com>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Mark Rutland <mark.rutland@arm.com>, Uwe Kleine-Konig
	<u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <a45ed205-7c1b-a298-50c0-fc8b80a846c5@sigmadesigns.com>
Date: Wed, 11 Jan 2017 13:31:47 +0100
MIME-Version: 1.0
In-Reply-To: <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Language: 
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 11/01/2017 11:52, Guenter Roeck wrote:

> On 01/11/2017 01:07 AM, Marc Gonzalez wrote:
> 
>>> @@ -134,12 +134,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>>>  	err = clk_prepare_enable(dev->clk);
>>>  	if (err)
>>>  		return err;
>>> +	err = devm_add_action_or_reset(&pdev->dev,
>>> +				       (void(*)(void *))clk_disable_unprepare,
>>> +				       dev->clk);
>>> +	if (err)
>>> +		return err;
>>
>> Hello Guenter,
>>
>> I would rather avoid the function pointer cast.
>> How about defining an auxiliary function for the cleanup action?
>>
>> clk_disable_unprepare() is static inline, so gcc will have to
>> define an auxiliary function either way. What do you think?
> 
> Not really. It would just make it more complicated to replace the
> call with devm_clk_prepare_enable(), should it ever find its way
> into the light of day.

More complicated, because the cleanup function will have to be deleted later?
The compiler will warn if someone forgets to do that.

In my opinion, it's not a good idea to rely on the fact that casting
void(*)(struct clk *clk) to void(*)(void *) is likely to work as expected
on most platforms. (It has undefined behavior, strictly speaking.)

Do you really dislike the portable solution I suggested? :-(

Regards.
