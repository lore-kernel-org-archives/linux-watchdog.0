Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34364 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbdGEPZr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Jul 2017 11:25:47 -0400
Subject: Re: [PATCH V4 0/3] add UniPhier watchdog support
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        =?UTF-8?B?SGF5YXNoaSwgS3VuaWhpa28v5p6XIOmCpuW9pg==?=
        <hayashi.kunihiko@socionext.com>,
        =?UTF-8?B?T3dhZGEsIEtpeW9zaGkv5aSn5ZKM55SwIOa4heW/lw==?=
        <owada.kiyoshi@socionext.com>
References: <1497426825-25450-1-git-send-email-hayashibara.keiji@socionext.com>
 <000001d2f576$5f011c20$1d035460$@socionext.com>
 <CAK7LNAR7kbXPFGywpnWRCFibwp350kmZ7CpSUO6GTFG3pxG=zw@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8ceaf917-c4fc-23c7-a7f4-5694bd8b4e88@roeck-us.net>
Date: Wed, 5 Jul 2017 08:25:37 -0700
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR7kbXPFGywpnWRCFibwp350kmZ7CpSUO6GTFG3pxG=zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/05/2017 03:26 AM, Masahiro Yamada wrote:
> 2017-07-05 19:06 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
>> Hi Guenter,
>>
>> Let me confirm if I got it.
>>
>> I guess that this series finished the review.
>> Could you tell me the current state of this series?
> 
> 
> I will pick up 3/3.  (It should have been sent to ARM-SoC ML, though.)
> 
> I had sent my PRs for v4.13 before Rob acked the DT binding.
> Please look forward to v4.14.
> 

1/3 and 2/3 are in -next, so they should be be included in Wim's pull request
for 4.13.

Guenter
