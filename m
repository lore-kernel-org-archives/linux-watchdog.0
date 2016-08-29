Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:57262 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcH2Ugk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 Aug 2016 16:36:40 -0400
Subject: Re: [PATCH v4 4/7] watchdog: pretimeout: add panic pretimeout
 governor
To: Wolfram Sang <wsa@the-dreams.de>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1472227681-1405-5-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160829184835.GB1610@katana>
CC: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <e43994d7-e3ea-3531-dcae-3a73450bdffd@mentor.com>
Date: Mon, 29 Aug 2016 22:57:32 +0300
MIME-Version: 1.0
In-Reply-To: <20160829184835.GB1610@katana>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On 08/29/2016 09:48 PM, Wolfram Sang wrote:
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/watchdog.h>
>> +
>> +#include <watchdog_pretimeout.h>
>
> This include must be in "" to compile.
>

Right, building the kernel outside of the source code folder does
not show up this problem unfortunately.

Thank you for the catch.

--
With best wishes,
Vladimir
