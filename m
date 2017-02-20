Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41451 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbdBTEqS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 19 Feb 2017 23:46:18 -0500
Subject: Re: [PATCH v2 2/3] watchdog: sama5d4: Fix setting timeout when
 watchdog is disabled
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
 <20170216193053.5546-2-alexandre.belloni@free-electrons.com>
 <968ef53e-c3c4-5322-020a-8382ce367931@roeck-us.net>
 <20170217151625.hv2vn5imx2kyeftt@piout.net>
 <c9f336fd-8761-7999-4ac0-cf68eb6c8ba1@roeck-us.net>
 <20170219235213.qcxfne5yvs3uzwg3@piout.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cc75a19f-0d99-4d26-0789-6cd750983990@roeck-us.net>
Date: Sun, 19 Feb 2017 20:46:13 -0800
MIME-Version: 1.0
In-Reply-To: <20170219235213.qcxfne5yvs3uzwg3@piout.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/19/2017 03:52 PM, Alexandre Belloni wrote:
> On 19/02/2017 at 08:57:35 -0800, Guenter Roeck wrote:
>>>> That means if the watchdog is running, the timeout would not be updated.
>>>> It should be updated no matter if it is running or not.
>>>>
>>>
>>> No, it is enabling the watchdog, then changing WDV and WDD and finally
>>> disabling the watchdog if necessary. So, WDV and WDD are always changed.
>>>
>> You are correct. Sorry for the noise.
>>
>> Seems odd that the watchdog must be _running_ to change the timeout.
>> Usually, if there is a restriction, it is the opposite. I hope this
>> doesn't cause race conditions, where the watchdog fires immediately
>> after being enabled due to a low timeout.
>>
>
> While it is difficult to reproduce, I can confirm it races and sometimes
> reset the SoC without any good reason. It doesn't matter whether it is
> disabled or not
>

Outch :-(.

> I've raised the issue at Atmel last Thursday so I don't have any answer
> yet.
>

Please keep us in the loop.

Thanks,
Guenter


