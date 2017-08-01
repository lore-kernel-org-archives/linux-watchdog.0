Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38365 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdHANoM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 1 Aug 2017 09:44:12 -0400
Subject: Re: [PATCH 1/4] ARM: mediatek: dts: Cleanup bindings documentation
To: Rob Herring <robh@kernel.org>
Cc: wim@iguana.be, linux@roeck-us.net, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20170720102247.12342-1-matthias.bgg@gmail.com>
 <20170724195644.oztdexqhicir5xn3@rob-hp-laptop>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5451bdfa-e2c1-30cb-a5a9-252662b2d190@gmail.com>
Date: Tue, 1 Aug 2017 15:44:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170724195644.oztdexqhicir5xn3@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 07/24/2017 09:56 PM, Rob Herring wrote:
> On Thu, Jul 20, 2017 at 12:22:44PM +0200, Matthias Brugger wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> This patch cleans up the binding documentation stating explicitly
>> the binding and it's fallback for every SoC.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Thanks. Whole series pushed now to v4.13-next/dts64
