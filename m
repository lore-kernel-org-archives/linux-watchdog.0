Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45452 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbCVRGV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 22 Mar 2015 13:06:21 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YZjKO-000Jhb-Cg
	for linux-watchdog@vger.kernel.org; Sun, 22 Mar 2015 17:06:20 +0000
Message-ID: <550EF67C.7050601@roeck-us.net>
Date: Sun, 22 Mar 2015 10:06:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: James Hogan <james.hogan@imgtec.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
CC: James Hogan <james@albanarts.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: Re: [PATCH 0/2] watchdog: imgpdc: Runtime fixes
References: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com> <20150320205315.GB22574@jhogan-linux.le.imgtec.org>
In-Reply-To: <20150320205315.GB22574@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/20/2015 01:53 PM, James Hogan wrote:
> Hi,
>
> On Fri, Feb 20, 2015 at 11:45:43PM +0000, James Hogan wrote:
>> A couple of basic runtime fixes for the IMG PDC watchdog driver. These
>> were found by attempting to enable the driver for TZ1090 and running
>> under Meta QEMU. Note that QEMU doesn't emulate the actual watchdog
>> functionality beyond the soft reset register, so I cannot claim to have
>> tested the driver's watchdog timer functionality yet.
>>
>> James Hogan (2):
>>    watchdog: imgpdc: Fix probe NULL pointer dereference
>>    watchdog: imgpdc: Fix default heartbeat
>
> Thanks Guenter for the reviews.
>
> Any chance of these fixes getting merged in time for v4.0?
>

I agree that would be good. There is also 'watchdog: mtk_wdt:
signedness bug in mtk_wdt_start()' which should be in 4.0 as well.

Wim, if you are busy, want me to prepare and send a pull request to Linus ?

Thanks,
Guenter

