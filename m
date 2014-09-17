Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:58700 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754653AbaIQLJT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Sep 2014 07:09:19 -0400
Message-ID: <54196BE2.2010800@elproma.com.pl>
Date: Wed, 17 Sep 2014 13:09:22 +0200
From: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
References: <S1751381AbaIDOwq/20140904145246Z+988@vger.kernel.org> <54088996.4040500@elproma.com.pl> <540C9383.9050307@roeck-us.net> <540D02E1.90403@elproma.com.pl> <540D1F8F.2080802@roeck-us.net>
In-Reply-To: <540D1F8F.2080802@roeck-us.net>
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter.

W dniu 2014-09-08 05:16, Guenter Roeck pisze:
>
>>>> * I also added wdd->ops->ref/unref calls but I'm afraid that even 
>>>> original code is buggy in watchdog_dev.c. Is any driver that uses 
>>>> the pointers? In my opinion watchdog_open() should call 
>>>> wdd->ops->ref() before watchdog_start() and watchdog_release() 
>>>> should call wdd->ops->unref() before module_put(). Otherwise fault 
>>>> is possible if watchdog module is unloaded.
>>>> * I noticed that current watchdog core does not support 
>>>> suspend/resume case. If you want to use suspend without the patch 
>>>> you need to close a watchdog in userspace using the magic character 
>>>> before suspend command. With the patch you must to use 
>>>> WDIOC_SETOPTIONS ioctl and WDIOS_DISABLECARD/WDIOS_ENABLECARD. Is 
>>>> there any other method to suspend with watchdog?
>> Can kernel suspend a started (stoppable) watchdog? It dissapeared in 
>> 3.x. Now userland reaction seems to be required.
>>
> Really ? I see a number of watchdog drivers implementing it.
>

Three things about always active/running/enabled watchdogs:
- stop returns an error
- pm/suspend/resume are not supported
- if watchdog is running/active keep-on like feature should be enabled
- on register watchdog specific driver should check if watchdog was 
enabled before

Always active/running/enabled is related to watchdog attribute
and seems have direct influence on specific driver code.
Is there "never stop" software option needed for stoppable watchdogs?

Abore are just notes. Now I'm working under keep-on and stmp3xxx driver 
only.

best regards
Janusz
