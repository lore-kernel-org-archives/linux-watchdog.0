Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway24.websitewelcome.com ([192.185.51.110]:31266 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751020AbeC0VhY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Mar 2018 17:37:24 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 1AD7584D71
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Mar 2018 16:14:26 -0500 (CDT)
Subject: Re: [PATCH] watchdog: wafer5823wdt: Mark expected switch fall-through
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180327193349.GA2547@embeddedgus>
 <346fdc4e-321b-33dc-3b6a-a2d3a0617743@roeck-us.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <67d43bcd-adc3-9b54-8ee2-ce438c9791da@embeddedor.com>
Date: Tue, 27 Mar 2018 16:14:24 -0500
MIME-Version: 1.0
In-Reply-To: <346fdc4e-321b-33dc-3b6a-a2d3a0617743@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 03/27/2018 04:05 PM, Guenter Roeck wrote:
> On 03/27/2018 12:33 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that in this particular case I replaced "Fall" with a proper
>> "Fall through" comment, which is what GCC is expecting to find.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 

Thanks, Guenter.
--
Gustavo
