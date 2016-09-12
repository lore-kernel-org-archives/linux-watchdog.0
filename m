Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35966 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756905AbcILJtj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Sep 2016 05:49:39 -0400
MIME-Version: 1.0
In-Reply-To: <20160812190123.GB16954@rob-hp-laptop>
References: <1470984421-3494-1-git-send-email-shubhrajyoti.datta@xilinx.com> <20160812190123.GB16954@rob-hp-laptop>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 12 Sep 2016 15:19:38 +0530
Message-ID: <CAKfKVtFYEqz2Be81hBBX3Nb9kRR+4QUpdP5iJs88HoyYoC3-jQ@mail.gmail.com>
Subject: Re: [PATCHv5] watchdog: xilinx: Add clock support
To: Rob Herring <robh@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>, wim@iguana.be
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 13, 2016 at 12:31 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Aug 12, 2016 at 12:17:01PM +0530, Shubhrajyoti Datta wrote:
>> Add support for the clock. Currently we enable
>> at probe and relinquish at remove.
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>> ---
>> v2:
>> fix spaces and error path.
>> v3
>> do not fail existing dts
>> v4:
>> fix the error prints as the clock is optional
>> v5:
>> remove some more prints
>>
>>  .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++
>
> Acked-by: Rob Herring <robh@kernel.org>

If there are no further comments can this be applied.

>
>>  drivers/watchdog/of_xilinx_wdt.c                   | 25 +++++++++++++++=
+++++--
>>  2 files changed, 26 insertions(+), 2 deletions(-)
