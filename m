Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33673 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbcHDAaA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Aug 2016 20:30:00 -0400
Received: by mail-oi0-f41.google.com with SMTP id j185so302895547oih.0
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Aug 2016 17:29:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <m2bn19qsy3.fsf@baylibre.com>
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
 <1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
 <578271D3.4080704@roeck-us.net> <7hbn237aw7.fsf@baylibre.com> <m2bn19qsy3.fsf@baylibre.com>
From: Kevin Hilman <khilman@baylibre.com>
Date: Wed, 3 Aug 2016 17:29:13 -0700
Message-ID: <CAOi56cUQaFKYu2jNP0AuLOSNnNramu+DNPc+PH7K0gHDZMf+zA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
To: Guenter Roeck <linux@roeck-us.net>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	devicetree <devicetree@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 3, 2016 at 5:27 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Guenter,
>
> Kevin Hilman <khilman@baylibre.com> writes:
>
>> Guenter Roeck <linux@roeck-us.net> writes:
>>
>>> On 07/10/2016 02:11 AM, Neil Armstrong wrote:
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> Would this go in through one of the arm trees ?
>>
>> You can take the driver through the watchdog tree, but I'll take the DT
>> stuff through the amlogic tree (and submit via arm-soc).
>>
>> However, with your ack, and since this is a brand new driver, I could
>> take the driver as well.  Just let me know your preference.
>
> ping... do you have a prefernce here?
>

Oops, just noticed Wim already picked these up.

Ignore me,

Kevin
