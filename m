Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43912 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbKYOVC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 09:21:02 -0500
Subject: Re: [PATCH v3 1/4] watchdog: meson: Enable meson SoC specific data
To: Carlo Caione <carlo@caione.org>
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
 <1446985137-25498-2-git-send-email-carlo@caione.org>
 <5640B5BF.9040909@roeck-us.net>
 <CAOQ7t2bmNNTPxgZy4uZQF_u4yH2nxfMR_FqpKM0GavoUS9rRkA@mail.gmail.com>
 <20151124181911.GA12289@roeck-us.net>
 <CAOQ7t2ZY8BMMSN5F-9GewZSfUewa-0jA5tufe9NCkLZObjrdWg@mail.gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Daniel Drake <drake@endlessm.com>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>,
	Romain Perier <romain.perier@gmail.com>,
	Carlo Caione <carlo@endlessm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5655C3CA.5000407@roeck-us.net>
Date: Wed, 25 Nov 2015 06:20:58 -0800
MIME-Version: 1.0
In-Reply-To: <CAOQ7t2ZY8BMMSN5F-9GewZSfUewa-0jA5tufe9NCkLZObjrdWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/25/2015 01:25 AM, Carlo Caione wrote:
> On Tue, Nov 24, 2015 at 7:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Wed, Nov 11, 2015 at 09:54:04AM +0100, Carlo Caione wrote:
>>> On Mon, Nov 9, 2015 at 4:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On 11/08/2015 04:18 AM, Carlo Caione wrote:
>>>>>
>>>>> From: Carlo Caione <carlo@endlessm.com>
>>>>>
>>>>> With this patch we refactor the driver code to enable watchdog support
>>>>> for all platforms based on Amlogic meson SoCs.
>>>>> The new default timeout is also now chosen considering the maximum
>>>>> timeout allowed by the SoC.
>>>>>
>>>>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>>>>
>>>>
>>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> Wim,
>>> any (N)ACK on this?
>>>
>> Carlo,
>>
>> Unless I missed it, we still don't have an Ack from a devicetree
>> maintainer for the devicetree changes.
>
> I'm the maintainer for the Meson platform and since the changes are
> trivial I'm going to merge them after the driver is taken in the
> watchdog tree.
>

Ok. I'll add patches 1 and 2 from the series to my -next tree and send
them to Wim with my next pull request.

Guenter

