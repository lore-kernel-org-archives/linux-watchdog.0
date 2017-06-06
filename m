Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46259 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbdFFNrv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Jun 2017 09:47:51 -0400
Subject: Re: [PATCH v6 0/3] watchdog: allow setting deadline for opening
 /dev/watchdogN
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        esben.haabendal@gmail.com, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1496134608-7375-1-git-send-email-rasmus.villemoes@prevas.dk>
 <cf95ffd6-fb29-bebb-ff54-9f6d648160da@prevas.dk>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <39cee81c-c58b-9b81-13ef-782dfc06103b@roeck-us.net>
Date: Tue, 6 Jun 2017 06:47:47 -0700
MIME-Version: 1.0
In-Reply-To: <cf95ffd6-fb29-bebb-ff54-9f6d648160da@prevas.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/06/2017 01:08 AM, Rasmus Villemoes wrote:
> On 2017-05-30 10:56, Rasmus Villemoes wrote:
>>
>> v6 tweaks the wording in watchdog-parameters.txt to avoid having to
>> update it if and when the watchdog core grows new parameters. It also
>> adds a little more rationale to the commit messages for 2/3 and 3/3,
>> and adds Reviewed-bys to 1/3 which is unchanged from v5.
> 
> Ping. Guenther, is there anything I can do on my end to get this in
> before the 4.13 merge window opens? I realize you're busy, but I'd
> really appreciate just a brief response to this and the other emails
> I've sent the past few weeks.
> 
> 

You made a suggestion that this overlaps with another option, which forces me
to go back and check the entire exchange from the start, for which I did not
have time yet, sorry.

Guenter

