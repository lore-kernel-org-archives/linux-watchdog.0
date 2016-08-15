Return-path: <khilman@baylibre.com>
From: Kevin Hilman <khilman@baylibre.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Neil Armstrong <narmstrong@baylibre.com>,  Wim Van Sebroeck <wim@iguana.be>,  devicetree <devicetree@vger.kernel.org>,  lkml <linux-kernel@vger.kernel.org>,  linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,  linux-amlogic@lists.infradead.org,  linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
	<1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
	<578271D3.4080704@roeck-us.net> <7hbn237aw7.fsf@baylibre.com>
	<m2bn19qsy3.fsf@baylibre.com>
	<CAOi56cUQaFKYu2jNP0AuLOSNnNramu+DNPc+PH7K0gHDZMf+zA@mail.gmail.com>
Date: Mon, 15 Aug 2016 13:40:21 -0700
In-Reply-To: <CAOi56cUQaFKYu2jNP0AuLOSNnNramu+DNPc+PH7K0gHDZMf+zA@mail.gmail.com>
	(Kevin Hilman's message of "Wed, 3 Aug 2016 17:29:13 -0700")
Message-ID: <7hinv1ahqi.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Kevin Hilman <khilman@baylibre.com> writes:

> On Wed, Aug 3, 2016 at 5:27 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Hi Guenter,
>>
>> Kevin Hilman <khilman@baylibre.com> writes:
>>
>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>
>>>> On 07/10/2016 02:11 AM, Neil Armstrong wrote:
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>
>>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>>
>>>> Would this go in through one of the arm trees ?
>>>
>>> You can take the driver through the watchdog tree, but I'll take the DT
>>> stuff through the amlogic tree (and submit via arm-soc).
>>>
>>> However, with your ack, and since this is a brand new driver, I could
>>> take the driver as well.  Just let me know your preference.
>>
>> ping... do you have a prefernce here?
>>
>
> Oops, just noticed Wim already picked these up.
>

Strange, seems that Wim picked up patches 1 & 3, but this one was missed.  I'll
queue this for the arm-soc tree.

Kevin
