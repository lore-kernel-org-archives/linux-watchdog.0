Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33350 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbcHPBvm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Aug 2016 21:51:42 -0400
Subject: Re: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
To: Kevin Hilman <khilman@baylibre.com>
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
 <1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
 <578271D3.4080704@roeck-us.net> <7hbn237aw7.fsf@baylibre.com>
 <m2bn19qsy3.fsf@baylibre.com>
 <CAOi56cUQaFKYu2jNP0AuLOSNnNramu+DNPc+PH7K0gHDZMf+zA@mail.gmail.com>
 <7hinv1ahqi.fsf@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	devicetree <devicetree@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9cfa549e-1979-cb42-bfe1-1ef347dd3a9a@roeck-us.net>
Date: Mon, 15 Aug 2016 18:51:38 -0700
MIME-Version: 1.0
In-Reply-To: <7hinv1ahqi.fsf@baylibre.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/15/2016 01:40 PM, Kevin Hilman wrote:
> Kevin Hilman <khilman@baylibre.com> writes:
>
>> On Wed, Aug 3, 2016 at 5:27 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>>> Hi Guenter,
>>>
>>> Kevin Hilman <khilman@baylibre.com> writes:
>>>
>>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>>
>>>>> On 07/10/2016 02:11 AM, Neil Armstrong wrote:
>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>
>>>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>>>
>>>>> Would this go in through one of the arm trees ?
>>>>
>>>> You can take the driver through the watchdog tree, but I'll take the DT
>>>> stuff through the amlogic tree (and submit via arm-soc).
>>>>
>>>> However, with your ack, and since this is a brand new driver, I could
>>>> take the driver as well.  Just let me know your preference.
>>>
>>> ping... do you have a prefernce here?
>>>
>>
>> Oops, just noticed Wim already picked these up.
>>
>
> Strange, seems that Wim picked up patches 1 & 3, but this one was missed.  I'll
> queue this for the arm-soc tree.
>

I got a number of requests from arm maintainers to not pick up devicetree changes
for arch/arm, so for my part I usually leave those alone.

Guenter

