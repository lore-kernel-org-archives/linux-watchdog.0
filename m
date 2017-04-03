Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38156 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdDCOFs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Apr 2017 10:05:48 -0400
Subject: Re: [PATCH] watchdog: pcwd_usb: fix NULL-deref at probe
To: Johan Hovold <johan@kernel.org>
References: <20170313124945.28923-1-johan@kernel.org>
 <20170313171633.GB16813@roeck-us.net> <20170403083635.GD25742@localhost>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b48feef4-dac7-13a4-a70b-33d7c4614cba@roeck-us.net>
Date: Mon, 3 Apr 2017 07:05:46 -0700
MIME-Version: 1.0
In-Reply-To: <20170403083635.GD25742@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/03/2017 01:36 AM, Johan Hovold wrote:
> On Mon, Mar 13, 2017 at 10:16:33AM -0700, Guenter Roeck wrote:
>> On Mon, Mar 13, 2017 at 01:49:45PM +0100, Johan Hovold wrote:
>>> Make sure to check the number of endpoints to avoid dereferencing a
>>> NULL-pointer should a malicious device lack endpoints.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Cc: stable <stable@vger.kernel.org>
>>> Signed-off-by: Johan Hovold <johan@kernel.org>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Any progress on this one? I noticed you merged it to both the fixes and
> next branches in your staging tree, Guenter (but it does not show up in
> linux-next). Will you be sending it on to Linus?
>

Hi Johan,

my watchdog staging trees are inofficial and not in linux-next.
Wim is working on setting up a new server which will provide the
official staging tree.

I asked Wim to push the pending patches. I'll do it if he asks me.

Thanks,
Guenter

