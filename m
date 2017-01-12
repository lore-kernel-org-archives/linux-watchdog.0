Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.16]:43636 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751157AbdALMRQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Jan 2017 07:17:16 -0500
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed
 functions
To: Mans Rullgard <mans@mansr.com>
CC: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
 <a45ed205-7c1b-a298-50c0-fc8b80a846c5@sigmadesigns.com>
 <a61eb838-4167-3032-bde8-3a8845b780f8@roeck-us.net>
 <f7d9227c-4912-5c52-5ba7-ae7fa3b89857@sigmadesigns.com>
 <20170111175110.GB22289@roeck-us.net>
 <0f68aa11-161b-0435-ea0f-851432464bc1@sigmadesigns.com>
 <yw1xlgugldws.fsf@unicorn.mansr.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <0f8550e9-3f1c-6240-5c2f-c776bd238d0b@sigmadesigns.com>
Date: Thu, 12 Jan 2017 13:15:42 +0100
MIME-Version: 1.0
In-Reply-To: <yw1xlgugldws.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Language: 
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/01/2017 12:24, Måns Rullgård wrote:

> Marc Gonzalez writes:
> 
>>> So far we have a claim that a cast to a void * may somehow be different
>>> to a cast to a different pointer, if used as function argument, and that
>>> the behavior with such a cast may be undefined. In other words, you claim
>>> that a function implemented as, say,
>>>
>>>    void func(int *var) {}
>>>
>>> might result in undefined behavior if some header file declares it as
>>>
>>>     void func(void *);
>>>
>>> and it is called as
>>>
>>>     int var;
>>>
>>>     func(&var);
>>>
>>> That seems really far fetched to me.
>>
>> Thanks for giving me an opportunity to play the language lawyer :-)
>>
>> C99 6.3.2.3 sub-clause 8 states:
>>
>> "A pointer to a function of one type may be converted to a pointer to
>> a function of another type and back again; the result shall compare
>> equal to the original pointer. If a converted pointer is used to call
>> a function whose type is not compatible with the pointed-to type, the
>> behavior is undefined."
>>
>> So, the behavior is undefined, not when you cast clk_disable_unprepare,
>> but when clk_disable_unprepare is later called through the devres->action
>> function pointer.
> 
> Only if the function types are incompatible.  C99 6.7.5.3 subclause 15:
> 
>   For two function types to be compatible, both shall specify compatible
>   return types.  Moreover, the parameter type lists, if both are
>   present, shall agree in the number of parameters and in use of the
>   ellipsis terminator; corresponding parameters shall have compatible
>   types.
> 
> The question then is whether pointer to void and pointer to struct clk
> are compatible types.

6.2.7 Compatible type and composite type
sub-clause 1

"Two types have compatible type if their types are the same. Additional rules for
determining whether two types are compatible are described in 6.7.2 for type specifiers,
in 6.7.3 for type qualifiers, and in 6.7.5 for declarators."

6.7.5.1 Pointer declarators
sub-clause 2

"For two pointer types to be compatible, both shall be identically qualified and both shall
be pointers to compatible types."

I don't think void and struct clk are compatible types.
AFAIU, conversion and compatibility are two separate subjects.

Regards.

