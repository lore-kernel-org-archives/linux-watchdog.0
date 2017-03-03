Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37974 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdCCPD5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Mar 2017 10:03:57 -0500
Subject: Re: [PATCH 3/4] watchodg: sama5d4: simplify probe
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
 <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
 <20170303090325.41b9ce64@free-electrons.com>
 <20170303092958.2phrxelq3xqojns7@piout.net>
Cc: linux-watchdog@vger.kernel.org, Wenyou.Yang@microchip.com,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7abe4456-6c10-55bf-ead4-7379f23e7f6e@roeck-us.net>
Date: Fri, 3 Mar 2017 06:14:06 -0800
MIME-Version: 1.0
In-Reply-To: <20170303092958.2phrxelq3xqojns7@piout.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/03/2017 01:29 AM, Alexandre Belloni wrote:
> On 03/03/2017 at 09:03:25 +0100, Thomas Petazzoni wrote:
>> On Thu,  2 Mar 2017 18:31:13 +0100, Alexandre Belloni wrote:
>>
>>> +	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
>>
>> Any reason to use irq_of_parse_and_map() over the more conventional
>> platform_get_irq() ?
>>
>
> No particular reason but I'm just removing the if (pdev->dev.of_node)
>
A function call change would (should) be a separate patch.

Guenter

