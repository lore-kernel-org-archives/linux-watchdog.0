Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52424 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcA2AZC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 28 Jan 2016 19:25:02 -0500
Subject: Re: [PATCH v6] Add sun4v_wdt watchdog driver
To: Wim Coekaerts <wim.coekaerts@oracle.com>,
	Julian Calaby <julian.calaby@gmail.com>
References: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com>
 <CAGRGNgWKzomgV2199r_Ym-DbGpeHz5dLwcWkC5-Lz+pftqBF9g@mail.gmail.com>
 <56AA9BDF.6070907@oracle.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	sparclinux <sparclinux@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56AAB157.3070809@roeck-us.net>
Date: Thu, 28 Jan 2016 16:24:55 -0800
MIME-Version: 1.0
In-Reply-To: <56AA9BDF.6070907@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/28/2016 02:53 PM, Wim Coekaerts wrote:
> On 01/28/2016 02:50 PM, Julian Calaby wrote:
>> Hi Wim,
>>
>> Sorry to keep iterating on this, but I noticed two small things you
>> could improve:
>
> yeah I was considering that although it makes the code a bit more readable but
> fine happy to tweak that. no problem.
>
> the static is definitely no longer needed after all the cleanup that happened.
>

It would be great if you can drop the static. I'll leave the other one for you
to decide; I was 50/50 on it myself. I don't have any further comments (assuming
you ran the patch through checkpatch).

Thanks,
Guenter

