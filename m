Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38774 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755568AbeFYNPj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 25 Jun 2018 09:15:39 -0400
Subject: Re: [PATCH V4 2/4] watchdog: stm32: add pclk feature for stm32mp1
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic BARRE <ludovic.barre@st.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
 <1529571737-3552-3-git-send-email-ludovic.Barre@st.com>
 <20180621165335.GA4563@roeck-us.net>
 <0bfe0082-2134-2d3b-322f-cd6c193a9974@st.com>
 <3f65a889-f625-9521-ea09-bcf7b5b24927@roeck-us.net>
 <b5f62568-ff2f-4a04-212e-a952bf009c88@st.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d92ec883-09ae-271f-69dd-156df17c3e98@roeck-us.net>
Date: Mon, 25 Jun 2018 06:15:35 -0700
MIME-Version: 1.0
In-Reply-To: <b5f62568-ff2f-4a04-212e-a952bf009c88@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/25/2018 05:52 AM, Alexandre Torgue wrote:
> Hi Guenter,
> 
> 
>>> But you are right I forgot to change stm32f429.dtsi.
>>> If I add a commit for stm32f429.dtsi, it's Ok for you ?
>>>
>>
>> Not really. You are imposing a personal preference on others,
>> and you would make stm32f429.dtsi inconsistent since it doesn't
>> use clock names for anything else.This in turn means that people
>> will have an endless source of irritation since they will need
>> a clock name for this node but not for others.
> 
> Why? This kind of implementation depends on each driver. Isn't ?
> 
> Or do you mean that if iwdg driver uses this implementation (clock name usage) all nodes inside stm32f429.dtsi should follow the same implementation ?
> 
>>
>> You will have to get the arm and DT maintainers to agree on this change.
> 
> As this patch makes easier integration of new platform, I agree with Ludovic proposition.
> 

Please provide a formal Acked-by:.

Guenter
