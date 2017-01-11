Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:38274 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936888AbdAKOnc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jan 2017 09:43:32 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed functions
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
        <1484100561-17638-1-git-send-email-linux@roeck-us.net>
        <1484100561-17638-5-git-send-email-linux@roeck-us.net>
        <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
        <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
        <a45ed205-7c1b-a298-50c0-fc8b80a846c5@sigmadesigns.com>
        <a61eb838-4167-3032-bde8-3a8845b780f8@roeck-us.net>
Date: Wed, 11 Jan 2017 14:43:27 +0000
In-Reply-To: <a61eb838-4167-3032-bde8-3a8845b780f8@roeck-us.net> (Guenter
        Roeck's message of "Wed, 11 Jan 2017 06:25:35 -0800")
Message-ID: <yw1x60llmzcg.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 01/11/2017 04:31 AM, Marc Gonzalez wrote:
>> On 11/01/2017 11:52, Guenter Roeck wrote:
>>
>>> On 01/11/2017 01:07 AM, Marc Gonzalez wrote:
>>>
>>>>> @@ -134,12 +134,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>>>>>  	err = clk_prepare_enable(dev->clk);
>>>>>  	if (err)
>>>>>  		return err;
>>>>> +	err = devm_add_action_or_reset(&pdev->dev,
>>>>> +				       (void(*)(void *))clk_disable_unprepare,
>>>>> +				       dev->clk);
>>>>> +	if (err)
>>>>> +		return err;
>>>>
>>>> Hello Guenter,
>>>>
>>>> I would rather avoid the function pointer cast.
>>>> How about defining an auxiliary function for the cleanup action?
>>>>
>>>> clk_disable_unprepare() is static inline, so gcc will have to
>>>> define an auxiliary function either way. What do you think?
>>>
>>> Not really. It would just make it more complicated to replace the
>>> call with devm_clk_prepare_enable(), should it ever find its way
>>> into the light of day.
>>
>> More complicated, because the cleanup function will have to be deleted later?
>> The compiler will warn if someone forgets to do that.
>>
>> In my opinion, it's not a good idea to rely on the fact that casting
>> void(*)(struct clk *clk) to void(*)(void *) is likely to work as expected
>> on most platforms. (It has undefined behavior, strictly speaking.)
>>
> I do hear that you object to this code.
>
> However, I must admit that you completely lost me here. It is a cast from
> one function pointer to another, passed as argument to another function,
> with a secondary cast of its argument from a typed pointer to a void pointer.
> I don't think C permits for "undefined behavior, strictly speaking".
> Besides, that same mechanism is already used elsewhere, which is how I
> got the idea. Are you claiming that there are situations where it won't
> work ?

A pointer to void is interchangeable with any other pointer type.  That
doesn't necessarily imply that pointers to functions taking arguments of
different pointer types (as we have here) are always compatible.  I'd
have to read the C standard carefully to see if there's any such
promise, and I have other things to do right now.  I am, however, not
aware of any ABI (certainly none used by Linux) where it would pose a
problem.

-- 
Måns Rullgård
