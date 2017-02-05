Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42316 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdBEE3e (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Feb 2017 23:29:34 -0500
Subject: Re: [PATCH v9 2/3] MAINTAINERS: add zx2967 watchdog controller driver
 to ARM ZTE architecture
To: Shawn Guo <shawnguo@kernel.org>, Baoyou Xie <baoyou.xie@linaro.org>
References: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
 <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org>
 <4cba1be6-ee85-7371-ea02-1bf8e7eb628e@roeck-us.net>
 <CA+DQWkyOZPQORy-rVSqGY8Ht9xWttYt6Csp6pvShGG4OVA_2YQ@mail.gmail.com>
 <20170205034504.GD3407@dragon>
Cc: Jun Nie <jun.nie@linaro.org>, wim@iguana.be,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn,
        wang.qiang01@zte.com.cn
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e8573429-8082-abc2-be23-4605172cedf1@roeck-us.net>
Date: Sat, 4 Feb 2017 20:29:27 -0800
MIME-Version: 1.0
In-Reply-To: <20170205034504.GD3407@dragon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/04/2017 07:45 PM, Shawn Guo wrote:
> Hi Baoyou,
>
> On Sun, Feb 05, 2017 at 10:36:38AM +0800, Baoyou Xie wrote:
>> On 5 February 2017 at 08:05, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>> On 02/03/2017 05:34 PM, Baoyou Xie wrote:
>>>
>>>> Add the zx2967 watchdog controller driver as maintained by ARM ZTE
>>>> architecture maintainers, as they're parts of the core IP.
>>>>
>>>> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
>>>>
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> I assume you'll submit this patch through the arm tree ?
>>>
>> Could you please submit all three patches through your tree? Thanks a lot
>> :)
>
> Patch #2 is the only one that Guenter is concerned about, as there are
> other subsystem related updates on the file.  I think Guenter's
> suggestion is good, i.e. we have patch #1 and #3 go upstream through
> watchdog tree, and later we update MAINTAINERS as needed via arm-soc
> tree.
>

Yes. One of the problems is that the patch doesn't apply to my tree
(which is based on v4.10-rc3), and it doesn't have a common anchestor,
meaning it is most likely not based on mainline. I would prefer to avoid
conflicts with the arm tree if possible.

Guenter


