Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:41682 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdALLYI (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Jan 2017 06:24:08 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
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
        <f7d9227c-4912-5c52-5ba7-ae7fa3b89857@sigmadesigns.com>
        <20170111175110.GB22289@roeck-us.net>
        <0f68aa11-161b-0435-ea0f-851432464bc1@sigmadesigns.com>
Date: Thu, 12 Jan 2017 11:24:03 +0000
In-Reply-To: <0f68aa11-161b-0435-ea0f-851432464bc1@sigmadesigns.com> (Marc
        Gonzalez's message of "Thu, 12 Jan 2017 10:44:07 +0100")
Message-ID: <yw1xlgugldws.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

>> So far we have a claim that a cast to a void * may somehow be different
>> to a cast to a different pointer, if used as function argument, and that
>> the behavior with such a cast may be undefined. In other words, you claim
>> that a function implemented as, say,
>> 
>>    void func(int *var) {}
>> 
>> might result in undefined behavior if some header file declares it as
>> 
>>     void func(void *);
>> 
>> and it is called as
>> 
>>     int var;
>> 
>>     func(&var);
>> 
>> That seems really far fetched to me.
>
> Thanks for giving me an opportunity to play the language lawyer :-)
>
> C99 6.3.2.3 sub-clause 8 states:
>
> "A pointer to a function of one type may be converted to a pointer to
> a function of another type and back again; the result shall compare
> equal to the original pointer. If a converted pointer is used to call
> a function whose type is not compatible with the pointed-to type, the
> behavior is undefined."
>
> So, the behavior is undefined, not when you cast clk_disable_unprepare,
> but when clk_disable_unprepare is later called through the devres->action
> function pointer.

Only if the function types are incompatible.  C99 6.7.5.3 subclause 15:

  For two function types to be compatible, both shall specify compatible
  return types.  Moreover, the parameter type lists, if both are
  present, shall agree in the number of parameters and in use of the
  ellipsis terminator; corresponding parameters shall have compatible
  types.

The question then is whether pointer to void and pointer to struct clk
are compatible types.  6.7.5.1 subclause 2:

  For two pointer types to be compatible, both shall be identically
  qualified and both shall be pointers to compatible types.

6.2.5 subclause 27:

  A pointer to void shall have the same representation and alignment
  requirements as a pointer to a character type. 39)

  39) The same representation and alignment requirements are meant to
      imply interchangeability as arguments to functions, return values
      from functions, and members of unions.

6.3.2.3 subclause 1:

  A pointer to void may be converted to or from a pointer to any
  incomplete or object type.

>From what I can tell, the standard stops just short of declaring pointer
to void compatible with other pointer types.

> However, I agree that it will work as expected on typical platforms
> (where all pointers are the same size, and the calling convention
> treats all pointers the same).

Yes, I don't see how it could possibly go wrong.

-- 
Måns Rullgård
