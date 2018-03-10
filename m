Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34092 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeCJFEg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 10 Mar 2018 00:04:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so5924442wmd.1
        for <linux-watchdog@vger.kernel.org>; Fri, 09 Mar 2018 21:04:35 -0800 (PST)
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id e12sm1499610edi.29.2018.03.09.21.04.33
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 21:04:33 -0800 (PST)
Received: by mail-wm0-f53.google.com with SMTP id s206so5934874wme.0
        for <linux-watchdog@vger.kernel.org>; Fri, 09 Mar 2018 21:04:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e5e1ce47-bf53-70ef-35d3-bab0996fb66d@roeck-us.net>
References: <20180310024431.160195-1-briannorris@chromium.org>
 <03a9d600-af54-ee43-1141-082278ebf672@roeck-us.net> <20180310032846.GA180802@rodete-desktop-imager.corp.google.com>
 <e5e1ce47-bf53-70ef-35d3-bab0996fb66d@roeck-us.net>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 9 Mar 2018 21:04:32 -0800
Message-ID: <CA+ASDXPkwVDmArP2GGe8P0eOxohRwHUVPRxE9GNoxvrMrinbTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: dw: RMW the control register
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 9, 2018 at 8:02 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 03/09/2018 07:28 PM, Brian Norris wrote:
>> I guess I could mention it. I was assuming that was an intended behavior
>> of the existing driver: that we set resp_mode=0 (via clobber), so we
>> always get a system reset (we don't try to handle any interrupt in this
>> driver).
>>
> I don't think it was intended behavior. We don't even know for sure (or at
> least
> I don't know) if all implementations of this IP have the same configuration
> bit
> layout. All we can do is hope for the best.

Huh, OK. I did try to look for any sort of generic DesignWare register
documentation, and I couldn't find one easily (even with a proper
Synopsys account -- maybe I wasn't looking in the right place). But
besides the Rockchip TRMs, I did find some openly accessible Altera
SoCFPGA docs [1] which also use this, and they have a few things to
add:
(1) they have the same 'reset pulse length' field, except it's labeled RO
(2) they have the same 'response mode' field
(3) the docs for the entire register say:

"The value of a reserved bit must be maintained in software. When you
modify registers containing reserved bit fields, you must use a
read-modify-write operation to preserve state and prevent
indeterminate system behavior."

So, that pretty well corroborates my patch. Nice.

> Still, clobbering just 1 bit is better than clobbering 30 bit.

Yeah, that's the idea. Well, as long as it's only the 1 bit I want to clobber ;)

I guess if we really find that any of this becomes more problematic
(and varies enough from IP to IP), then we'll need chip-specific
compatible properties.

Brian

[1] e.g. https://www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/hb/arria-10/a10_5v4.pdf
