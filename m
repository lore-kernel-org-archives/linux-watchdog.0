Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41283 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756551AbcILMpk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Sep 2016 08:45:40 -0400
Subject: Re: [PATCHv5] watchdog: xilinx: Add clock support
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Rob Herring <robh@kernel.org>
References: <1470984421-3494-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <20160812190123.GB16954@rob-hp-laptop>
 <CAKfKVtFYEqz2Be81hBBX3Nb9kRR+4QUpdP5iJs88HoyYoC3-jQ@mail.gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>, wim@iguana.be
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <47c40b8c-664e-e2ff-9059-6f566448cf76@roeck-us.net>
Date: Mon, 12 Sep 2016 05:45:36 -0700
MIME-Version: 1.0
In-Reply-To: <CAKfKVtFYEqz2Be81hBBX3Nb9kRR+4QUpdP5iJs88HoyYoC3-jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/12/2016 02:49 AM, Shubhrajyoti Datta wrote:
> On Sat, Aug 13, 2016 at 12:31 AM, Rob Herring <robh@kernel.org> wrote:
>> On Fri, Aug 12, 2016 at 12:17:01PM +0530, Shubhrajyoti Datta wrote:
>>> Add support for the clock. Currently we enable
>>> at probe and relinquish at remove.
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>> Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
>>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>> ---
>>> v2:
>>> fix spaces and error path.
>>> v3
>>> do not fail existing dts
>>> v4:
>>> fix the error prints as the clock is optional
>>> v5:
>>> remove some more prints
>>>
>>>  .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> If there are no further comments can this be applied.

Please be patient. Wim usually sends "applied" e-mails shortly before
the commit window opens, and I'll send him a reminder about pending
patches.

Guenter


