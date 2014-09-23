Return-path: <j.uzycki@elproma.com.pl>
Message-ID: <54216272.5000404@elproma.com.pl>
Date: Tue, 23 Sep 2014 14:07:14 +0200
From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog's pm support preffered implementation
References: <54088996.4040500@elproma.com.pl> <540C9383.9050307@roeck-us.net> <540D02E1.90403@elproma.com.pl> <540D1F8F.2080802@roeck-us.net> <54196BE2.2010800@elproma.com.pl> <541ABD07.5090407@elproma.com.pl> <541B5156.803@elproma.com.pl> <541B5684.7000809@elproma.com.pl> <541B9EF7.4030702@roeck-us.net> <541BFB63.3060006@elproma.com.pl> <20140919162115.GE30723@roeck-us.net>
In-Reply-To: <20140919162115.GE30723@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>


W dniu 2014-09-19 18:21, Guenter Roeck pisze:
> On Fri, Sep 19, 2014 at 11:46:11AM +0200, Janusz Użycki wrote:
>> W dniu 2014-09-19 05:11, Guenter Roeck pisze:
>>>>> +
>>>>> +       /* Is keep-on/ping timer suspended before?
>>>>> +        * or additional driver-specific flag must be added
>>>>> +        *  to block watchdog ping in the timer?
>>>>> +        * or disable WATCHDOG_KEEP_ON before wdt_stop
>>>>> +        *  and restore it in resume? */
>>> You'll have to answer those questions.
>> I guess you don't know if timers are stopped before susnder of other
>> drivers?
>>
> My development methology is on a "need to know" basis. No, I don't know,
> since I never needed to. If I am in a situation like this I look at other
> drivers and how they solved the problem.

My methodology is also "need to know" but there was possibility that 
somebody knows an answer.
Other watchdog drivers hadn't such situation. Ping timer was always used 
for hardware which never stops.
I analized and found simple solution: suspend/resume helper.
You can find it in patches I sent yesterday. Please about comments.
Do you happen to work how to use the ping timer instead of timer in 
device-specific driver? I can't it on the moment.

> On a side note, I would never assume that there is a race condition unless
> I can prove that there is one.
>

I am careful here:
https://www.kernel.org/doc/Documentation/stable_kernel_rules.txt
"No theoretical race condition issues"

>>>>> +               return wdt_stop(wdd);
>>>>> +       }
>>>>> +       /* should we use pm_runtime like omap_wdt.c does? */
>>> Isn't that what you do here ?
>> I meant pm_runtime_put/get_sync() etc.
>> Maybe it is connected to my question above about timers.
>>
> Another need-to-know question.
> Best would be to check how other drivers use the functions.

I learnt: pm_runtime is rather extention to classic resume/suspend.

>
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>> +static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
>>> Does the __maybe_unused really apply ?
>> What do you preffer: __maybe_unused or ifdef CONFIG_PM_SLEEP?
>> I guess the first one because SIMPLE_DEV_PM_OPS/SET_SYSTEM_SLEEP_PM_OPS
>> just uses CONFIG_PM_SLEEP.
>>
> None of the above ;-). Keep the __maybe_unused; at least that means
> that the code is compiled even if CONFIG_PM_SLEEP is undefined.
sure

Janusz
